#!/usr/bin/env bash
# Prueba el skill de punta a punta en un directorio temporal.
# Ejecutar ANTES de cada edición de la formación: el ecosistema cambia debajo.
#
#   bash test-skill.sh
#
# No levanta servicios ni toca Supabase. Solo crea, compila y comprueba.
set -uo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP=$(mktemp -d)
NOMBRE="prueba-builder-lab"
FALLOS=0

ok()   { printf '\033[32m✓\033[0m %s\n' "$1"; }
err()  { printf '\033[31m✗\033[0m %s\n' "$1"; FALLOS=$((FALLOS+1)); }
paso() { printf '\n\033[36m▸ %s\033[0m\n' "$1"; }

trap 'rm -rf "$TMP"' EXIT

echo "Probando el skill en $TMP"

paso "1/7 scaffolding"
if bash "$AQUI/builder-lab-mvp/scripts/init-mvp.sh" "$NOMBRE" "$TMP/$NOMBRE" >"$TMP/init.log" 2>&1; then
  ok "init-mvp.sh termina con éxito"
else
  err "init-mvp.sh falla — últimas líneas:"; tail -15 "$TMP/init.log"; exit 1
fi

cd "$TMP/$NOMBRE"

paso "2/7 ficheros clave"
for f in CLAUDE.md docs/ALCANCE.md prisma/schema.prisma src/lib/db.ts \
         src/lib/env.ts src/styles/tokens.css \
         .env.example check-reglas.sh; do
  [ -f "$f" ] && ok "$f" || err "falta $f"
done
grep -q "Builder Lab" CLAUDE.md && ok "CLAUDE.md es el del skill" \
  || err "CLAUDE.md NO es el del skill (¿lo ha pisado create-next-app?)"
# {{NOMBRE_PROYECTO}} y {{FECHA}} los sustituye el script. El resto ({{ACCION_CORE}},
# {{P0_1}}…) son huecos que rellena la entrevista del día 1: deben seguir ahí.
if grep -rq "{{NOMBRE_PROYECTO}}\|{{FECHA}}" CLAUDE.md README.md docs/ALCANCE.md \
     prisma/schema.prisma src/app/page.tsx src/app/layout.tsx 2>/dev/null; then
  err "el script no ha sustituido {{NOMBRE_PROYECTO}} o {{FECHA}}"
else
  ok "nombre y fecha sustituidos"
fi
# Nada que se ejecute puede llevar placeholders
if grep -rq "{{" src/ 2>/dev/null; then
  err "quedan placeholders dentro de src/ (llegarían a producción)"
else
  ok "src/ sin placeholders"
fi

paso "3/7 el .env no puede acabar en el repo"
grep -qE '^\.env$' .gitignore && ok ".env ignorado por git" || err ".gitignore no protege el .env"

paso "4/7 cliente Prisma al día con el schema"
if grep -q "authId" node_modules/.prisma/client/index.d.ts 2>/dev/null; then
  ok "el cliente conoce los modelos del schema"
else
  err "el cliente Prisma NO corresponde al schema (falta prisma generate)"
fi

paso "5/7 tipos"
if npx tsc --noEmit >"$TMP/tsc.log" 2>&1; then ok "tsc --noEmit limpio"
else err "errores de tipos:"; head -10 "$TMP/tsc.log"; fi

paso "6/7 build de producción"
if npm run build >"$TMP/build.log" 2>&1; then ok "npm run build compila"
else err "el build falla:"; tail -15 "$TMP/build.log"; fi

paso "7/7 reglas del proyecto"
if bash check-reglas.sh >"$TMP/reglas.log" 2>&1; then ok "check-reglas.sh en verde"
else err "check-reglas.sh falla en un proyecto recién creado:"; cat "$TMP/reglas.log"; fi

# el gate no puede mentir
if (cd "$TMP" && bash "$AQUI/builder-lab-mvp/scripts/check-reglas.sh" >/dev/null 2>&1); then
  err "check-reglas.sh da verde fuera de un proyecto (falso positivo)"
else
  ok "check-reglas.sh se niega a correr fuera de un proyecto"
fi

# idempotencia
paso "extra: idempotencia"
if bash "$AQUI/builder-lab-mvp/scripts/init-mvp.sh" "$NOMBRE" "$TMP/$NOMBRE" >"$TMP/init2.log" 2>&1; then
  ok "segunda ejecución sin romper nada"
else
  err "la segunda ejecución falla"; tail -10 "$TMP/init2.log"
fi

echo
if [ "$FALLOS" -eq 0 ]; then
  printf '\033[32mSkill verificado: %s\033[0m\n\n' "todo en verde"; exit 0
else
  printf '\033[31m%d comprobación(es) fallida(s)\033[0m\n\n' "$FALLOS"; exit 1
fi
