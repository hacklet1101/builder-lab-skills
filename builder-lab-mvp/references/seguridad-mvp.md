# Seguridad en un MVP de 7 días

La prevención está en el `CLAUDE.md` del proyecto y se comprueba con
`npm run check`. Esto es lo que ese gate **no** puede comprobar solo.

El día 6 se pasa la skill `auditoria-seguridad` completa. Esto es lo de antes.

## Lo único que hay que entender bien: autorización

Autenticación es *"¿quién eres?"*. Autorización es *"¿puedes ver **esto**?"*.
Casi todo el mundo hace bien la primera y mal la segunda.

```ts
// ❌ Solo comprueba que hay sesión. Cambio el id en la URL y veo tus datos.
const reserva = await db.booking.findUnique({ where: { id } })

// ✅ El id del usuario viene del servidor, no del cliente.
const reserva = await db.booking.findFirst({
  where: { id, userId: usuario.id },
})
```

Vale para leer, editar y borrar. **Sobre todo para borrar.**

Y el id del usuario sale **siempre** de `getUsuarioActual()`. Nunca de un campo del
formulario, de un parámetro de la URL ni de una cabecera. Todo eso lo controla quien
usa el navegador.

## Si se te escapa una clave

Va a pasar. Lo importante es la reacción, y **borrar el commit no basta**: la clave
ya ha estado publicada.

1. **Rota la clave primero**, antes de tocar git:
   - Contraseña de la base de datos → Supabase, Project Settings → Database → Reset.
   - anon / service_role → Supabase, Project Settings → API → Rotate.
   - Cualquier otra (Resend, etc.) → revócala en su panel y crea una nueva.
2. Actualiza `.env` en local y las variables en Coolify.
3. **Ahora** limpia git: `git rm --cached .env`, confirma que está en `.gitignore`,
   commit.
4. Si el repo es público o ya se ha subido, asume que la clave está comprometida
   aunque reescribas el historial. Rotar no es opcional.

Si lo que se escapó fue la `service_role`: alguien pudo leer y borrar **toda** la
base de datos. Rota y revisa los datos.

## Subida de ficheros

Si el MVP deja subir algo, cuatro reglas y ninguna es negociable:

- El bucket de Supabase Storage es **privado**. Se sirve con URL firmada, no pública.
- El tipo y el tamaño se validan **en el servidor**. Lo que diga el navegador es una
  sugerencia: el `accept` del input y el `Content-Type` los pone quien sube.
- El nombre del fichero lo pones tú (`cuid()` + extensión). Nunca el que llega:
  puede traer `../` o 300 caracteres.
- Nada de ejecutables ni HTML. Un `.html` subido y servido desde tu dominio es un
  XSS con tu nombre.

Si el producto no necesita subir ficheros de verdad, un campo de texto con una URL
resuelve la demo y cuesta cero.

## Emails

- La dirección de destino sale de la base de datos, nunca de un campo del formulario:
  si no, cualquiera usa tu app para mandar correo a quien quiera.
- Nada de meter HTML que venga del usuario en el cuerpo del email.
- El enlace de "recuperar contraseña" lo gestiona Supabase. **No montes uno propio.**

## Errores

Lo que se devuelve al navegador: *"No se ha podido crear la reserva"*.
Lo que va al log del servidor: el error entero.

Un stack trace en pantalla le dice a cualquiera qué base de datos usas, qué tablas
tienes y por dónde empezar.

## Si va a haber usuarios reales

Aunque sea una demo, en cuanto haya personas de verdad con sus datos:

- Solo se guarda lo que se usa. Cada campo extra es responsabilidad extra.
- Nada de guardar contraseñas propias: las guarda Supabase, hasheadas.
- Una página con quién eres, qué guardas y un email de contacto. Tres párrafos.
- Poder borrar una cuenta: un botón que borre en cascada. Es un `onDelete: Cascade`
  bien puesto y 10 líneas.

## Lo que NO toca en 7 días

Rate limiting propio (Supabase Auth ya lo trae), 2FA, cabeceras CSP finas, auditoría
de accesos, cifrado en la aplicación, pentesting. Nada de eso es lo que te va a
romper: te va a romper una query sin filtrar por usuario.
