# Guía — Codespaces: tu ordenador de programar, en el navegador

**Para dictar paso a paso.** Uno cada vez. Espera confirmación antes de seguir.

Esta es la vía para quien tenga un ordenador lento, viejo, o no quiera instalar nada.
Explícaselo así:

> *"Vas a usar un ordenador que está en internet, dentro de tu navegador. Ya viene
> con todo instalado. Tu ordenador solo tiene que abrir una pestaña."*

Es gratis dentro de las horas que incluye una cuenta personal de GitHub, y se apaga
solo cuando no lo usas.

---

## Abrirlo

**1.** Entra en tu repositorio en github.com.

**2.** Busca el botón verde que pone **Code**. Púlsalo.

**3.** En el panel que se abre hay dos pestañas: *Local* y **Codespaces**.
Pulsa **Codespaces**.

**4.** Pulsa **Create codespace on main** (o el botón verde que aparezca ahí).

**5.** Se abre una pestaña nueva y tarda **uno o dos minutos**. Verás texto
apareciendo: es normal, está montando tu ordenador.

✅ **Comprobación:** acabas tras ver un editor de código, oscuro, con una lista de
ficheros a la izquierda y un panel abajo que es la terminal.

→ *Si no ves la terminal abajo:* menú ☰ → Terminal → New Terminal.

---

## Instalar Claude Code dentro

**1.** Pincha en la terminal (el panel de abajo) y escribe esto, tal cual:

```bash
npm install -g @anthropic-ai/claude-code
```

**2.** Dale a Enter y espera. Tarda un minuto y salen muchas líneas: es normal.

**3.** Ahora escribe:

```bash
claude
```

**4.** Te pedirá iniciar sesión. Sigue lo que te diga en pantalla: te dará un enlace,
lo abres, aceptas, y vuelves.

✅ **Comprobación:** Claude te saluda dentro de la terminal y puedes escribirle.

---

## Cosas que conviene saber

- **Se guarda solo.** Puedes cerrar la pestaña: al volver, tu trabajo sigue ahí.
- **Se apaga solo** si lo dejas quieto un rato. Volver a abrirlo tarda unos segundos.
- **Para volver más adelante:** github.com/codespaces, o desde tu repositorio con el
  mismo botón **Code → Codespaces**, donde ahora aparecerá el que ya tienes.
- **Consume horas** del plan gratuito mientras está encendido. Ciérralo al terminar
  la sesión: en github.com/codespaces, los tres puntos → **Stop codespace**.

---

## Desde el móvil

Funciona: entra en github.com/codespaces desde el navegador del móvil y ábrelo.

Sirve de sobra para pedirle cosas a Claude, revisar y mirar tu app publicada. Para
una sesión larga escribiendo, una pantalla grande cansa mucho menos. Si solo tienes
el móvil, avísame y trabajamos con frases más cortas y menos idas y venidas.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| No aparece la pestaña Codespaces | Asegúrate de estar dentro de tu repositorio, no en la página de inicio de GitHub |
| Se queda cargando mucho rato | Recarga la pestaña. El trabajo no se pierde |
| "You have exceeded your quota" | Se han acabado las horas gratis del mes. Cierra los codespaces que no uses; si no, toca trabajar en local (`local.md`) |
| `npm: command not found` | Algo raro pasa con el espacio de trabajo. Bórralo y crea otro |
