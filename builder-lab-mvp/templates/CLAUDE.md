# {{NOMBRE_PROYECTO}}

MVP de Builder Lab. Estas reglas mandan sobre cualquier default tuyo.

## Qué construimos

- **Producto:** {{UNA_FRASE}}
- **Para quién:** {{USUARIO}}
- **Acción core (lo único que TIENE que funcionar):** {{ACCION_CORE}}
- El alcance completo está en `docs/ALCANCE.md`. **Léelo antes de proponer nada nuevo.**

## Alcance — frena la sobre-ingeniería

- Si algo no sirve a la acción core, no se construye. Se anota en `docs/ALCANCE.md` bajo "Después del MVP".
- **Prohibido salvo que sea el core del producto:** microservicios, colas, Redis, websockets, multi-tenant, i18n, feature flags, monorepo, packages compartidos, panel de admin, roles más allá de usuario/propietario, modo oscuro, animaciones.
- Ante dos formas de hacer algo, la que tenga menos ficheros.
- No instales una librería para algo que se resuelve en 20 líneas. No escribas 200 líneas para algo que resuelve una librería estándar.

## Estructura — la frontera es sagrada

```
src/
  app/                    rutas Next (App Router). UI y handlers FINOS
  modules/<feature>/      lógica de negocio, por feature
    <feature>.service.ts  ÚNICO sitio que habla con la base de datos
    <feature>.schema.ts   esquemas zod de entrada/salida
    components/           UI propia de la feature
  lib/db.ts               cliente Prisma (singleton)
  lib/auth.ts             sesión y usuario actual
  lib/env.ts              validación de process.env con zod
  components/ui/          componentes compartidos, cero lógica de negocio
  styles/tokens.css       colores y espaciados
prisma/schema.prisma
docs/ALCANCE.md
```

**Reglas:**
- `src/app/**` NUNCA importa `lib/db` ni `@prisma/client`. Solo llama a funciones de `src/modules/*/*.service.ts`.
- Un módulo puede importar el `.service.ts` de otro módulo. Nunca sus componentes ni sus queries internas.
- Un fichero de más de 300 líneas se parte.
- Nombres de ficheros en `kebab-case`. Componentes React en `PascalCase`. Todo lo demás `camelCase`.
- Código, comentarios y textos en **español** (`listarClases`, `obtenerUsuarioActual`).
- Excepción: los modelos y campos de Prisma van en **inglés** (`User`, `createdAt`, `ownerId`). Es la convención del ORM y cambiarla genera más ruido del que quita.

## Datos

- PostgreSQL en Supabase. Prisma como único acceso.
- Modelos en `PascalCase` singular (`Booking`, no `bookings`). Campos en `camelCase`.
- Todo modelo lleva: `id String @id @default(cuid())`, `createdAt DateTime @default(now())`, `updatedAt DateTime @updatedAt`.
- Tabla `User` propia con `authId String @unique` (el id de Supabase Auth). Todo lo demás referencia `User.id`, **nunca** `authId`.
- `npx prisma db push` cada vez que cambies el modelo. Nada más. Sin `migrate`: la base de datos de Supabase es la misma en local y en producción.
- Índice en toda clave foránea por la que se filtre y en todo campo usado en `where`.
- Nada de borrado físico en entidades del core: `deletedAt DateTime?` y filtrar.
- `prisma/seed.ts` con datos realistas. Se mantiene al día desde el día 2.

## Seguridad — no negociable

- Toda query va por Prisma con parámetros. `$queryRawUnsafe` y `$executeRawUnsafe` están **prohibidos**.
- Todo dato que venga del cliente pasa por un esquema **zod en el servidor**, aunque el formulario ya valide. La validación del navegador no es validación.
- **Autorización por recurso:** cada query que lee o escribe datos de un usuario filtra por el id de la **sesión del servidor**, nunca por un id que llegue del cliente. `where: { id, userId: session.user.id }`, no `where: { id }`.
- Nada secreto lleva el prefijo `NEXT_PUBLIC_`. Si dudas, no lo lleva. La `service_role` key de Supabase **jamás** sale del servidor.
- El cliente de Supabase en el navegador se usa **solo para login**. Los datos se leen y escriben desde el servidor.
- RLS activado en Supabase con deny por defecto, como segunda capa. No es la defensa principal, es la red.
- `.env` está en `.gitignore` desde el primer commit. `.env.example` no lleva valores reales.
- Los errores que se devuelven al cliente no incluyen stack traces, SQL ni nombres de tabla.
- Si una clave llega a subirse a git: **primero se rota** en su panel, después se limpia git. Borrar el commit no desactiva la clave.
- Antes del deploy final se pasa entera la checklist de auditoría del día 6.

## Estilos

- Tailwind 4: no hay `tailwind.config`. Los colores y espaciados viven en el bloque `@theme` de `src/styles/tokens.css`. **Cero valores hex, rgb o clases arbitrarias `[...]` dentro de componentes.**
- Si necesitas un color nuevo: lo añades a `@theme` como `--color-<nombre>` y lo usas como `bg-<nombre>` / `text-<nombre>`.
- Cada pantalla se revisa a 390px de ancho **el mismo día que se hace**.
- Componentes compartidos en `components/ui/`. Si copias y pegas un bloque de JSX por segunda vez, extráelo.

## Git

- Commits pequeños y frecuentes, directos a `main`. Nada de ramas ni PRs en este proyecto.
- Formato: `tipo(scope): descripción en español, imperativo`. Tipos: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`.
- Commit **antes** de empezar cada tanda de cambios. Git es el botón de deshacer.
- Nunca commits con `.env`, claves, ni `node_modules`.
- El README lleva las credenciales del usuario de demo a propósito: el repo es privado y la demo las necesita. Es la única excepción.

## Cómo trabajamos

- Una capacidad cada vez. Nunca "haz la app entera".
- Antes de escribir código de una feature nueva, di en 3 líneas qué ficheros vas a tocar y espera confirmación.
- Si algo no está en `docs/ALCANCE.md`, pregunta antes de construirlo.
- No escribas tests salvo que se te pidan.
- No levantes servicios (docker, servidores) sin que te lo pidan en esa misma petición.

## "Debería funcionar" está prohibido

Una tarea está hecha cuando se cumplen las dos cosas, no antes:

1. Lo has **abierto en el navegador** y has hecho la acción tú.
2. `npm run check` pasa (reglas del proyecto + tipos).

Si no lo has ejecutado, la frase es *"lo he escrito pero no lo he probado"*. Nunca
"debería funcionar". Un fallo dicho a tiempo cuesta minutos; descubierto el día 7,
cuesta el MVP.
