#!/usr/bin/env bash
# Instala los skills de Builder Lab en ~/.claude/skills mediante enlaces simbólicos.
# Idempotente: se puede ejecutar tantas veces como haga falta.
#
#   git clone <repo> ~/builder-lab-skills
#   bash ~/builder-lab-skills/install.sh
#
# Para actualizar: git pull en el repo. Los enlaces ya apuntan a la nueva versión.
set -euo pipefail

ORIGEN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINO="$HOME/.claude/skills"

mkdir -p "$DESTINO"

for skill in builder-lab-mvp builder-lab-dia; do
  ruta="$DESTINO/$skill"
  if [ -L "$ruta" ]; then
    rm "$ruta"
  elif [ -e "$ruta" ]; then
    echo "⚠  $ruta existe y no es un enlace. Muévelo o bórralo y vuelve a ejecutar." >&2
    exit 1
  fi
  ln -s "$ORIGEN/$skill" "$ruta"
  echo "✓ $skill → $ruta"
done

echo
echo "Listo. Abre Claude Code y prueba a decir: «quiero arrancar el MVP de mi app»."
