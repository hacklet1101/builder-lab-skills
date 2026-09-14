# Cuando algo se atasca

## Tres intentos y para

Si llevas tres intentos con el mismo error, el cuarto tampoco va a funcionar. Cambia
de método:

1. **Lee el error entero.** No la primera línea: el error de verdad suele estar en
   medio. Cópialo completo.
2. **Reduce.** ¿Falla con un caso más simple? ¿Falla en local y en producción o solo
   en uno?
3. **Aísla.** Comenta la mitad. ¿Sigue fallando? El problema está en la otra mitad.
4. **Vuelve a lo que funcionaba.** `git stash` o `git checkout -- <fichero>`. Desde un
   estado bueno, un cambio cada vez.

Nunca cambies cinco cosas a la vez esperando que una funcione. Cuando funcione, no
sabrás por qué, y mañana se romperá igual.

## Cuando Claude Code entra en bucle

Señales: propone lo mismo con otras palabras, "ahora sí debería funcionar" por tercera
vez, o empieza a reescribir ficheros que no tienen que ver.

Qué hacer:

1. **Para.** No le digas "sigue intentándolo".
2. `git status` — mira qué ha tocado. Si ha ensuciado cosas que funcionaban,
   `git checkout -- <fichero>`.
3. `/clear`.
4. Vuelve a empezar con **el error exacto** y **el fichero exacto**:
   *"En `src/modules/reservas/reservas.service.ts` línea 24 sale este error: [pegado
   entero]. No cambies nada más."*

El contexto sucio es la causa del 90% de los bucles. `/clear` es gratis.

## Cuando el deploy funciona en local pero no en Vercel

Por orden:

1. **Build Logs** en Vercel, en el deployment que falló (no los de runtime).
2. ¿Todas las variables del `.env` están en Vercel? Si añadiste alguna después del
   último deploy, hay que redesplegar para que la coja.
3. `prisma generate` en el build.
4. ¿El error es de runtime y no de build? Entonces mira **Runtime Logs**, no los de build.
5. ¿Has cambiado el modelo y no has hecho `npx prisma db push` desde tu máquina?

## Rollback

Producción rota y no se arregla en 30 minutos:

- **Vercel:** Deployments → el último que funcionaba → **Promote to Production**.
- **Git:** `git revert <hash>` y push. Nunca `git reset --hard` sobre algo ya empujado.

Y se acaba el día. Mañana, con la cabeza fresca, en veinte minutos.

## Cuando se rompió algo que funcionaba

```bash
git log --oneline -10          # ¿cuándo funcionaba?
git diff <hash-bueno> -- src/  # ¿qué cambió desde entonces?
```

Si no aparece, `git stash` de todo lo no commiteado y comprueba si vuelve a funcionar.
Si vuelve, el problema está en el stash y lo aplicas por partes.

## Cuando te quedas sin cuota de Claude

Pasa, sobre todo por la tarde. Cómo estirarla:

- `/clear` entre features: el contexto largo cuesta en cada mensaje.
- Pide cosas concretas. "Arregla el error X en el fichero Y" gasta mucho menos que
  "revisa la app".
- No le pidas que lea la base de código entera para algo que sabes dónde está.
- Si se acaba: commitea, escribe en dos líneas dónde te quedaste, y sigue cuando se
  renueve. No improvises a mano sobre código que no entiendes.

## Cuando no da tiempo

No es una emergencia, es el plan. Ve al protocolo de corte en el `SKILL.md`:
se borra el P2, se recorta el P1, se entrega el P0 funcionando.

Un MVP que hace una cosa bien se presenta con la cabeza alta. Cinco a medias, no.
