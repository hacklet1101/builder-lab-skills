/**
 * Validación de variables de entorno. SOLO SERVIDOR.
 *
 * Si falta una, la app no arranca — mejor que fallar en producción a las 11 de la noche.
 *
 * `import 'server-only'` hace que importar este fichero desde un componente con
 * 'use client' falle en el BUILD, con un error claro, en vez de reventar en el
 * navegador (DATABASE_URL no existe allí).
 * En cliente usa `process.env.NEXT_PUBLIC_...` directamente.
 */
import 'server-only'
import { z } from 'zod'

const schema = z.object({
  DATABASE_URL: z.url(),
  DIRECT_URL: z.url(),
  NEXT_PUBLIC_SUPABASE_URL: z.url(),
  NEXT_PUBLIC_SUPABASE_ANON_KEY: z.string().min(1),
  NEXT_PUBLIC_APP_URL: z.url(),
})

const parsed = schema.safeParse({
  DATABASE_URL: process.env.DATABASE_URL,
  DIRECT_URL: process.env.DIRECT_URL,
  NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL,
  NEXT_PUBLIC_SUPABASE_ANON_KEY: process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
  NEXT_PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL,
})

if (!parsed.success) {
  console.error('❌ Faltan variables de entorno:')
  console.error(parsed.error.flatten().fieldErrors)
  throw new Error('Revisa tu fichero .env (compáralo con .env.example)')
}

export const env = parsed.data
