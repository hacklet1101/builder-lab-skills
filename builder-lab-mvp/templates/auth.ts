/* builder-lab · hacklet 2026 */

/**
 * Sesión y usuario actual. SOLO SERVIDOR.
 *
 * Regla del proyecto: el id del usuario sale SIEMPRE de aquí. Nunca de un campo
 * del formulario, de la URL ni de una cabecera: todo eso lo controla quien navega.
 */
import 'server-only'
import { createServerClient } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { redirect } from 'next/navigation'
import { db } from './db'
import { env } from './env'

export async function obtenerSupabase() {
  const almacenCookies = await cookies()
  return createServerClient(
    env.NEXT_PUBLIC_SUPABASE_URL,
    env.NEXT_PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        getAll: () => almacenCookies.getAll(),
        setAll: (cookiesAEscribir) => {
          try {
            cookiesAEscribir.forEach(({ name, value, options }) =>
              almacenCookies.set(name, value, options))
          } catch {
            // Llamado desde un Server Component: las refresca src/proxy.ts
          }
        },
      },
    }
  )
}

/** Usuario de ESTA app, o null si no hay sesión. */
export async function obtenerUsuarioActual() {
  const supabase = await obtenerSupabase()
  const { data: { user } } = await supabase.auth.getUser()
  if (!user) return null

  // 1. ¿Ya está enlazado?
  const existente = await db.user.findUnique({ where: { authId: user.id } })
  if (existente) return existente

  // 2. ¿Hay un usuario sembrado con ese email sin enlazar? Se reclama. Esto es lo
  //    que hace que los datos del seed sean del usuario con el que haces la demo.
  //
  //    Solo si Supabase ha CONFIRMADO el correo. Sin esta condición, con "Confirm
  //    email" desactivado en desarrollo cualquiera podría registrarse con el correo
  //    de demo y quedarse con sus datos.
  const correoConfirmado = Boolean(user.email_confirmed_at ?? user.confirmed_at)
  if (correoConfirmado) {
    const sembrado = await db.user.findFirst({
      where: { email: user.email!, authId: null },
    })
    if (sembrado) {
      return db.user.update({ where: { id: sembrado.id }, data: { authId: user.id } })
    }
  }

  // 3. Usuario nuevo.
  return db.user.create({ data: { authId: user.id, email: user.email! } })
}

/** Igual, pero manda a /login si no hay sesión. Úsalo en páginas privadas. */
export async function exigirUsuario() {
  const usuario = await obtenerUsuarioActual()
  if (!usuario) redirect('/login')
  return usuario
}

export async function cerrarSesion() {
  const supabase = await obtenerSupabase()
  await supabase.auth.signOut()
}
