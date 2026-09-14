# Estructura de carpetas

Monolito modular: **un solo `package.json`, un solo deploy, una sola base de datos.**
La modularidad está en las fronteras entre carpetas, no en workspaces ni packages.

```
mi-app/
  CLAUDE.md                    reglas del proyecto (se lee en cada sesión)
  README.md
  .env.example                 sin valores reales
  .gitignore                   con .env dentro DESDE EL PRIMER COMMIT
  Dockerfile                   para Coolify
  prisma/
    schema.prisma
    seed.ts
  docs/
    ALCANCE.md                 qué se construye y qué NO
  src/
    app/                       rutas Next (App Router)
      layout.tsx
      page.tsx
      (auth)/login/page.tsx
      (app)/clases/page.tsx
      api/clases/route.ts
    modules/                   ← la lógica vive aquí, por feature
      clases/
        clases.service.ts      ÚNICO sitio que habla con la BD
        clases.schema.ts       esquemas zod
        components/
          ClaseCard.tsx
      reservas/
        reservas.service.ts
        reservas.schema.ts
    lib/
      db.ts                    cliente Prisma singleton
      auth.ts                  sesión y usuario actual
      env.ts                   valida process.env con zod
      errors.ts                errores de negocio
    components/ui/             Button, Input, Card... sin lógica de negocio
    styles/
      tokens.css               bloque @theme de Tailwind 4: colores y espaciados
```

## Las tres reglas que sostienen todo

**1. `src/app/**` nunca importa `lib/db` ni `@prisma/client`.**
Solo llama a funciones de `src/modules/*/*.service.ts`. Un route handler o una server
action valida con zod, llama al service y devuelve. Nada más.

Comprobación rápida:
```bash
grep -rn "from '@/lib/db'\|@prisma/client" src/app/ && echo "❌ frontera rota"
```

**2. Un módulo puede importar el `.service.ts` de otro módulo. Nunca sus componentes
ni sus queries internas.** Eso mantiene una sola puerta de entrada por feature.

**3. Los servicios no saben que existe HTTP.** No reciben `Request`, no devuelven
`Response`, no leen cookies. Reciben datos ya validados y el id del usuario.

## Por qué así

Porque el día que esto crezca, `src/modules/` se mueve tal cual a un backend
separado (NestJS o lo que toque) sin reescribir la lógica. Y porque mientras tanto
es un solo proyecto, un solo `npm run dev` y un solo deploy.

Lo que **no** hacemos: monorepo, workspaces, `packages/`, múltiples apps, un
`services/` global, una carpeta `types/` gigante. Eso es para productos de dos años.

## Forma canónica de una feature

`src/modules/clases/clases.schema.ts`
```ts
import { z } from 'zod'

export const crearClaseSchema = z.object({
  title: z.string().min(3).max(120),
  startsAt: z.coerce.date(),
  capacity: z.number().int().min(1).max(500),
})
export type CrearClaseInput = z.infer<typeof crearClaseSchema>
```

`src/modules/clases/clases.service.ts`
```ts
import { db } from '@/lib/db'
import type { CrearClaseInput } from './clases.schema'

/** Clases del usuario. El filtro por ownerId NO es opcional. */
export async function listarClases(userId: string) {
  return db.class.findMany({
    where: { ownerId: userId, deletedAt: null },
    orderBy: { startsAt: 'asc' },
  })
}

export async function crearClase(userId: string, input: CrearClaseInput) {
  return db.class.create({ data: { ...input, ownerId: userId } })
}

/** Una clase concreta. Fíjate: id Y ownerId. */
export async function verClase(userId: string, id: string) {
  return db.class.findFirst({ where: { id, ownerId: userId, deletedAt: null } })
}
```

**El error que cuesta caro está en `verClase`.** Escribirlo así:

```ts
// ❌ NUNCA
export async function verClase(id: string) {
  return db.class.findUnique({ where: { id } })
}
```

…significa que cualquiera que cambie el id en la URL ve los datos de otro. No hace
falta ser hacker: basta con teclear otro número. Es el fallo de autorización más
común, y está en producción en muchísimas apps reales.

**Regla:** si una tabla tiene una columna que apunta a un usuario, **toda** query
sobre ella lleva esa columna en el `where`, con el id que viene de la sesión del
servidor — nunca con uno que llegue del cliente.

`src/app/api/clases/route.ts`
```ts
import { getUsuarioActual } from '@/lib/auth'
import { crearClaseSchema } from '@/modules/clases/clases.schema'
import { crearClase } from '@/modules/clases/clases.service'

export async function POST(req: Request) {
  const user = await getUsuarioActual()
  if (!user) return Response.json({ error: 'No autorizado' }, { status: 401 })

  const parsed = crearClaseSchema.safeParse(await req.json())
  if (!parsed.success) {
    return Response.json({ error: 'Datos inválidos' }, { status: 400 })
  }

  const clase = await crearClase(user.id, parsed.data)
  return Response.json(clase, { status: 201 })
}
```

Fíjate: el handler tiene 10 líneas y no sabe nada de Prisma. **Siempre así.**

## Server actions vs route handlers

- **Server actions** para formularios de la propia app. Menos código.
- **Route handlers** cuando algo externo tiene que llamar (webhooks) o cuando hace
  falta una respuesta JSON.

Las dos validan con zod y las dos llaman al service. La regla no cambia.
