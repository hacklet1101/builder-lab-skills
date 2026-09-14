/* builder-lab · hacklet 2026 */

/**
 * Refresca la sesión en cada petición y protege las rutas privadas.
 *
 * En Next 16 este fichero se llama `proxy.ts` (antes era `middleware.ts`) y la
 * función se exporta como `proxy`.
 *
 * Sin esto, el token caduca y `getUser()` empieza a devolver null sin motivo
 * aparente: el usuario "se desloguea solo".
 */
import { createServerClient } from '@supabase/ssr'
import { NextResponse, type NextRequest } from 'next/server'

/** Rutas a las que se entra sin sesión. Todo lo demás es privado. */
const RUTAS_PUBLICAS = ['/login', '/auth', '/registro']

export async function proxy(request: NextRequest) {
  let respuesta = NextResponse.next({ request })

  const supabase = createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll: () => request.cookies.getAll(),
        setAll: (cookiesAEscribir) => {
          cookiesAEscribir.forEach(({ name, value }) => request.cookies.set(name, value))
          respuesta = NextResponse.next({ request })
          cookiesAEscribir.forEach(({ name, value, options }) =>
            respuesta.cookies.set(name, value, options))
        },
      },
    }
  )

  // Refresca el token si hace falta.
  const { data: { user } } = await supabase.auth.getUser()

  const ruta = request.nextUrl.pathname
  const esPublica = ruta === '/' || RUTAS_PUBLICAS.some((r) => ruta.startsWith(r))

  if (!user && !esPublica) {
    const url = request.nextUrl.clone()
    url.pathname = '/login'
    return NextResponse.redirect(url)
  }

  // Las respuestas con cookies de sesión no se cachean nunca.
  respuesta.headers.set('Cache-Control', 'private, no-store')
  return respuesta
}

export const config = {
  matcher: [
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
