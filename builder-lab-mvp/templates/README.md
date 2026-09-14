# {{NOMBRE_PROYECTO}}

{{UNA_FRASE}}

**En producción:** {{URL_VERCEL}}

## Stack

Next.js (App Router) · TypeScript · Prisma · PostgreSQL (Supabase) · Tailwind · Vercel

## Arrancar en local

```bash
cp .env.example .env     # rellenar con los datos de Supabase
npm install
npx prisma db push
npm run seed
npm run dev
```

Abre http://localhost:3000

## Comandos

| Comando | Qué hace |
|---|---|
| `npm run dev` | Arranca en local |
| `npm run build` | Compila para producción |
| `npm run seed` | Rellena la base de datos con datos de ejemplo |
| `npm run db:studio` | Abre el panel visual de la base de datos |
| `npm run db:push` | Aplica cambios del schema (desarrollo) |

## Estructura

```
src/app/        rutas y pantallas
src/modules/    lógica de negocio, por feature
src/lib/        base de datos, auth, entorno
src/components/ componentes compartidos
prisma/         modelo de datos y datos de ejemplo
docs/ALCANCE.md qué se construye y qué no
```

Las convenciones del proyecto están en `CLAUDE.md`.

## Usuario de demo

- Email: {{EMAIL_DEMO}}
- Contraseña: {{PASSWORD_DEMO}}
