# Builder Lab — skills para construir tu MVP

Dos skills de Claude Code que llevan a alguien **sin experiencia previa** de una idea
a una app publicada y funcionando.

**Sin instalar nada.** Todo se puede hacer desde el navegador: hay quien lo hace
desde un portátil viejo y quien lo hace desde el móvil.

No es un tutorial ni una plantilla: son instrucciones que Claude Code lee y sigue.
Le dicen qué preguntarte, qué construir, qué **no** construir, y cuándo parar.

| Skill | Cuándo se usa |
|---|---|
| **`builder-lab-mvp`** | Al empezar. Entrevista, recorta el alcance, diseña el modelo de datos, monta el proyecto y lo publica |
| **`builder-lab-hitos`** | Todo lo demás. Abre la sesión, elige qué toca, la cierra con el trabajo publicado |

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

## Antes de empezar

Tres cuentas, todas gratis, todas desde el navegador, ninguna pide tarjeta:

- **GitHub** — donde vive el código.
- **Supabase** — la base de datos. Entra con GitHub y **guarda la contraseña de la
  base de datos en un gestor de contraseñas: no se puede recuperar.**
- **Vercel** — donde vive tu app. Entra con GitHub, plan gratuito.

### Dónde vas a trabajar

**Si tu ordenador va lento, es viejo, o trabajas desde el móvil:** usa **GitHub
Codespaces**. Te da editor y terminal dentro del navegador, con Node ya instalado.
En el repositorio: botón verde *Code* → pestaña *Codespaces* → *Create codespace*.
Dentro, `npm install -g @anthropic-ai/claude-code` y ya estás trabajando.

**Si tu ordenador va bien** y prefieres trabajar en él: Node 20+, npm 10+, git y
Claude Code. En Windows, dentro de WSL2.

El detalle de ambos caminos está en `builder-lab-mvp/references/preparacion.md`.

### No hace falta

Instalar PostgreSQL, instalar Docker, un servidor, un dominio, una tarjeta, ni saber
usar la terminal.

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
arréglalo antes de empezar.

---

## Cómo se usa

### Para arrancar

Abre Claude Code donde vayas a trabajar y escribe algo como:

> **quiero arrancar el MVP de mi app**

La skill se activa sola. A partir de ahí, Claude te lleva por seis pasos:

1. **Entorno** — comprueba que no falta nada.
2. **Entrevista** — seis preguntas sobre tu producto. La que importa es:
   *si al final solo funciona una cosa, ¿cuál tiene que ser?*
3. **Scaffolding** — monta el proyecto entero: estructura, dependencias, login,
   base de datos, primer commit.
4. **Alcance** — escribe `docs/ALCANCE.md`: qué se construye (P0), qué estaría bien
   (P1), qué es adorno (P2) y **qué no se hace**. Lo apruebas tú.
5. **Modelo de datos** — las tablas, explicadas en español antes de escribirlas.
6. **Publicar** — sí, ya, con la app vacía. Sales de esta sesión con una URL pública
   que funciona y que puedes abrir desde el móvil.

Cuando termine tendrás un `CLAUDE.md` en tu proyecto: ese fichero es el que hace que
Claude siga tus convenciones en todas las sesiones siguientes, sin que se lo repitas.

### Para seguir

Cada vez que te sientes, en la carpeta del proyecto:

> **qué toca ahora** · **sigo con mi app** · **en qué hito estoy**

La skill lee tu `ALCANCE.md`, mira qué se hizo la última vez y te dice qué toca. Al
acabar cierra: commit, push, y comprobar la URL pública.

### Los ocho hitos

**El progreso no se mide en días.** Hay quien cierra tres hitos en una tarde y quien
tarda dos días en uno. Cada hito tiene un gate que no es opinable.

| Hito | Está cerrado cuando… |
|---|---|
| **H0 · Preparado** | Tienes las cuentas y un sitio donde trabajar |
| **H1 · Decidido** | Alcance aprobado y modelo de datos aplicado |
| **H2 · Publicado** | Hay una URL pública que carga, aunque la app esté vacía |
| **H3 · Se entra** | Registro y login funcionan *(se salta si tu app no tiene usuarios)* |
| **H4 · Se usa** | Se ven datos y se crean datos desde la interfaz |
| **H5 · Funciona entero** | El P0 completo, hecho por alguien que no eres tú |
| **H6 · Aguanta** | Errores, pantallas vacías, móvil y seguridad |
| **H7 · Presentable** | Datos de demo, guion de 3 minutos y ensayo |

**H5 es el que decide si hay MVP.** El corte de alcance no se dispara en una fecha,
sino cuando has gastado **dos tercios de tu tiempo** y H5 sigue abierto: entonces se
borra todo el P2 y se sigue con lo esencial. Ese acuerdo se firma al principio.

Si la formación son 7 días, el reparto sale solo —H0-H2 el primero, H5 hacia el
cuarto, H7 el último— pero el calendario es consecuencia de los hitos, no al revés.

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
| `npm run dev` | Arranca la app en tu ordenador (opcional: normalmente la miras en su URL) |
| `npm run check` | Comprueba que el proyecto cumple sus reglas y sus tipos |
| `npm run seed` | Rellena la base de datos con datos de ejemplo |
| `npm run db:push` | Aplica los cambios del modelo a la base de datos |
| `npm run db:studio` | Abre un panel visual de tus datos |

`npm run check` es el que hay que ejecutar al cerrar cada sesión. En dos segundos dice si:

- alguna página habla con la base de datos saltándose la estructura
- hay colores sueltos fuera de los tokens de diseño
- hay algún fichero de claves dentro de git, o un secreto expuesto al navegador
- hay consultas que buscan por `id` sin comprobar de quién es el dato

---

## Cuando algo va mal

| Situación | Dónde mirar |
|---|---|
| Llevas 3 intentos con el mismo error | `builder-lab-hitos/references/atascos.md` |
| Claude repite lo mismo una y otra vez | Para, `/clear`, y vuelve con el error exacto pegado |
| El deploy falla en Vercel | `builder-lab-mvp/references/deploy.md`, sección "Cuando el deploy falla" |
| Producción está rota | Vercel → Deployments → el último que funcionaba → Promote to Production |
| No te va a dar tiempo | No es una emergencia, es el plan: el corte de alcance está en `builder-lab-hitos/SKILL.md` |
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
  SKILL.md              el flujo de arranque (H0, H1, H2)
  references/           preparación, alcance, modelo de datos, estructura, supabase,
                        seguridad, deploy, antipatrones, hitos
  templates/            CLAUDE.md, ALCANCE.md, schema.prisma, auth, proxy, login,
                        tokens, seed, env, db…
  scripts/              check-entorno.sh, init-mvp.sh, check-reglas.sh
builder-lab-hitos/
  SKILL.md              el ritual de cada sesión y el protocolo de corte
  references/           los ocho hitos, atascos, demo
test-skill.sh           prueba el kit de punta a punta
install.sh              enlaza los skills en ~/.claude/skills
```

### Las decisiones que ya están tomadas

- **Sin migraciones de Prisma.** `db push` toda la semana: la base de datos es la
  misma en local y en producción.
- **Sin tests automáticos.** El gate es recorrer el camino core en producción con una
  cuenta recién creada, que es lo que de verdad encuentra los fallos.
- **Login desde el principio** si el producto tiene usuarios. Dejarlo para el final
  obliga a reescribir cada consulta.
- **Publicar antes de la primera pantalla**, con la app vacía. Publicar por primera
  vez al final es la causa número uno de terminar sin MVP.
- **Nada obligatorio en local.** La app se mira en su URL pública; `npm run dev` es
  una comodidad, no un requisito.

---

## Licencia

MIT. Úsalo, cópialo y adáptalo.
