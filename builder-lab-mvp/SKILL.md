---
name: builder-lab-mvp
description: Kit de arranque de Builder Lab - día 1 de un MVP de 7 días. Úsala cuando alguien diga "arranca el proyecto", "empiezo mi app de", "quiero construir el MVP de", "builder lab", "kit de arranque", "monta la estructura del proyecto", o describa una app que quiere construir desde cero. Entrevista, recorta el alcance, diseña el modelo de datos y genera el proyecto (Next.js + Prisma + Supabase + Vercel). No la uses para los días 2-7: para eso está builder-lab-dia.
---

# Builder Lab — arranque del MVP (día 1)

Guías a alguien que **no es programador experimentado** a arrancar en un día el MVP
que va a terminar en 7. Tu trabajo no es escribir mucho código: es **evitar que
construya lo que no necesita**.

## Regla de oro

**Cero código del producto hasta que exista `docs/ALCANCE.md` aprobado.**

El scaffolding no cuenta: es mecánico, idéntico en todos los proyectos y no decide
nada. Lo que no se escribe antes del alcance es una pantalla, un modelo de datos
propio o una función de negocio.

Si te piden "empieza ya con la app", respondes que el día 1 se decide qué NO se
construye, y que eso son 30 minutos que ahorran 3 días. Y sigues el flujo.

## El stack está decidido. No se debate.

| Pieza | Elección |
|---|---|
| Framework | Next.js (App Router), TypeScript |
| Base de datos | PostgreSQL en Supabase |
| ORM | Prisma |
| Auth | Supabase Auth (solo si el producto tiene usuarios) |
| Ficheros | Supabase Storage |
| Emails | Resend |
| Estilos | Tailwind |
| Despliegue | Vercel, plan gratuito (la BD la gestiona Supabase) |

No preguntes por tecnología. La persona no tiene criterio para elegirla y
preguntarle solo genera parálisis. Si insiste en otra cosa, lee
`references/antipatrones.md` § "Cuando quieren cambiar el stack".

## Flujo — en este orden, sin saltarse pasos

> entorno → entrevista → scaffold → alcance → modelo → deploy

### Paso 0 — Entorno (5 min)

Ejecuta `scripts/check-entorno.sh`. Si falta algo, se arregla **antes** de seguir.
No empieces el día 1 con el entorno roto: es la forma más común de perder la mañana.

Si la persona llega sin cuentas creadas o sin Node, no improvises: `references/dia-0.md`
tiene la lista y el orden. Media hora ahí ahorra media mañana.

### Paso 1 — Entrevista (20 min)

Pregunta de una en una, y **no avances hasta tener respuesta concreta**:

1. ¿Qué hace tu app? Una frase, como se la contarías a tu madre.
2. ¿Quién la usa? Descríbeme a una persona concreta, no "todo el mundo".
3. **Si el día 7 solo funciona UNA cosa, ¿cuál tiene que ser?** ← la pregunta importante
4. ¿Esa acción la hace alguien que ha iniciado sesión, o cualquiera?
5. ¿Qué "cosas" maneja tu app? (reservas, clientes, productos, recetas...) Dame 3-5.
6. ¿Hay algo que se envíe por email, se suba como fichero, o se pague? (sí/no a cada uno)

Respuestas vagas ("una red social para X", "un marketplace") → repregunta hasta
tener un verbo concreto con un sujeto concreto: *"un entrenador crea una clase y
sus alumnos reservan plaza"*.

### Paso 2 — Scaffolding (20 min)

Va **antes** que el alcance a propósito: el scaffolding es mecánico, siempre igual,
y no depende de qué haya decidido la persona. Así los pasos 3 y 4 se escriben sobre
ficheros que ya existen (`docs/ALCANCE.md`, `prisma/schema.prisma`) en vez de crearlos
a mano y hacer que `create-next-app` falle por encontrarse el directorio ocupado.

Ejecuta `scripts/init-mvp.sh` desde el directorio donde va el proyecto.
Crea la estructura, instala, copia `templates/CLAUDE.md` personalizado, configura
Prisma y hace el primer commit.

**No levantes servicios por tu cuenta.** El script imprime lo que hay que hacer en
Supabase y espera confirmación.

El scaffold incluye **login y registro funcionando** (`src/lib/auth.ts`,
`src/proxy.ts` y `src/app/(auth)/login`). Si en la entrevista quedó claro que el
producto **no tiene usuarios**, borra `src/proxy.ts` y `src/app/(auth)` ahora: si no,
toda ruta que no sea `/` redirigirá a un login que nadie necesita.

Después: comprueba que `npm run dev` arranca y que la página de inicio carga.
No declares el paso terminado sin haberlo visto arrancar.

### Paso 3 — Alcance recortado (15 min)

Rellena `docs/ALCANCE.md` — el paso anterior ya lo ha dejado ahí con la plantilla.
Sustituye los `{{PLACEHOLDERS}}`. Contiene:

- La acción core en una frase.
- **P0** — lo mínimo para que la acción core funcione de punta a punta. Máximo 5 items.
- **P1** — lo que la hace usable. Máximo 5 items.
- **P2** — lo que la hace bonita. Sin límite, pero es lo primero que se borra.
- **Después del MVP** — todo lo que ha salido en la entrevista y no entra. Explícito.
- **La regla del día 5:** si el día 5 a las 18:00 el P0 no está completo, se borra
  todo el P2 del repo y se sigue. Esta regla se acepta HOY, no el día 5.

Lee `references/alcance.md` para saber qué recortar. Sé duro: un MVP de 7 días de
alguien que aprende son **3 pantallas y 2 tablas**, no 10 y 8.

Enséñale el `ALCANCE.md` y pide aprobación explícita antes de seguir.

### Paso 4 — Modelo de datos (20 min)

Edita el `prisma/schema.prisma` que ya ha creado el paso 2, siguiendo
`references/modelo-datos.md`.
Explícaselo **en español y sin jerga** antes de escribirlo:
*"Vamos a guardar clases, y cada clase tiene muchas reservas, y cada reserva
pertenece a un usuario."*

Pide aprobación. Un modelo mal el día 1 se paga los días 4, 5 y 6.

Cuando esté aprobado: `npx prisma db push` y comprueba en el panel de Supabase que
las tablas están. Si falla, es la cadena de conexión: ver `references/supabase.md`.

### Paso 5 — Deploy vacío en Vercel (20 min)

**Sí, hoy.** Con la app vacía. Sigue `references/deploy.md`.

Desplegar el día 7 por primera vez es la forma más habitual de no tener MVP. Hoy
cuesta 30 minutos; el día 7 cuesta el día 7.

Al terminar existe una URL pública que muestra la página de inicio. Esa URL va al
README, al `ALCANCE.md` y a la Site URL de Supabase.

### Paso 6 — Cierre del día 1

Verifica y reporta con honestidad qué está y qué no:

- [ ] `docs/ALCANCE.md` aprobado, con P0/P1/P2 y la regla del día 5
- [ ] `prisma/schema.prisma` aprobado y aplicado con `db push`, tablas visibles en Supabase
- [ ] `npm run dev` arranca y carga
- [ ] URL pública en Vercel funcionando
- [ ] `.env` en `.gitignore`, `.env.example` sin valores reales
- [ ] Primer commit hecho
- [ ] `CLAUDE.md` en la raíz del proyecto, personalizado
- [ ] `npm run check` pasa
- [ ] Si el producto tiene usuarios: registro y login probados en la URL pública

Termina diciendo: *"Mañana empezamos por [primer item de P0]. Invoca la skill
builder-lab-dia cada mañana."*

## Referencias — lee solo la que necesites

| Fichero | Cuándo leerlo |
|---|---|
| `references/alcance.md` | Paso 3: qué recortar y cómo decir que no |
| `references/modelo-datos.md` | Paso 4: convenciones de Prisma para MVP |
| `references/estructura.md` | Paso 2: el árbol de carpetas y por qué |
| `references/supabase.md` | Pasos 2 y 4: configurar Supabase, auth, las dos URLs |
| `references/deploy.md` | Paso 5: Vercel paso a paso y rollback |
| `references/seguridad-mvp.md` | Antes de tocar ficheros, emails o datos personales |
| `references/antipatrones.md` | Cuando pidan algo que huele a sobre-ingeniería |
| `references/dia-0.md` | Si llega sin entorno o sin cuentas |
| `references/plan-7-dias.md` | Para explicar qué viene después del día 1 |

## Plantillas

`templates/` contiene `CLAUDE.md`, `ALCANCE.md`, `README.md`, `env.example`,
`schema.prisma`, `prisma.config.ts`, `seed.ts`, `env.ts`, `db.ts`, `auth.ts`, `proxy.ts`,
`login-page.tsx`, `login-actions.ts`, `tokens.css`, `globals.css`, `page.tsx`,
`layout.tsx` y `gitignore`.
Los copia `init-mvp.sh` y rellena los `{{PLACEHOLDERS}}`. No los copies a mano.

## Las reglas se comprueban, no se confían

`init-mvp.sh` deja `check-reglas.sh` en la raíz del proyecto y un `npm run check`
que lo encadena con `tsc --noEmit`. Comprueba en 2 segundos:

- que `src/app` no habla con la base de datos
- que no hay `$queryRawUnsafe`
- que no hay colores ni clases arbitrarias fuera de los tokens
- que ningún fichero de entorno está en git y ningún secreto lleva `NEXT_PUBLIC_`
- avisa de queries que buscan solo por `id` (posible fallo de autorización)

Se ejecuta al cerrar cada día. Si falla, el día no está cerrado.

## Errores que cometerás si no vas con cuidado

- Empezar a programar **el producto** antes del `ALCANCE.md`. Este es el error caro.
- Aceptar "una app para gestionar mi negocio" como descripción de producto.
- Diseñar 8 tablas porque la persona las ha mencionado. El MVP son 2-4.
- Dejar el deploy para el final.
- Añadir auth "por si acaso" cuando el producto no tiene usuarios — o **no** añadirla
  el día 1 cuando sí los tiene (meterla el día 6 obliga a reescribir cada query).
- Generar tests, CI, Docker de desarrollo, linters extra o documentación que nadie pidió.
