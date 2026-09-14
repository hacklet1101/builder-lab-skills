/* builder-lab · hacklet 2026 */

/**
 * Cliente Prisma único. En desarrollo se reutiliza entre recargas para no
 * agotar las conexiones de Supabase.
 *
 * Este fichero solo lo importan los servicios de src/modules/. Nunca src/app/.
 * 'server-only' garantiza que jamás acabe en el bundle del navegador.
 */
import 'server-only'
import { PrismaClient } from '@prisma/client'

const globalForPrisma = globalThis as unknown as { prisma?: PrismaClient }

export const db =
  globalForPrisma.prisma ??
  new PrismaClient({
    log: process.env.NODE_ENV === 'development' ? ['warn', 'error'] : ['error'],
  })

if (process.env.NODE_ENV !== 'production') globalForPrisma.prisma = db
