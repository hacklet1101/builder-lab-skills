#!/usr/bin/env bash
# Builder Lab — comprueba que el proyecto respeta sus propias reglas.
# Se ejecuta desde la raíz del proyecto:  npm run check
#
# Inspirado en los gates anti-hardcode de proyectos grandes: la regla que no se
# comprueba con un script, no se cumple.
set -uo pipefail

FALLOS=0
err()  { printf '  \033[31m✗\033[0m %s\n' "$1"; FALLOS=$((FALLOS+1)); }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; }
avisa(){ printf '  \033[33m!\033[0m %s\n' "$1"; }
linea(){ printf '     \033[90m%s\033[0m\n' "$1"; }

echo
echo "Builder Lab — reglas del proyecto"
echo "─────────────────────────────────"

# ── 0. Estamos donde creemos ───────────────────────────────────────────────
# Sin esto, los grep sobre rutas inexistentes salen vacíos y todo da "verde".
if [ ! -f package.json ] || [ ! -d src ]; then
  printf '\033[31m✗ Esto no parece la raíz de un proyecto Builder Lab\033[0m\n'
  printf '  Faltan package.json o src/. Ejecútalo desde la carpeta del proyecto.\n\n'
  exit 2
fi
N_FICHEROS=$(find src -type f \( -name '*.ts' -o -name '*.tsx' \) | wc -l | tr -d ' ')
if [ "$N_FICHEROS" -eq 0 ]; then
  printf '\033[31m✗ No hay ningún .ts/.tsx dentro de src/\033[0m — nada que comprobar.\n\n'
  exit 2
fi
printf '  \033[90m%s ficheros analizados\033[0m\n' "$N_FICHEROS"

# ── 1. La frontera: src/app no habla con la base de datos ──────────────────
# Cubre el alias (@/lib/db) y los imports relativos (../../lib/db)
HITS=$(grep -rnE "from ['\"](@/lib/db|@prisma/client|\.{1,2}/[^'\"]*lib/db)['\"]" src/app 2>/dev/null || true)
if [ -n "$HITS" ]; then
  err "src/app importa la base de datos directamente"
  echo "$HITS" | head -5 | while IFS= read -r l; do linea "$l"; done
  linea "→ mueve la query a src/modules/<feature>/<feature>.service.ts"
else
  ok "frontera app ↔ base de datos respetada"
fi

# ── 2. SQL crudo prohibido ─────────────────────────────────────────────────
HITS=$(grep -rnE '\$(query|execute)RawUnsafe' src 2>/dev/null || true)
if [ -n "$HITS" ]; then
  err "hay SQL crudo sin parametrizar (\$queryRawUnsafe / \$executeRawUnsafe)"
  echo "$HITS" | head -5 | while IFS= read -r l; do linea "$l"; done
else
  ok "sin SQL crudo sin parametrizar"
fi

# ── 3. Estilos fuera de los tokens (hex, rgb y clases arbitrarias) ─────────
PATRON_COLOR='#[0-9a-fA-F]{3,8}([^0-9a-fA-F]|$)|\b(rgb|rgba|hsl|hsla|oklch|oklab)\('
PATRON_ARBITRARIO='\b(bg|text|border|p[xytblr]?|m[xytblr]?|w|h|gap|rounded|shadow|fill|stroke|leading|tracking|grid-cols|grid-rows|min-h|max-h|min-w|max-w|top|right|bottom|left|inset|z|translate-[xy]?|scale|rotate|opacity|size)-\['
DIRS=""
for d in src/app src/modules src/components; do [ -d "$d" ] && DIRS="$DIRS $d"; done
HITS=$(grep -rnE "$PATRON_COLOR|$PATRON_ARBITRARIO" --include='*.tsx' --include='*.ts' $DIRS 2>/dev/null || true)
N=$(printf '%s' "$HITS" | grep -c . || true)
if [ "$N" -gt 0 ]; then
  err "$N estilo(s) fuera de los tokens (color suelto o clase arbitraria [..])"
  echo "$HITS" | head -5 | while IFS= read -r l; do linea "$l"; done
  linea "→ añádelo a @theme en src/styles/tokens.css y úsalo por nombre"
else
  ok "estilos solo desde los tokens"
fi

# ── 4. Secretos ────────────────────────────────────────────────────────────
EN_GIT=""
for f in .env .env.local .env.production .env.development; do
  git ls-files --error-unmatch "$f" >/dev/null 2>&1 && EN_GIT="$EN_GIT $f"
done
if [ -n "$EN_GIT" ]; then
  err "fichero(s) de entorno EN GIT:$EN_GIT"
  linea "git rm --cached$EN_GIT  y rota TODAS las claves que contengan"
elif ! git rev-parse --git-dir >/dev/null 2>&1; then
  avisa "esto no es un repositorio git todavía — no se ha podido comprobar el .env"
else
  ok "ficheros de entorno fuera de git"
fi

# Secreto expuesto al navegador: por nombre de variable...
HITS=$(grep -rnE 'NEXT_PUBLIC_[A-Z_]*(SECRET|SERVICE_ROLE|PASSWORD|PRIVATE|TOKEN)' src 2>/dev/null || true)
# ...y por contenido: una service_role key de Supabase es un JWT que lo lleva dentro
if [ -f .env ]; then
  while IFS= read -r v; do
    case "$v" in NEXT_PUBLIC_*) 
      val="${v#*=}"
      payload=$(printf '%s' "$val" | tr -d '"' | cut -d. -f2 2>/dev/null || true)
      if [ -n "$payload" ] && printf '%s' "$payload" | base64 -d 2>/dev/null | grep -q 'service_role'; then
        HITS="$HITS
.env: ${v%%=*} contiene una clave service_role"
      fi ;;
    esac
  done < <(grep -E '^NEXT_PUBLIC_' .env 2>/dev/null || true)
fi
if [ -n "$(printf '%s' "$HITS" | grep -c . )" ] && [ "$(printf '%s' "$HITS" | grep -c .)" -gt 0 ]; then
  err "un secreto está expuesto al navegador (prefijo NEXT_PUBLIC_)"
  echo "$HITS" | head -3 | while IFS= read -r l; do linea "$l"; done
  linea "→ quítale el prefijo NEXT_PUBLIC_ y rota la clave: ya ha estado en el bundle"
else
  ok "sin secretos expuestos al navegador"
fi

# ── 5. Autorización: queries sin filtro de propietario (aviso) ─────────────
SOSPECHA=$(grep -rnE 'find(Unique|First)\(\{\s*where:\s*\{\s*id[,:}]' src/modules 2>/dev/null | head -5 || true)
if [ -n "$SOSPECHA" ]; then
  avisa "revisa a mano: queries que buscan solo por id"
  echo "$SOSPECHA" | while IFS= read -r l; do linea "$l"; done
  linea "→ si el dato pertenece a un usuario, filtra también por su id de sesión"
fi

echo "─────────────────────────────────"
if [ "$FALLOS" -eq 0 ]; then
  printf '\033[32mTodo en orden\033[0m\n\n'; exit 0
else
  printf '\033[31m%d regla(s) rota(s)\033[0m — arréglalo antes de cerrar el día.\n\n' "$FALLOS"; exit 1
fi
