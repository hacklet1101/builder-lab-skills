# Día 0 — antes de empezar

Media hora aquí ahorra media mañana el día 1. Si alguien llega sin esto, **no se
empieza el día 1**: se hace el día 0 y se empieza después.

## Programas

| | Cómo | Comprobar |
|---|---|---|
| Node 20 o superior | nodejs.org, versión LTS | `node -v` |
| npm 10 o superior | viene con Node; si no, `npm install -g npm@latest` | `npm -v` |
| git | git-scm.com | `git --version` |
| Claude Code | claude.com/claude-code | `claude --version` |
| Un editor | VS Code o el que sea | |

Después: `bash builder-lab-mvp/scripts/check-entorno.sh`. Lo comprueba todo y dice
exactamente qué falta.

## Git tiene que saber quién eres

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

Sin esto, el primer commit falla con un mensaje que no se entiende.

## Cuentas

**GitHub** — que puedas crear un repositorio **privado** y subir código. La forma
más rápida es instalar `gh` y hacer `gh auth login`: evita pelearse con claves SSH.

**Supabase** (supabase.com) — crear un proyecto, región la más cercana.
**Guarda la contraseña de la base de datos en un gestor de contraseñas: no se puede
recuperar.** Si se pierde hay que resetearla y reconfigurarlo todo.

**Coolify** — acceso al panel donde vas a desplegar. Compruébalo entrando hoy, no el
día 7.

## Windows

Claude Code y todo lo demás funcionan mejor en **WSL2** (Ubuntu). Instalarlo tarda
entre 20 minutos y una hora según la máquina — por eso es día 0 y no día 1.

```powershell
wsl --install
```

Y a partir de ahí se trabaja **dentro** de WSL, con el proyecto en el sistema de
ficheros de Linux (`~/proyectos`), no en `/mnt/c`. En `/mnt/c` todo va varias veces
más lento y algunas cosas fallan raro.

## Límites de uso de Claude

Con el plan de pago hay un límite por ventana de tiempo. En un día intenso se puede
alcanzar. Para que no pase a media tarde:

- `/clear` al cambiar de feature. El contexto largo se paga en cada mensaje.
- Pedir cosas concretas: "arregla el error X en el fichero Y", no "revisa la app".
- No pedirle que lea toda la base de código para algo que ya sabes dónde está.

## Lo que hay que traer pensado (no decidido)

- Qué app quieres hacer, en una frase.
- Para quién.
- Qué es lo único que tiene que funcionar el día 7.

No hace falta tenerlo claro: el día 1 empieza precisamente afinando eso. Pero llegar
en blanco cuesta una hora.
