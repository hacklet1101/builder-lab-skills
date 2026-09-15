# H0 · Preparado — antes de escribir nada

Tres cuentas y un sitio donde trabajar. Nada de esto cuenta como parte del MVP: si
alguien llega sin ello, se cierra H0 primero y se empieza después.

**Todo se hace desde el navegador.** No hace falta instalar nada en el ordenador.

> **Esto es el resumen de por qué.** El paso a paso para dictar está en las guías:
> `guias/github.md`, `guias/codespaces.md`, `guias/supabase.md` y `guias/local.md`.
> No le leas este documento a la persona: léele la guía.

---

## Las tres cuentas (15 minutos)

Las tres son gratis y ninguna pide tarjeta.

| | Dónde | Qué hay que hacer |
|---|---|---|
| **GitHub** | github.com | Crear la cuenta. Aquí vive el código |
| **Supabase** | supabase.com | Entrar **con GitHub**, crear un proyecto, **guardar la contraseña de la base de datos en un gestor de contraseñas** — no se puede recuperar |
| **Vercel** | vercel.com | Entrar **con GitHub** y darle acceso a **todos** los repositorios ("All repositories"). Así cada repo que crees aparece solo en Vercel y publicar es un clic. Plan gratuito (Hobby) |

Entrar con GitHub en las tres no es un detalle: evita tres contraseñas más y hace que
todo se conecte solo.

**La cuenta de Vercel se crea ahora, no al final.** Con el permiso sobre todos los
repositorios, el proyecto aparece en Vercel en cuanto exista y publicarlo es pulsar un
botón. Dejarlo para el momento de publicar significa encontrarse una lista vacía y
tener que ir a ajustar permisos, que es donde más gente se atasca.

---

## El sitio donde trabajar

Aquí hay dos caminos. **Elige según tu ordenador, no según lo que sepas.**

### Camino A — en la nube (recomendado)

Para quien tenga un ordenador lento o antiguo, trabaje desde el móvil o
simplemente no quiera instalar nada.

**GitHub Codespaces** te da un ordenador de desarrollo dentro del navegador: editor,
terminal y Node ya instalados. El plan gratuito de una cuenta personal incluye horas
de sobra para un MVP (y se pausa solo cuando no lo usas).

1. En GitHub, crea un repositorio **privado** vacío para tu app.
2. En la página del repositorio: botón verde **Code** → pestaña **Codespaces** →
   *Create codespace on main*.
3. Tarda un minuto. Cuando abra, tienes una terminal abajo.
4. Instala Claude Code dentro:
   ```bash
   npm install -g @anthropic-ai/claude-code
   claude
   ```
5. A partir de ahí, todo el trabajo ocurre ahí dentro.

Lo que se cierra, se guarda: el codespace conserva tus ficheros entre sesiones
mientras no lo borres.

> **Desde el móvil:** funciona en el navegador, pero escribir código en una pantalla
> pequeña cansa. Sirve de sobra para revisar, pedirle cosas a Claude y mirar tu app
> publicada; para una jornada larga, mejor una pantalla grande.

### Camino B — en tu ordenador

Si tienes un ordenador que va bien y prefieres trabajar en él.

| | Comprobar con |
|---|---|
| Node 20 o superior | `node -v` |
| npm 10 o superior | `npm -v` |
| git | `git --version` |
| Claude Code | `claude --version` |

Y que git sepa quién eres:

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

**En Windows:** instala WSL2 (`wsl --install` en PowerShell) y trabaja dentro de
Linux, con el proyecto en `~/proyectos`, no en `/mnt/c`. Tarda entre 20 minutos y una
hora. Si eso suena a problema, ve al camino A: te ahorras la tarde entera.

---

## Comprueba que está todo

Desde donde vayas a trabajar, sea la nube o tu ordenador:

```bash
bash ~/builder-lab-skills/builder-lab-mvp/scripts/check-entorno.sh
```

Te dice dónde estás trabajando, qué falta y el comando exacto para arreglarlo.

**Gate de H0:** el script termina en verde y tienes las tres cuentas creadas.

---

## Lo que NO hace falta

- Instalar PostgreSQL: la base de datos está en Supabase.
- Instalar Docker: no se usa.
- Un servidor, un VPS o un dominio: Vercel da la dirección.
- Tarjeta de crédito: nada de esto se paga.
- Saber usar la terminal: Claude Code escribe los comandos.

## Lo que sí conviene traer pensado

- Qué app quieres hacer, en una frase.
- Para quién.
- Qué es lo único que tiene que funcionar al final.

No hace falta tenerlo claro —H1 empieza precisamente afinando eso—, pero llegar en
blanco cuesta una hora.

## Sobre los límites de uso de Claude

En un día intenso se puede llegar al límite del plan. Para que no pase a media tarde:

- `/clear` al cambiar de tarea. El contexto largo se paga en cada mensaje.
- Pide cosas concretas: *"arregla este error en este fichero"*, no *"revisa la app"*.
- No le pidas leer todo el proyecto para algo que ya sabes dónde está.
