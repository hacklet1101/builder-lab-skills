# Deploy en Vercel — referencia técnica

> **Para dictar paso a paso, usa `guias/vercel.md`.** Esto es la chuleta: lo que hay
> que saber tú, y qué mirar cuando algo falla.

**Se publica antes de escribir la primera pantalla, con la app vacía.** Publicar por
primera vez al final es la causa número uno de terminar sin MVP.

Vercel en su plan gratuito: sin tarjeta, sin servidor, sin Docker. Cada `git push`
despliega solo.

## Qué se despliega

Solo la aplicación Next.js. La base de datos la gestiona Supabase, y es **la misma**
en local y en producción: no hay dos entornos que sincronizar, y para un MVP eso es
una ventaja, no un descuido.

## Primera vez (20 minutos)

0. La cuenta de Vercel ya está creada desde el principio, entrando con GitHub y con
   permiso sobre **todos** los repositorios. Si se hizo así, el repo ya aparece solo.
1. El proyecto está en GitHub, en un repositorio **privado**.
2. Add New → Project → el repositorio está en la lista → Import.
4. Framework Preset: **Next.js**. No toques Build Command ni Output Directory.
5. **Environment Variables**: pega ahí todo lo que tienes en tu `.env`:
   `DATABASE_URL`, `DIRECT_URL`, `NEXT_PUBLIC_SUPABASE_URL`,
   `NEXT_PUBLIC_SUPABASE_ANON_KEY`. Deja `NEXT_PUBLIC_APP_URL` para el paso 7.
6. Deploy. Tarda un par de minutos.
7. Copia la URL que te da (`https://algo.vercel.app`), añádela como
   `NEXT_PUBLIC_APP_URL` en las variables y vuelve a desplegar (Redeploy).
8. En Supabase → Authentication → URL Configuration, pon esa URL en **Site URL** y
   en **Redirect URLs**. Sin esto, los enlaces de confirmación de correo apuntan a
   `localhost` y el login no funciona en producción.

Abre la URL, mejor desde el móvil. Si carga la página de inicio, **H2 cerrado**.

## Todos los días

`git push` y ya está: Vercel despliega la rama `main` sola. Abre la URL y comprueba
que lo de hoy está.

**Dos sesiones sin mirar la URL pública = deuda que explota en la demo.**

## El esquema de la base de datos

`npx prisma db push` **desde tu máquina**, nunca desde el build de Vercel.

La base de datos es la misma, así que con ejecutarlo una vez en local ya está
aplicado también para producción. Meter `db push` en el comando de build es una
forma estupenda de borrar una columna con datos un viernes por la tarde.

## Cuando el deploy falla

Por orden, esto cubre el 90%:

1. **Deployments → el que falló → Build Logs.** El error real está ahí.
2. `Environment variable not found: DATABASE_URL` → falta esa variable en Vercel, o
   la añadiste después del último deploy (hay que redesplegar para que la coja).
3. `PrismaClientInitializationError` → `DATABASE_URL` mal copiada. Fíjate en que la
   contraseña no tenga caracteres sin escapar.
4. `Module not found: @prisma/client` → falta `prisma generate` en el build. El
   `package.json` del kit ya lo trae en el script `build`; comprueba que sigue ahí.
5. Compila pero la página da error → mira **Runtime Logs** en Vercel, no Build Logs.
6. Funciona en local y no en Vercel → casi siempre una variable que en tu `.env`
   está y en Vercel no.

## Rollback

Producción rota y no se arregla en 30 minutos:

- Vercel → Deployments → busca el último que funcionaba → **Promote to Production**.
  Tarda segundos y no toca tu código.
- Después, en local, `git revert <hash>` y push.

Nunca se termina el día con producción rota. Rollback y se investiga mañana.

## Límites del plan gratuito

Sobra de largo para un MVP y para enseñarlo: 100 GB de tráfico al mes y builds de
sobra. Lo único a tener en cuenta:

- Es para **proyectos personales**, no comerciales. Si el MVP empieza a facturar,
  toca plan de pago.
- Las funciones tienen un tope de tiempo de ejecución. Si algo tarda más de 10
  segundos, el problema es la query, no Vercel.

## Dominio propio

Opcional y solo si sobra tiempo. Vercel → Settings → Domains. Los DNS tardan en
propagarse: si quieres dominio para la demo, configúralo **un par de días antes**, no
la víspera. La URL `.vercel.app` sirve perfectamente para presentar.
