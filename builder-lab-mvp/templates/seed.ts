/**
 * Datos de ejemplo. Se mantiene al día desde el día 2.
 * Una demo con la base de datos vacía no es una demo.
 *
 *   npm run seed
 */
import { PrismaClient } from '@prisma/client'

const db = new PrismaClient()

/** Debe coincidir con el usuario que crees en Supabase Auth. */
const DEMO_EMAIL = 'demo@example.com'

async function main() {
  // Usuario de demo.
  // authId va vacío a propósito: obtenerUsuarioActual() lo reclama por email la
  // primera vez que alguien inicia sesión con este correo en Supabase. Así los
  // datos del seed pertenecen al usuario con el que vas a hacer la demo.
  // Crea ESE MISMO email en Supabase → Authentication → Users.
  const demo = await db.user.upsert({
    where: { email: DEMO_EMAIL },
    update: {},
    create: { email: DEMO_EMAIL, name: 'Usuario Demo' },
  })

  // {{CREAR_DATOS_DE_EJEMPLO}}
  // Datos realistas, no "Item 1", "Item 2". La demo se enseña con esto.

  console.log('Seed listo:', demo.email)
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(() => db.$disconnect())
