# Supabase — configuración y las tres reglas

Supabase nos da base de datos, login y almacenamiento de ficheros sin instalar nada.
A cambio, tiene tres trampas que hay que cerrar el día 1 o se convierten en un
agujero de seguridad.

> Verifica siempre la API actual con Context7 (`/supabase/supabase`) antes de copiar
> código de aquí: `@supabase/ssr` cambia a menudo.

## Regla 1 — Supabase se habla desde el servidor

Supabase te invita a consultar la base de datos **desde el navegador**. Si lo haces,
la única defensa es RLS, y una tabla sin RLS bien puesto significa que cualquiera
abre la consola del navegador y se lleva todos los datos. Pasa constantemente.

En este proyecto:

- El cliente de navegador se usa **solo para iniciar y cerrar sesión**.
- **Todos los datos** se leen y escriben desde el servidor, con Prisma, dentro de
  `src/modules/*/*.service.ts`.
- RLS se activa igualmente en todas las tablas, con política de denegar por defecto.

### Qué protege RLS exactamente (y qué no)

Esto hay que tenerlo claro o da una falsa sensación de seguridad:

| | ¿Lo para RLS? |
|---|---|
| Alguien usando la anon key desde la consola del navegador | **Sí.** Para esto lo activas |
| Una query tuya que se olvida de filtrar por usuario | **No.** Prisma se conecta como propietario de las tablas y **se salta RLS siempre** |

Es decir: RLS te cubre del agujero que abre exponer la base de datos al navegador.
**No te cubre de tus propios errores de autorización** — de eso solo te cubre filtrar
por el id de la sesión en cada query. La barandilla que sí vigila eso es
`check-reglas.sh`.

> Si usas Storage o realtime desde el navegador, activar RLS sin políticas los deja
> sin funcionar **en silencio**. Si algo deja de cargar justo después de activar RLS,
> es esto.

## Regla 2 — un solo usuario, dos sitios

Supabase Auth guarda usuarios en `auth.users`. Tu app tiene su tabla `User`. La que
manda es la tuya, enlazada por `authId`. Ver `modelo-datos.md` § El usuario.

Al iniciar sesión, busca o crea el `User` local:

El código vive en `templates/auth.ts`, que `init-mvp.sh` copia a `src/lib/auth.ts`.
No lo reescribas: ábrelo y léelo. Expone cuatro funciones:

| | |
|---|---|
| `obtenerSupabase()` | cliente de Supabase con las cookies de la petición |
| `obtenerUsuarioActual()` | el `User` de tu base de datos, o `null` |
| `exigirUsuario()` | igual, pero redirige a `/login` si no hay sesión |
| `cerrarSesion()` | cierra la sesión |

La parte importante de `obtenerUsuarioActual()`: si no encuentra el usuario por
`authId`, busca uno **sembrado con ese email y sin `authId`** y lo reclama. Eso es lo
que hace que los datos del seed pertenezcan al usuario con el que haces la demo.

> El reclamo solo ocurre si Supabase ha **confirmado** el correo. Por eso, mientras
> tengas "Confirm email" desactivado en desarrollo, el usuario del seed no se enlaza:
> es lo correcto. Reactívalo el día 6 (está en el plan) y el enlace funciona.

**Nunca** uses `supabase.auth.getSession()` para decidir si alguien puede ver algo:
no revalida el token. `getUser()` sí.

## Regla 3 — dos URLs de conexión

Prisma contra Supabase necesita **dos** cadenas distintas:

```bash
# Aplicación: pooler de conexiones. Puerto 6543.
DATABASE_URL="postgresql://postgres.xxxx:PASSWORD@aws-0-region.pooler.supabase.com:6543/postgres?pgbouncer=true&connection_limit=1"

# Migraciones: conexión directa. Puerto 5432.
DIRECT_URL="postgresql://postgres.xxxx:PASSWORD@aws-0-region.pooler.supabase.com:5432/postgres"
```

```prisma
datasource db {
  provider  = "postgresql"
  url       = env("DATABASE_URL")
  directUrl = env("DIRECT_URL")
}
```

Si se usa solo una, o la app agota conexiones en producción o las migraciones fallan.
Ambas salen del panel de Supabase → Project Settings → Database → Connection string.

## Las claves: cuál es pública y cuál no

| Clave | Dónde puede estar |
|---|---|
| URL del proyecto | Pública. `NEXT_PUBLIC_SUPABASE_URL` |
| anon / publishable key | Pública. `NEXT_PUBLIC_SUPABASE_ANON_KEY` |
| **service_role key** | **Solo servidor.** `SUPABASE_SERVICE_ROLE_KEY`, nunca con `NEXT_PUBLIC_` |
| Contraseña de la BD | Solo en `DATABASE_URL` / `DIRECT_URL` |

La `service_role` se salta RLS entera. Filtrarla al navegador equivale a publicar la
base de datos. En un MVP normalmente **no hace falta usarla**: si no la necesitas,
no la pongas en el `.env`.

## Puesta en marcha (lo hace la persona, no tú)

1. Crear proyecto en supabase.com. Región: la más cercana.
2. Guardar la contraseña de la base de datos en un sitio seguro. No se puede recuperar.
3. Copiar URL, anon key, `DATABASE_URL` y `DIRECT_URL` al `.env`.
4. Authentication → Providers → Email activado. **Desactivar "Confirm email"**
   durante el desarrollo (si no, cada usuario de prueba necesita confirmar el correo).
   Volver a activarlo el día 6.
5. `npx prisma db push` → las tablas aparecen en el panel.
6. Table Editor → activar RLS en cada tabla, sin políticas (deny total). Como la app
   entra con Prisma y la contraseña de la base de datos, sigue funcionando.

## Storage (solo si hace falta subir ficheros)

- Un bucket, privado.
- La subida se hace desde el servidor, o con una URL firmada generada en el servidor.
- Nunca un bucket público con datos de usuarios.

## Aviso del plan gratis

El proyecto se pausa tras ~1 semana sin actividad y hay límite de tamaño. Irrelevante
durante la formación; hay que saberlo para después de la demo.
