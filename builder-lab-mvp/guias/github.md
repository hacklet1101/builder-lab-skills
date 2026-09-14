# Guía — GitHub: cuenta y repositorio

**Para dictar paso a paso.** Uno cada vez. Espera confirmación antes de seguir.

GitHub es donde va a vivir el código. Explícaselo así si pregunta:
*"Es como Google Drive, pero para código: guarda todas las versiones y desde ahí se
publica la app sola."*

---

## Parte 1 — La cuenta (sáltala si ya la tiene)

**1.** Abre **github.com** y pulsa **Sign up**.

**2.** Te pide correo, contraseña y un nombre de usuario.
> El nombre de usuario se va a ver en la dirección de tu código. Algo sencillo y sin
> tonterías: tu nombre, o tu nombre y un número.

**3.** Confirma el correo con el código que te llega.

✅ **Comprobación:** ¿ves tu nombre de usuario arriba a la derecha, en un círculo?

---

## Parte 2 — El repositorio

Un repositorio es la carpeta de tu proyecto en GitHub.

**1.** Arriba a la derecha hay un **+**. Púlsalo y elige **New repository**.

**2.** Rellena así:
- **Repository name:** el nombre del proyecto, en minúsculas y con guiones.
  *Ejemplo: `reservas-gimnasio`.* Sin espacios, sin mayúsculas, sin acentos.
- **Description:** una frase. Opcional.
- **Private** ← **importante, marca privado.** Tu código tendrá claves dentro.
- **NO marques** "Add a README file" ni ninguna de las otras casillas. Lo queremos
  vacío del todo.

**3.** Pulsa **Create repository**.

✅ **Comprobación:** deberías ver una página con instrucciones y comandos de git, y
arriba el nombre de tu repositorio con una etiqueta que dice **Private**.

→ *Si ves ficheros en vez de instrucciones*, es que marcaste alguna casilla. No pasa
nada, dímelo y lo resolvemos.

**4.** Copia la dirección del repositorio de la barra del navegador y pásamela.
Tiene esta pinta: `https://github.com/tu-usuario/reservas-gimnasio`

---

## Parte 3 — Que tu espacio de trabajo pueda subir código

Esto depende de dónde estés trabajando:

- **Codespaces** (navegador): no hay que hacer nada, ya está conectado.
- **Tu ordenador:** hace falta conectar la cuenta una vez. Guía: `local.md`.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| "Username is not available" | Ese nombre está cogido. Prueba con otro |
| No llega el correo de confirmación | Mira en spam. Si no, reenvíalo desde la web |
| Te pide configurar 2FA (doble factor) | Hazlo, GitHub lo exige. Con la app del móvil o por SMS |
| Creaste el repositorio público sin querer | Settings → abajo del todo → Change visibility → Private |
