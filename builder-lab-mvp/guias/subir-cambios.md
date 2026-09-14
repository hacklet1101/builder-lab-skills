# Guía — subir y publicar los cambios

**Para dictar paso a paso.** Esto se repite en cada sesión, así que la primera vez
explícalo despacio: a partir de la tercera ya lo hará solo.

Explícaselo así:

> *"Guardar el trabajo son tres pasos: apuntar qué has cambiado, subirlo a GitHub, y
> Vercel lo publica solo. Es lo que hacemos al final de cada sesión, y también cada
> vez que algo funciona y no queremos perderlo."*

---

## Si tu proyecto todavía no está en GitHub

*Sáltate esto si abriste el proyecto desde Codespaces: ya viene conectado.*

Se nota en que `git push` responde *"No se ha configurado un destino para el empuje"*.
Se arregla una sola vez:

**1.** Necesitas la dirección de tu repositorio, la que copiaste al crearlo:
`https://github.com/tu-usuario/tu-repo`

**2.** Estos comandos los ejecuto yo:

```bash
git remote add origin https://github.com/tu-usuario/tu-repo.git
git branch -M main
git push -u origin main
```

**3.** Te pedirá autenticarte. Si tienes `gh` instalado ya está resuelto; si no, te
pedirá usuario y un **token** (no tu contraseña: GitHub ya no las acepta).
Si llega ese momento, dímelo y lo resolvemos con `gh auth login`, que es más fácil.

✅ **Comprobación:** recarga la página de tu repositorio en GitHub. Deberías ver tus
ficheros ahí.

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
