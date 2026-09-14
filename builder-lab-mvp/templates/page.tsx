export default function Home() {
  return (
    <main className="mx-auto flex min-h-screen max-w-2xl flex-col justify-center gap-4 p-8">
      <h1 className="text-3xl font-semibold text-ink">{{NOMBRE_PROYECTO}}</h1>
      <p className="text-ink-muted">
        Día 1 completado. El proyecto está en marcha y desplegado.
      </p>
      <p className="text-ink-muted">
        Lo que se construye está en <code>docs/ALCANCE.md</code>.
      </p>
    </main>
  )
}
