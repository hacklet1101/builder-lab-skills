# Modelo de datos para un MVP

Un modelo mal el día 1 se paga los días 4, 5 y 6. Un modelo grande el día 1 se paga
todos. Busca el más pequeño que soporte la acción core.

## Convenciones (van tal cual al `schema.prisma`)

- Modelos en **PascalCase singular**: `Booking`, `Class`, `User`. Nunca `bookings`.
- Campos en **camelCase**: `startsAt`, `userId`, `isPublished`.
- Id: `id String @id @default(cuid())`. Siempre. No autoincrement (expone cuántos
  registros tienes y facilita que alguien pruebe ids ajenos).
- Todo modelo lleva `createdAt DateTime @default(now())` y `updatedAt DateTime @updatedAt`.
- Borrado: `deletedAt DateTime?` en las entidades del core y filtrar por `deletedAt: null`.
  En entidades auxiliares, borrado físico está bien.
- Enums para estados cerrados: `enum BookingStatus { PENDING CONFIRMED CANCELLED }`.
  Nunca un `String` con valores mágicos.
- `@@index([campo])` en toda clave foránea y en todo campo por el que filtres.
- `@@unique([a, b])` donde no pueda haber duplicados. Es la única forma fiable de
  evitar dobles reservas, dobles inscripciones y dobles envíos.
- Dinero: `Decimal @db.Decimal(10, 2)`. **Nunca `Float`.**
- Fechas siempre `DateTime` (UTC). Nada de guardar fechas como texto.
- Relaciones: declara `onDelete`. Por defecto `Cascade` si el hijo no tiene sentido
  sin el padre, `Restrict` si borrarlo sería perder información.

## El usuario

Con Supabase Auth hay dos sitios donde "existe" el usuario. Solo uno manda:

```prisma
model User {
  id        String   @id @default(cuid())
  authId    String   @unique          // id de Supabase Auth
  email     String   @unique
  name      String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  // relaciones...
}
```

**Todo lo demás referencia `User.id`, nunca `authId`.** Cuando alguien inicia sesión,
se busca (o se crea) su `User` por `authId` y a partir de ahí se trabaja con `User.id`.

Si el producto no tiene usuarios (una calculadora, un generador), **no crees `User`**.

## Ejemplo completo — app de reservas

```prisma
model User {
  id        String    @id @default(cuid())
  authId    String    @unique
  email     String    @unique
  name      String?
  bookings  Booking[]
  createdAt DateTime  @default(now())
  updatedAt DateTime  @updatedAt
}

model Class {
  id          String    @id @default(cuid())
  title       String
  startsAt    DateTime
  capacity    Int
  bookings    Booking[]
  deletedAt   DateTime?
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt

  @@index([startsAt])
}

model Booking {
  id        String        @id @default(cuid())
  status    BookingStatus @default(CONFIRMED)
  user      User          @relation(fields: [userId], references: [id], onDelete: Cascade)
  userId    String
  class     Class         @relation(fields: [classId], references: [id], onDelete: Cascade)
  classId   String
  createdAt DateTime      @default(now())
  updatedAt DateTime      @updatedAt

  @@unique([userId, classId])   // nadie reserva dos veces la misma clase
  @@index([classId])
}

enum BookingStatus {
  CONFIRMED
  CANCELLED
}
```

Tres tablas. Eso es un MVP.

## Migraciones: db push primero, migrate después

- **Días 1-4:** `npx prisma db push`. El modelo cambia cada hora; generar una
  migración por cada idea produce 40 ficheros basura y un lío del que no se sale.
- **Día 5, cuando el modelo ya no se mueve:** borra la carpeta `prisma/migrations`
  si existe y haz `npx prisma migrate dev --name init` una sola vez.

  > ⚠️ Esto solo es seguro **antes de que haya datos reales**. `migrate dev` puede
  > pedir resetear la base de datos, y resetear **borra todo**. Hazlo el día 5,
  > nunca después de la demo ni con usuarios de verdad dentro. Si ya hay datos que
  > te importan, quédate con `db push` y no mires atrás.
- **En producción (Coolify):** `npx prisma migrate deploy` en el build. Nunca `db push`.

Esta transición se hace **una vez** y hay que hacerla antes de que haya datos reales.

## Cómo explicárselo a alguien que no sabe

No enseñes el `schema.prisma` primero. Di las frases:

> *"Guardamos clases. Cada clase tiene un título, una fecha y cuántas plazas hay.
> Guardamos reservas. Cada reserva es de un usuario para una clase. Y una persona no
> puede reservar dos veces la misma clase."*

Si esas frases están bien, el schema está bien. Entonces lo escribes.

## Errores frecuentes

- Crear una tabla por cada sustantivo de la entrevista. Muchos son campos.
- `Float` para dinero.
- Guardar arrays de ids como texto separado por comas en vez de una relación.
- Olvidar `@@unique` y descubrir el día 6 que hay reservas duplicadas.
- Una tabla `Settings` con 20 campos que nadie usa.
- Poner `String` donde hay 3 valores posibles, en vez de un enum.
