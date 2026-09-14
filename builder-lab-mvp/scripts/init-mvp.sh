#!/usr/bin/env bash
# Builder Lab — scaffolding del MVP. Idempotente. Linux y macOS.
#
#   ./init-mvp.sh <nombre-proyecto> [directorio-destino]
#
# No levanta ningún servicio. No toca Supabase. Solo crea ficheros locales.
set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATES="$SKILL_DIR/templates"

NOMBRE="${1:-}"
if [ -z "$NOMBRE" ]; then
  echo "Uso: ./init-mvp.sh <nombre-proyecto> [directorio-destino]" >&2
  exit 1
fi
# npm no acepta mayúsculas ni espacios en el nombre del paquete, y create-next-app
# falla con un error que no dice eso.
case "$NOMBRE" in
  *[![:alnum:]-]*|*[A-Z]*|-*|"")
    echo "Nombre no válido: «$NOMBRE»" >&2
    echo "Usa solo minúsculas, números y guiones. Ejemplo: reservas-gimnasio" >&2
    exit 1 ;;
esac
DESTINO="${2:-$(pwd)/$NOMBRE}"

info() { printf '\033[36m▸\033[0m %s\n' "$1"; }
skip() { printf '  \033[90m· %s (ya existe, se salta)\033[0m\n' "$1"; }
done_() { printf '  \033[32m✓\033[0m %s\n' "$1"; }

# sed -i portable entre GNU y BSD
sedi() { sed -i.blbak "$@" && rm -f "${@: -1}.blbak"; }

# npm 9 revienta al instalar el CLI de prisma ("Cannot read properties of null
# (reading 'edgesOut')"). Si el npm del sistema es viejo, usamos npm 10 vía npx.
NPM_MAJOR=$(npm -v 2>/dev/null | cut -d. -f1 || echo 0)
if [ "${NPM_MAJOR:-0}" -ge 10 ]; then
  npm_run() { npm "$@"; }
else
  printf '  \033[33m!\033[0m npm %s es antiguo; se usará npm 10 vía npx.\n' "$(npm -v)"
  printf '     Actualízalo cuando puedas:  npm install -g npm@latest\n'
  npm_run() { npx --yes npm@10 "$@"; }
fi

echo
info "Creando el MVP «$NOMBRE» en $DESTINO"
echo

# ── 1. Proyecto Next.js ────────────────────────────────────────────────────
# create-next-app aborta si el destino ya tiene ficheros suyos (CLAUDE.md, prisma/,
# docs/…). Si alguien ya empezó a escribir ahí, los apartamos, creamos el proyecto
# y los devolvemos encima: lo que escribió la persona manda sobre las plantillas.
RESCATE=""
RESCATADOS=""
if [ ! -f "$DESTINO/package.json" ] && [ -d "$DESTINO" ]; then
  for x in CLAUDE.md prisma docs README.md .env .env.example; do
    [ -e "$DESTINO/$x" ] || continue
    [ -n "$RESCATE" ] || RESCATE=$(mktemp -d)
    mv "$DESTINO/$x" "$RESCATE/"
    RESCATADOS="$RESCATADOS $x"
  done
  [ -n "$RESCATE" ] && info "Aparto lo que ya había en el destino para no perderlo"
fi

if [ -f "$DESTINO/package.json" ]; then
  skip "proyecto Next.js"
else
  info "Creando proyecto Next.js (esto tarda un par de minutos)…"
  npx --yes create-next-app@latest "$DESTINO" \
    --typescript --tailwind --eslint --app --src-dir \
    --import-alias "@/*" --use-npm --disable-git --no-agents-md
  done_ "Next.js creado"
fi

if [ -n "$RESCATE" ]; then
  # -n: si create-next-app creó un README propio, gana el de la persona
  cp -Rf "$RESCATE"/. "$DESTINO"/
  rm -rf "$RESCATE"
  done_ "restaurado lo que ya habías escrito"
fi

cd "$DESTINO"

# ── 2. Dependencias ────────────────────────────────────────────────────────
if [ -d node_modules/@prisma/client ] && [ -d node_modules/zod ] && [ -d node_modules/server-only ]; then
  skip "dependencias"
else
  info "Instalando Prisma, zod y Supabase…"
  # Una sola invocación: npm 9 falla ("edgesOut") si se encadenan instalaciones.
  # Prisma fijado a la major 6 a propósito:
  #   · el 'latest' del registro apunta a un RC de la 8 que rompe npm
  #   · la 7 saca las URLs del schema y exige driver adapters + prisma.config.ts,
  #     más piezas de las que un MVP de 7 días puede permitirse
  npm_run install @prisma/client@6 prisma@6 zod @supabase/ssr @supabase/supabase-js server-only tsx
  done_ "dependencias instaladas"
fi

# ── 3. Estructura de carpetas ──────────────────────────────────────────────
info "Creando estructura"
mkdir -p src/modules src/lib src/components/ui src/styles prisma docs
mkdir -p "src/app/(auth)/login"
done_ "carpetas"

# ── 4. Ficheros base (no se sobrescribe nada) ──────────────────────────────
copiar() {  # copiar <origen> <destino>
  if [ -f "$2" ]; then skip "$2"; else cp "$TEMPLATES/$1" "$2"; done_ "$2"; fi
}
pisar() {  # pisar <origen> <destino>: la plantilla sustituye a la de create-next-app
  # Lo que ya habías escrito tú y rescatamos en el paso 1 no se toca.
  case " $RESCATADOS " in *" $2 "*) skip "$2 (lo tuyo manda)"; return ;; esac
  cp "$TEMPLATES/$1" "$2"; done_ "$2"
}
info "Copiando plantillas"
pisar  CLAUDE.md       CLAUDE.md
pisar  README.md       README.md
copiar ALCANCE.md      docs/ALCANCE.md
copiar env.example     .env.example
copiar schema.prisma   prisma/schema.prisma
copiar seed.ts         prisma/seed.ts
copiar env.ts          src/lib/env.ts
copiar db.ts           src/lib/db.ts
copiar tokens.css      src/styles/tokens.css
copiar auth.ts         src/lib/auth.ts
copiar proxy.ts        src/proxy.ts
copiar login-page.tsx  "src/app/(auth)/login/page.tsx"
copiar login-actions.ts "src/app/(auth)/login/actions.ts"


# el verificador de reglas vive en el proyecto, no en el skill
if [ -f check-reglas.sh ]; then skip "check-reglas.sh"; else
  cp "$SKILL_DIR/scripts/check-reglas.sh" check-reglas.sh && chmod +x check-reglas.sh
  done_ "check-reglas.sh"
fi

# .gitignore: se fusiona, no se sobrescribe
if grep -q '^\.env$' .gitignore 2>/dev/null; then
  skip ".gitignore (.env ya ignorado)"
else
  cat "$TEMPLATES/gitignore" >> .gitignore
  done_ ".gitignore (.env protegido)"
fi

# .env a partir del ejemplo
if [ -f .env ]; then skip ".env"; else cp .env.example .env; done_ ".env creado (hay que rellenarlo)"; fi

# ── 5b. Tokens de diseño (Tailwind 4) ──────────────────────────────────────
# globals.css se reemplaza entero: el de create-next-app trae colores hex de
# ejemplo que contradicen la regla de tokens.
if [ -f src/app/globals.css ] && ! grep -q "tokens.css" src/app/globals.css; then
  rm -f src/app/globals.css
fi
if [ ! -f src/app/globals.css ] || ! grep -q "tokens.css" src/app/globals.css; then
  cp "$TEMPLATES/globals.css" src/app/globals.css
  done_ "globals.css con tokens de diseño"
else
  skip "globals.css"
fi

# La portada de create-next-app trae colores hex y fuentes propias: se reemplaza
# por una limpia para que check-reglas.sh esté en verde desde el día 1.
for f in page.tsx layout.tsx; do
  if grep -q "{{NOMBRE_PROYECTO}}\|Builder Lab" "src/app/$f" 2>/dev/null; then
    skip "src/app/$f"
  else
    rm -f "src/app/$f"
    cp "$TEMPLATES/$f" "src/app/$f"
    done_ "src/app/$f"
  fi
done

# ── 5. Placeholders ────────────────────────────────────────────────────────
FECHA=$(date +%Y-%m-%d)
for f in CLAUDE.md README.md docs/ALCANCE.md prisma/schema.prisma src/app/page.tsx src/app/layout.tsx; do
  [ -f "$f" ] && sedi "s|{{NOMBRE_PROYECTO}}|$NOMBRE|g; s|{{FECHA}}|$FECHA|g" "$f"
done
done_ "nombre y fecha aplicados"

# ── 6. Scripts de package.json ─────────────────────────────────────────────
info "Añadiendo scripts"
node - <<'NODE'
const fs = require('fs')
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'))
pkg.scripts = {
  ...pkg.scripts,
  build: 'prisma generate && next build',
  check: 'bash check-reglas.sh && tsc --noEmit',
  seed: 'tsx prisma/seed.ts',
  'db:push': 'prisma db push',
  'db:studio': 'prisma studio',
  'db:generate': 'prisma generate',
}
pkg.prisma = { seed: 'tsx prisma/seed.ts' }
pkg.builderLab = {
  kit: 'builder-lab-mvp',
  version: '1.0.0',
  mark: 'hacklet-2026',
  created: new Date().toISOString().slice(0, 10),
}
fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n')
NODE
done_ "scripts"

# ── 7b. Cliente Prisma ─────────────────────────────────────────────────────
# Obligatorio: el postinstall de @prisma/client generó un cliente vacío ANTES de
# que existiera nuestro schema. Sin esto, el editor no conoce db.user ni los tipos.
info "Generando el cliente Prisma"
if npx --yes prisma generate >/dev/null 2>&1; then
  done_ "cliente Prisma al día con el schema"
else
  printf '  \033[33m!\033[0m no se ha podido generar el cliente; ejecuta  npx prisma generate\n'
fi

# ── 8. Primer commit ───────────────────────────────────────────────────────
[ -d .git ] || git init -q
if [ -z "$(git status --porcelain)" ] && git rev-parse HEAD >/dev/null 2>&1; then
  skip "nada nuevo que commitear"
else
  info "Commit"
  git add -A
  git commit -qm "chore: arranque del MVP con builder-lab-mvp"
  done_ "commit hecho"
fi

# red de seguridad: .env nunca en git
if git ls-files --error-unmatch .env >/dev/null 2>&1; then
  git rm --cached -q .env
  git commit -qm "chore: sacar .env del repositorio"
  printf '  \033[33m!\033[0m .env estaba en git y se ha sacado\n'
fi

# ── 9. Qué falta ───────────────────────────────────────────────────────────
cat <<FIN

────────────────────────────────────────────────────────────
Proyecto creado en $DESTINO

Falta esto, y lo tienes que hacer tú (no lo hace el script):

  0. Si tu app NO tiene usuarios: borra src/proxy.ts y src/app/(auth)
  1. Crear el proyecto en supabase.com y guardar la contraseña de la BD
  2. Copiar DATABASE_URL, DIRECT_URL, NEXT_PUBLIC_SUPABASE_URL y
     NEXT_PUBLIC_SUPABASE_ANON_KEY al fichero .env
  3. npx prisma db push        (crea las tablas)
  4. npm run dev               (comprobar que arranca)
  5. Subir el repo a GitHub (privado) e importarlo en vercel.com — HOY, día 1

────────────────────────────────────────────────────────────
FIN
