#!/usr/bin/env bash
# Builder Lab — comprueba dónde estás trabajando y qué falta.
# Funciona igual en tu ordenador que en un espacio de trabajo en la nube.
# No instala nada ni levanta servicios: solo mira y dice.
set -uo pipefail

OK=0; FALLOS=0
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; OK=$((OK+1)); }
fail() { printf '  \033[31m✗\033[0m %s\n     → %s\n' "$1" "$2"; FALLOS=$((FALLOS+1)); }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }

# `timeout` no existe en macOS
if command -v timeout >/dev/null 2>&1; then con_limite() { timeout 10 "$@"; }
else con_limite() { "$@"; }; fi

echo
echo "Builder Lab — comprobando tu entorno"
echo "────────────────────────────────────"

# ── Dónde estamos ──────────────────────────────────────────────────────────
if [ -n "${CODESPACES:-}" ]; then
  DONDE="GitHub Codespaces"
elif [ -n "${GITPOD_WORKSPACE_ID:-}" ]; then
  DONDE="Gitpod"
elif [ -f /.dockerenv ] || grep -qa 'docker\|containerd' /proc/1/cgroup 2>/dev/null; then
  DONDE="un contenedor en la nube"
else
  DONDE="tu ordenador"
fi
printf '  \033[90mEstás trabajando en: %s\033[0m\n\n' "$DONDE"

# ── Herramientas ───────────────────────────────────────────────────────────
if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -v | sed 's/^v//' | cut -d. -f1)
  if [ "$NODE_MAJOR" -ge 20 ]; then ok "Node $(node -v)"
  else fail "Node $(node -v) es demasiado antiguo" "Necesitas Node 20 o superior"; fi
else
  fail "Node no está instalado" "Si estás en tu ordenador: nodejs.org (versión LTS). Si estás en la nube, algo va mal en el espacio de trabajo"
fi

if command -v npm >/dev/null 2>&1; then
  NPM_MAJOR=$(npm -v | cut -d. -f1)
  if [ "$NPM_MAJOR" -ge 10 ]; then ok "npm $(npm -v)"
  else fail "npm $(npm -v) es demasiado antiguo" "npm install -g npm@latest"; fi
else
  fail "npm no está instalado" "Viene con Node"
fi

if command -v git >/dev/null 2>&1; then
  ok "git $(git --version | awk '{print $3}')"
  git config --get user.email >/dev/null 2>&1 \
    || fail "git no sabe quién eres" "git config --global user.email 'tu@email.com' && git config --global user.name 'Tu Nombre'"
else
  fail "git no está instalado" "https://git-scm.com/downloads"
fi

# ── GitHub ─────────────────────────────────────────────────────────────────
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  ok "GitHub conectado ($(gh api user --jq .login 2>/dev/null || echo 'cuenta verificada'))"
elif con_limite ssh -T -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
        -o ConnectTimeout=5 git@github.com 2>&1 | grep -q "successfully authenticated"; then
  ok "GitHub por SSH"
else
  warn "No se ha podido verificar el acceso a GitHub."
  warn "  Comprueba que puedes subir código a un repositorio privado."
fi

# ── Red ────────────────────────────────────────────────────────────────────
curl -s --max-time 5 https://registry.npmjs.org >/dev/null 2>&1 \
  && ok "Conexión a npm" || fail "Sin acceso a npm" "Revisa tu conexión o proxy"

# Prisma descarga sus engines de aquí. En redes con proxy falla justo esto, y el
# error que da no menciona la red por ningún lado.
curl -s --max-time 8 -o /dev/null https://binaries.prisma.sh \
  && ok "Conexión a los binarios de Prisma" \
  || fail "Sin acceso a binaries.prisma.sh" "Prisma no podrá descargar sus engines. Si estás en una red corporativa o con VPN, prueba desde otra red"

# ── Cuentas ────────────────────────────────────────────────────────────────
echo
echo "Cuentas que necesitas (compruébalas tú, se hacen todas desde el navegador):"
echo "  □ GitHub   — puedes crear repositorios privados"
echo "  □ Supabase — supabase.com, proyecto creado, contraseña de la BD guardada"
echo "  □ Vercel   — vercel.com, cuenta creada CON GitHub y con acceso a TODOS"
echo "               los repositorios (así el tuyo aparece solo al publicar)"
echo

echo "────────────────────────────────────"
if [ "$FALLOS" -eq 0 ]; then
  printf '\033[32mEntorno listo\033[0m (%d comprobaciones, en %s)\n\n' "$OK" "$DONDE"
  exit 0
else
  printf '\033[31m%d problema(s)\033[0m — arréglalos antes de empezar.\n\n' "$FALLOS"
  exit 1
fi
