# Deploy en Coolify

**Se despliega el día 1, con la app vacía.** Desplegar por primera vez el día 7 es la
causa número uno de terminar sin MVP.

## Qué se despliega

Solo la aplicación Next.js. La base de datos la gestiona Supabase: no hay que montar
Postgres, ni volúmenes, ni backups en el servidor.

## Preparación (una vez, día 1)

1. El proyecto está en GitHub. Repositorio **privado**.
2. `Dockerfile` en la raíz (viene en `templates/Dockerfile`).
3. En `package.json`, el build aplica migraciones:
   ```json
   "build": "prisma generate && prisma migrate deploy && next build"
   ```
   Los días 1-4, mientras se usa `db push`, deja solo `prisma generate && next build`
   y cambia a `migrate deploy` el día 5.
4. `output: 'standalone'` en `next.config.ts`.

## En Coolify

1. New Resource → Application → Public/Private Repository → elegir el repo y la rama `main`.
2. Build Pack: **Dockerfile**.
3. Port: `3000`.
4. Environment Variables: copiar **todas** las del `.env` menos las de desarrollo.
   Añadir `NEXT_PUBLIC_APP_URL` con el dominio que asigne Coolify.
   Marcar como "Build Variable" las que hagan falta en tiempo de build
   (`DATABASE_URL`, `DIRECT_URL`, las `NEXT_PUBLIC_*`).
5. Deploy.
6. Abrir la URL. Si carga la página de inicio, día 1 cerrado.

## Todos los días

Al cerrar el día: commit, push, y Coolify despliega (o se pulsa Deploy). Se abre la
URL y se comprueba que lo de hoy está.

**Dos días sin desplegar = deuda que explota el día 7.**

## Cuando el deploy falla

Por orden, esto cubre el 90%:

1. **Logs de build en Coolify.** El error real está ahí, no en la app.
2. `Environment variable not found: DATABASE_URL` → falta marcarla como variable de
   build.
3. `PrismaClientInitializationError` → `DATABASE_URL` mal, o falta `prisma generate`
   en el build.
4. Build OK pero 502 → el puerto no es 3000, o falta `output: 'standalone'`.
5. Funciona en local y no en Coolify → casi siempre una variable de entorno que en
   local está en `.env` y en Coolify no.

## Rollback

Si producción está rota y no se arregla en 30 minutos:

- Coolify → la aplicación → Deployments → elegir el despliegue anterior que funcionaba
  → Redeploy.
- O en local: `git revert <hash>` y push. Nunca `git reset --hard` sobre `main` ya
  empujado.

Nunca se termina el día con producción rota. Rollback y se investiga mañana.

## Dominio propio

Opcional y solo si sobra tiempo. Los DNS tardan en propagarse: si se quiere dominio
para la demo, se configura el **día 5**, no el 7. La URL de Coolify sirve
perfectamente para presentar.
