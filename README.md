# Builder Lab — skills para construir tu MVP en 7 días

Dos skills de Claude Code que llevan a alguien **sin experiencia previa** de una idea
a una app desplegada y funcionando, en una semana.

No es un tutorial ni una plantilla: son instrucciones que Claude Code lee y sigue.
Le dicen qué preguntarte, qué construir, qué **no** construir, y cuándo parar.

| Skill | Cuándo se usa |
|---|---|
| **`builder-lab-mvp`** | El día 1. Entrevista, recorta el alcance, diseña el modelo de datos y monta el proyecto entero |
| **`builder-lab-dia`** | Los días 2 a 7. Abre el día, elige qué toca, cierra el día con el trabajo desplegado |

---

## Qué vas a tener al final

Una aplicación web real, con su dirección en internet, que cualquiera puede abrir:
con registro y login, con datos que se guardan de verdad, y que funciona en el móvil.

Y algo igual de importante: **una sola cosa que funciona bien**, en vez de cinco a
medias. El kit está diseñado para impedir lo segundo.

## El stack, y por qué no se elige

| Pieza | Qué es |
|---|---|
| **Next.js** (App Router) + TypeScript | La aplicación: pantallas y servidor en un mismo proyecto |
| **PostgreSQL en Supabase** | La base de datos. Gratis, sin instalar nada |
| **Prisma** | Cómo habla la app con la base de datos |
| **Supabase Auth** | Registro, login y recuperar contraseña, ya resueltos |
| **Tailwind 4** | Los estilos |
| **Vercel** (plan gratuito) | Donde vive la app. Cada `git push` la publica |

Está cerrado a propósito. No porque sea el único bueno, sino porque es el que se
puede arreglar cuando algo se rompe el jueves a las once de la noche.

---

## Antes de empezar (día 0)

Esto **no** es parte de los 7 días. Hazlo antes o perderás media mañana.

### Programas

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

### Cuentas

- **GitHub** — que puedas crear un repositorio privado y subir código.
- **Supabase** (supabase.com) — un proyecto creado. **Guarda la contraseña de la
  base de datos en un gestor de contraseñas: no se puede recuperar.**
- **Vercel** (vercel.com) — crea la cuenta **con GitHub**, plan gratuito. Sin tarjeta.

### Si usas Windows

Instala WSL2 (`wsl --install`) y trabaja dentro de Linux, con el proyecto en
`~/proyectos`, no en `/mnt/c`. Tarda entre 20 minutos y una hora: por eso es día 0.

---

## Instalación

```bash
git clone https://github.com/hacklet1101/builder-lab-skills.git ~/builder-lab-skills
bash ~/builder-lab-skills/install.sh
```

Crea enlaces en `~/.claude/skills/`. Para actualizar más adelante: `git pull` dentro
de esa carpeta. No hay que reinstalar nada.

### Comprueba que tu equipo está listo

```bash
bash ~/builder-lab-skills/builder-lab-mvp/scripts/check-entorno.sh
```

Te dice exactamente qué falta y el comando para arreglarlo. Si sale algo en rojo,
arréglalo antes del día 1.

---

## Cómo se usa

### Día 1

Abre una terminal en la carpeta donde quieras el proyecto, arranca Claude Code y
escribe algo como:

> **quiero arrancar el MVP de mi app**

La skill se activa sola. A partir de ahí, Claude te lleva por seis pasos:

1. **Entorno** — comprueba que no falta nada.
2. **Entrevista** — seis preguntas sobre tu producto. La que importa es:
   *si el día 7 solo funciona una cosa, ¿cuál tiene que ser?*
3. **Scaffolding** — monta el proyecto entero: estructura, dependencias, login,
   base de datos, primer commit.
4. **Alcance** — escribe `docs/ALCANCE.md`: qué se construye (P0), qué estaría bien
   (P1), qué es adorno (P2) y **qué no se hace**. Lo apruebas tú.
5. **Modelo de datos** — las tablas, explicadas en español antes de escribirlas.
6. **Deploy vacío** — sí, el día 1, con la app vacía. Sales del día 1 con una URL
   pública que funciona.

Cuando termine tendrás un `CLAUDE.md` en tu proyecto: ese fichero es el que hace que
Claude siga tus convenciones en todas las sesiones siguientes, sin que se lo repitas.

### Días 2 a 7

Cada mañana, en la carpeta del proyecto:

> **empezamos el día 3** · **qué toca hoy** · **sigo con el MVP**

La skill lee tu `ALCANCE.md`, mira qué se hizo ayer y te dice qué toca. Al acabar el
día cierra: commit, push, y comprobar la URL pública.

### Los seis hitos

La promesa son 7 días, pero el progreso se mide en hitos. Si vas un día por detrás no
has fallado: estás en el hito anterior y sabes qué te falta.

| Hito | Qué significa | Día objetivo |
|---|---|---|
| **H1 · Arranca** | Alcance, modelo y una URL pública vacía | 1 |
| **H2 · Se entra y se ve** | Login funciona y se ven datos en pantalla | 2 |
| **H3 · Se escribe** | Creas algo desde la app y se guarda | 3 |
| **H4 · P0 completo** | La acción core funciona entera | 4 |
| **H5 · No se rompe** | Errores, pantallas vacías, validaciones | 5 |
| **H6 · Presentable** | Móvil, seguridad, datos de demo y guion | 6-7 |

**H4 es el que decide si hay MVP.** Si al acabar el día 5 no está cerrado, se borra
todo el P2 y se sigue con lo esencial. Ese acuerdo se firma el día 1, no el día 5.

---

## Tu proyecto por dentro

```
mi-app/
  CLAUDE.md                 tus convenciones. Claude lo lee en cada sesión
  docs/ALCANCE.md           qué se construye y qué no
  check-reglas.sh           comprueba que el proyecto cumple sus reglas
  prisma/
    schema.prisma           las tablas
    seed.ts                 datos de ejemplo
  src/
    app/                    las páginas y las rutas
    modules/<feature>/      la lógica, por funcionalidad
    lib/                    base de datos, sesión, variables de entorno
    components/ui/          componentes compartidos
    styles/tokens.css       colores y espaciados (el único sitio)
```

**La regla que sostiene todo:** `src/app` nunca habla con la base de datos. Solo
llama a funciones de `src/modules/<feature>/<feature>.service.ts`. Así, el día que el
proyecto crezca, la lógica se mueve entera sin reescribirla.

### Comandos del proyecto

| Comando | Qué hace |
|---|---|
| `npm run dev` | Arranca la app en tu ordenador |
| `npm run check` | Comprueba que el proyecto cumple sus reglas y sus tipos |
| `npm run seed` | Rellena la base de datos con datos de ejemplo |
| `npm run db:push` | Aplica los cambios del modelo a la base de datos |
| `npm run db:studio` | Abre un panel visual de tus datos |

`npm run check` es el que hay que ejecutar al cerrar cada día. En dos segundos dice si:

- alguna página habla con la base de datos saltándose la estructura
- hay colores sueltos fuera de los tokens de diseño
- hay algún fichero de claves dentro de git, o un secreto expuesto al navegador
- hay consultas que buscan por `id` sin comprobar de quién es el dato

---

## Cuando algo va mal

| Situación | Dónde mirar |
|---|---|
| Llevas 3 intentos con el mismo error | `builder-lab-dia/references/atascos.md` |
| Claude repite lo mismo una y otra vez | Para, `/clear`, y vuelve con el error exacto pegado |
| El deploy falla en Vercel | `builder-lab-mvp/references/deploy.md`, sección "Cuando el deploy falla" |
| Producción está rota | Vercel → Deployments → el último que funcionaba → Promote to Production |
| No te va a dar tiempo | No es una emergencia, es el plan: el corte de alcance está en `builder-lab-dia/SKILL.md` |
| Se te ha subido una clave a git | `builder-lab-mvp/references/seguridad-mvp.md`. **Primero rotar, después limpiar git** |

---

## Para quien da la formación

### Probar el kit antes de cada edición

```bash
bash test-skill.sh
```

Crea un proyecto en un directorio temporal, lo compila, comprueba los tipos, valida
las reglas y verifica que el script es idempotente. El ecosistema cambia debajo
—versiones de Next, de Prisma, de Tailwind— y este comando es lo que avisa antes de
que se entere un alumno.

### Qué hay en el repo

```
builder-lab-mvp/
  SKILL.md              el flujo del día 1
  references/           día 0, alcance, modelo de datos, estructura, supabase,
                        seguridad, deploy, antipatrones, plan de 7 días
  templates/            CLAUDE.md, ALCANCE.md, schema.prisma, auth, proxy, login,
                        tokens, seed, env, db…
  scripts/              check-entorno.sh, init-mvp.sh, check-reglas.sh
builder-lab-dia/
  SKILL.md              el ritual diario y el protocolo de corte
  references/           los seis hitos, atascos, demo
test-skill.sh           prueba el kit de punta a punta
install.sh              enlaza los skills en ~/.claude/skills
```

### Las decisiones que ya están tomadas

- **Sin migraciones de Prisma.** `db push` toda la semana: la base de datos es la
  misma en local y en producción.
- **Sin tests automáticos.** El gate es recorrer el camino core en producción con una
  cuenta recién creada, que es lo que de verdad encuentra los fallos.
- **Auth desde el día 1** si el producto tiene usuarios. Meterla el día 6 obliga a
  reescribir cada consulta.
- **Deploy desde el día 1**, con la app vacía. Desplegar por primera vez el día 7 es
  la causa número uno de terminar sin MVP.

---

## Licencia

MIT. Úsalo, cópialo y adáptalo.
