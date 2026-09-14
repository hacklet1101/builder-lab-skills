# Guía — subir y publicar los cambios

**Para dictar paso a paso.** Esto se repite en cada sesión, así que la primera vez
explícalo despacio: a partir de la tercera ya lo hará solo.

Explícaselo así:

> *"Guardar el trabajo son tres pasos: apuntar qué has cambiado, subirlo a GitHub, y
> Vercel lo publica solo. Es lo que hacemos al final de cada sesión, y también cada
> vez que algo funciona y no queremos perderlo."*

---

## Los comandos

Se escriben en la terminal, uno detrás de otro. **Normalmente los ejecuto yo**, pero
conviene que los conozca:

```bash
git add -A
git commit -m "feat: la lista de clases ya se ve"
git push
```

Qué hace cada uno:

| | |
|---|---|
| `git add -A` | Coge todo lo que has cambiado |
| `git commit -m "..."` | Lo guarda con una nota de qué has hecho |
| `git push` | Lo sube a GitHub, y eso dispara la publicación en Vercel |

---

## El mensaje del commit

En español, empezando por el tipo y diciendo qué hace, no qué ficheros tocaste:

- `feat: los usuarios ya pueden reservar una clase`
- `fix: la fecha se guardaba con un día de menos`
- `docs: alcance actualizado tras recortar`

Tipos: `feat` (algo nuevo), `fix` (algo arreglado), `refactor` (cambio interno),
`docs`, `chore`.

---

## Después de subir

**1.** Espera **dos o tres minutos**.

**2.** Abre tu dirección `.vercel.app`.

✅ **Comprobación:** lo que acabas de hacer está ahí. Si no lo ves, recarga forzando:
`Ctrl+Shift+R` (o `Cmd+Shift+R` en Mac).

→ *Si sigue sin verse*, entra en vercel.com → tu proyecto → **Deployments** y mira si
el último salió bien o falló.

---

## Cuándo se sube

- **Siempre antes de empezar algo nuevo.** Es el botón de deshacer: si lo siguiente
  sale mal, se vuelve a este punto.
- **Siempre al terminar la sesión.** Nunca se acaba con trabajo sin subir.
- Cuando algo funcione y te dé pena perderlo.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| `Please tell me who you are` | Falta configurar git. Dímelo y lo hago |
| `rejected` o `non-fast-forward` | Hay cambios en GitHub que no tienes. Dímelo, no lo fuerces |
| `nothing to commit` | No hay nada nuevo que guardar. Todo correcto |
| Subiste algo que no debías | Dímelo **antes** de seguir. Si es una clave, hay que cambiarla, no basta con borrarla |
