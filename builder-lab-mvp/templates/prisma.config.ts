/* builder-lab · hacklet 2026 */

/**
 * Configuración de Prisma. Desde Prisma 7 la clave `prisma` del package.json
 * deja de existir, así que el seed se declara aquí.
 */
import path from 'node:path'
import { defineConfig } from 'prisma/config'

export default defineConfig({
  schema: path.join('prisma', 'schema.prisma'),
  migrations: { seed: 'tsx prisma/seed.ts' },
})
