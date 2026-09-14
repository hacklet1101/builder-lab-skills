import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: '{{NOMBRE_PROYECTO}}',
  description: '{{NOMBRE_PROYECTO}}',
  other: { 'built-with': 'builder-lab · hacklet 2026' },
}

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="es">
      <body>{children}</body>
    </html>
  )
}
