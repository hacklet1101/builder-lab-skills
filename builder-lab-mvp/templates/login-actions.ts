/* builder-lab · hacklet 2026 */
'use server'

import { redirect } from 'next/navigation'
import { revalidatePath } from 'next/cache'
import { z } from 'zod'
import { obtenerSupabase } from '@/lib/auth'

const credenciales = z.object({
  email: z.email('Ese correo no parece válido'),
  password: z.string().min(8, 'La contraseña necesita al menos 8 caracteres'),
})

/** Vuelve a /login con el mensaje visible. */
function conError(mensaje: string): never {
  redirect(`/login?error=${encodeURIComponent(mensaje)}`)
}

export async function iniciarSesion(formData: FormData) {
  const datos = credenciales.safeParse({
    email: formData.get('email'),
    password: formData.get('password'),
  })
  if (!datos.success) conError(datos.error.issues[0].message)

  const supabase = await obtenerSupabase()
  const { error } = await supabase.auth.signInWithPassword(datos.data)
  if (error) conError('Correo o contraseña incorrectos')

  revalidatePath('/', 'layout')
  redirect('/')
}

export async function registrarse(formData: FormData) {
  const datos = credenciales.safeParse({
    email: formData.get('email'),
    password: formData.get('password'),
  })
  if (!datos.success) conError(datos.error.issues[0].message)

  const supabase = await obtenerSupabase()
  const { error } = await supabase.auth.signUp(datos.data)
  if (error) {
    // El mensaje de Supabase diría si ese correo ya está registrado, y eso permite
    // averiguar quién tiene cuenta. Al log, no a la pantalla.
    console.error('[registro]', error.message)
    conError('No se ha podido crear la cuenta. Revisa los datos e inténtalo de nuevo.')
  }

  revalidatePath('/', 'layout')
  redirect('/?registrado=1')
}
