# Guía — Vercel: publicar la app

**Para dictar paso a paso.** Uno cada vez. Espera confirmación antes de seguir.

Esto se hace **con la app vacía**, antes de construir ninguna pantalla. Explícaselo:

> *"Vamos a poner tu app en internet ahora, aunque todavía no haga nada. Así, a
> partir de hoy, cada cambio que hagamos se publica solo y siempre tienes una
> dirección que enseñar. Dejarlo para el final es la forma más habitual de acabar sin
> nada que enseñar."*

Esta guía tiene dos partes que se hacen en momentos distintos:

- **Parte 1 — la cuenta:** se hace **al principio**, junto con GitHub y Supabase.
- **Parte 2 — publicar:** se hace cuando ya hay código subido.

---

## Parte 1 — La cuenta (hazlo al principio)

**1.** Abre **vercel.com** y pulsa **Sign Up**.

**2.** Elige **Continue with GitHub**.

**3.** GitHub te preguntará a qué repositorios quiere acceder Vercel. Aquí hay una
elección que importa:

> **Elige "All repositories".**

Con esa opción, **cualquier repositorio que crees a partir de ahora aparece solo en
Vercel**, listo para publicar con un clic. Con la otra opción ("Only select
repositories") tendrías que venir a dar permisos a mano cada vez, y es justo donde se
atasca la gente.

*Son tus repositorios personales y Vercel solo lee el código para construir la web. Si
prefieres la opción restringida, funciona igual: solo tendrás que añadir el repositorio
a mano en la Parte 2.*

**4.** Si te pregunta el tipo de cuenta, elige **Hobby** (el gratuito). Si te pide un
nombre, el tuyo.

✅ **Comprobación:** llegas a un panel de Vercel. Si ya tenías el repositorio creado,
puede que aparezca ahí mismo sugerido para importar.

---

## Parte 2 — Publicar (cuando ya hay código subido)

**Requisito:** el código ya tiene que estar en GitHub. Si no, guía
`subir-cambios.md` primero.

**1.** Pulsa **Add New…** → **Project**.

**2.** Verás la lista de tus repositorios. El tuyo debería estar arriba, porque es el
más reciente. Pulsa **Import**.

→ *Si no aparece:* es que en la Parte 1 se eligió "Only select repositories". Pulsa
**Adjust GitHub App Permissions** (o *Configure GitHub App*) y añade el repositorio.

**3.** En la pantalla de configuración:
- **Framework Preset:** debe decir **Next.js**. Si lo dice, no toques nada más.
- **Build Command**, **Output Directory**, **Install Command**: **no los toques**.

**4.** Abre la sección **Environment Variables**. Aquí van las claves.

---

## Parte 2b — Las variables de entorno

Son los datos de Supabase. Yo te digo el nombre y el valor de cada una; tú las vas
añadiendo.

Son cuatro, y se añaden de una en una (nombre a la izquierda, valor a la derecha,
**Add**):

| Nombre | Qué es |
|---|---|
| `DATABASE_URL` | La dirección de Supabase con **:6543** |
| `DIRECT_URL` | La dirección de Supabase con **:5432** |
| `NEXT_PUBLIC_SUPABASE_URL` | La Project URL de Supabase |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | La clave anon |

⚠️ Al pegar los valores, comprueba que **no llevan comillas** ni espacios al final.
Es el fallo número uno aquí.

✅ **Comprobación:** las cuatro aparecen listadas antes de desplegar.

---

## Parte 2c — Desplegar

**1.** Pulsa **Deploy**.

**2.** Tarda **dos o tres minutos**. Verás el registro del proceso pasando.

**3.** Cuando acabe sale una pantalla de felicitación con una captura de tu app.

**4.** Pulsa en la captura, o en **Continue to Dashboard** y después en **Visit**.

✅ **Comprobación:** se abre tu app en una dirección terminada en `.vercel.app`.
**Ábrela también en el móvil.** Esa es la prueba de que está de verdad en internet.

**5.** Cópiame esa dirección.

→ *Si el despliegue falla:* entra en el intento fallido y ábreme los **Build Logs**.
Pégame las últimas 20 líneas y lo arreglamos.

---

## Parte 2d — Dos cosas que hay que cerrar ahora

**1. La dirección, en las variables.**
En Vercel: **Settings → Environment Variables**, añade
`NEXT_PUBLIC_APP_URL` con la dirección `.vercel.app` que acabas de copiar.
Después, **Deployments** → los tres puntos del último → **Redeploy**.

**2. La dirección, en Supabase.**
En Supabase: **Authentication → URL Configuration**. Pon tu dirección `.vercel.app`
en **Site URL** y también en **Redirect URLs**.

> Sin esto, los correos de confirmación y de recuperar contraseña apuntan a
> `localhost` y el login no funciona para nadie que no seas tú.

---

## A partir de ahora

**No hay que volver a hacer nada de esto.** Cada vez que subamos cambios a GitHub,
Vercel los publica solo en un par de minutos.

Tu rutina al cerrar cada sesión pasa a ser: subir los cambios → abrir la dirección →
comprobar que lo de hoy está.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| El repositorio no aparece en la lista | Se eligió "Only select repositories" al conectar. Adjust GitHub App Permissions → añade el repositorio (o cambia a All repositories y te olvidas para siempre) |
| Falla el build | Deployments → el que falló → **Build Logs**. Pégame las últimas líneas |
| Publica, pero la página da error | Mira **Runtime Logs**, no los de build |
| Funciona en tu ordenador y no aquí | Casi siempre falta una variable de entorno, o se añadió después del último despliegue: hay que redesplegar |
| Se rompió algo y hay prisa | Deployments → busca el último que iba bien → **Promote to Production** |
