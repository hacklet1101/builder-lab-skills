/* builder-lab · hacklet 2026 */
import { iniciarSesion, registrarse } from './actions'

export default async function PaginaLogin({
  searchParams,
}: {
  searchParams: Promise<{ error?: string }>
}) {
  const { error } = await searchParams

  return (
    <main className="mx-auto flex min-h-screen max-w-sm flex-col justify-center gap-6 p-8">
      <h1 className="text-2xl font-semibold text-ink">Entrar</h1>

      {error && (
        <p className="rounded-card border border-danger px-4 py-3 text-sm text-danger">
          {error}
        </p>
      )}

      <form className="flex flex-col gap-4">
        <label className="flex flex-col gap-1">
          <span className="text-sm text-ink-muted">Correo</span>
          <input
            type="email"
            name="email"
            required
            autoComplete="email"
            className="rounded-card border border-line px-3 py-2"
          />
        </label>

        <label className="flex flex-col gap-1">
          <span className="text-sm text-ink-muted">Contraseña</span>
          <input
            type="password"
            name="password"
            required
            minLength={8}
            autoComplete="current-password"
            className="rounded-card border border-line px-3 py-2"
          />
        </label>

        <button
          formAction={iniciarSesion}
          className="rounded-card bg-primary px-4 py-2 text-white hover:bg-primary-hover"
        >
          Entrar
        </button>
        <button
          formAction={registrarse}
          className="rounded-card border border-line px-4 py-2 text-ink hover:bg-surface"
        >
          Crear cuenta
        </button>
      </form>
    </main>
  )
}
