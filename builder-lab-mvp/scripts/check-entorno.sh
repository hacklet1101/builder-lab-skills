#!/usr/bin/env bash
# Builder Lab — verificación de entorno. Ejecutar ANTES del día 1.
# No instala nada ni levanta servicios: solo comprueba y dice qué falta.
set -uo pipefail

OK=0; FALLOS=0
ok()   { printf '  \033[32m✓\033[0m %s\n' "$1"; OK=$((OK+1)); }
fail() { printf '  \033[31m✗\033[0m %s\n     → %s\n' "$1" "$2"; FALLOS=$((FALLOS+1)); }
warn() { printf '  \033[33m!\033[0m %s\n' "$1"; }

echo
echo "Builder Lab — comprobando tu entorno"
echo "────────────────────────────────────"

# Node
if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -v | sed 's/^v//' | cut -d. -f1)
  if [ "$NODE_MAJOR" -ge 20 ]; then
    ok "Node $(node -v)"
  else
    fail "Node $(node -v) es demasiado antiguo" "Instala Node 20 o superior desde nodejs.org"
  fi
else
  fail "Node no está instalado" "Instálalo desde nodejs.org (versión LTS)"
fi

# npm
if command -v npm >/dev/null 2>&1; then
  NPM_MAJOR=$(npm -v | cut -d. -f1)
  if [ "$NPM_MAJOR" -ge 10 ]; then
    ok "npm $(npm -v)"
  else
    fail "npm $(npm -v) es demasiado antiguo para Node 20+" "npm install -g npm@latest  (npm 9 falla al instalar paquetes encadenados)"
  fi
else
  fail "npm no está instalado" "Viene con Node; reinstala Node"
fi

# git
if command -v git >/dev/null 2>&1; then
  ok "git $(git --version | awk '{print $3}')"
  git config --get user.email >/dev/null 2>&1 \
    || fail "git no sabe quién eres" "git config --global user.email 'tu@email.com' && git config --global user.name 'Tu Nombre'"
else
  fail "git no está instalado" "https://git-scm.com/downloads"
fi

# GitHub
# BatchMode + timeout: sin esto, en un equipo nuevo ssh pregunta por la clave
# del host y el script se queda esperando input para siempre.
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1; then
  ok "GitHub CLI autenticado"
elif timeout 10 ssh -T -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
        -o ConnectTimeout=5 git@github.com 2>&1 | grep -q "successfully authenticated"; then
  ok "GitHub por SSH"
else
  warn "No se ha podido verificar el acceso a GitHub."
  warn "  Comprueba que puedes hacer push a un repo privado antes de empezar."
fi

# Claude Code
command -v claude >/dev/null 2>&1 && ok "Claude Code instalado" \
  || fail "Claude Code no está en el PATH" "https://claude.com/claude-code"

# Conexión
curl -s --max-time 5 https://registry.npmjs.org >/dev/null 2>&1 \
  && ok "Conexión a internet" \
  || fail "Sin acceso a npm" "Revisa tu conexión o proxy"

echo
echo "Cuentas que necesitas (compruébalas tú, no puedo verificarlas):"
echo "  □ Supabase — supabase.com, proyecto creado, contraseña de BD guardada"
echo "  □ Coolify  — acceso al panel donde vas a desplegar"
echo "  □ GitHub   — puedes crear repositorios privados"
echo

echo "────────────────────────────────────"
if [ "$FALLOS" -eq 0 ]; then
  printf '\033[32mEntorno listo\033[0m (%d comprobaciones)\n\n' "$OK"
  exit 0
else
  printf '\033[31m%d problema(s)\033[0m — arréglalos antes de empezar el día 1.\n\n' "$FALLOS"
  exit 1
fi
