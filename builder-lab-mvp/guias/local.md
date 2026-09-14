# Guía — trabajar en tu propio ordenador

**Solo para quien tenga un ordenador que vaya bien y prefiera trabajar en él.**
Si va lento, es viejo, o es un móvil: usa `codespaces.md` y sáltate esta guía entera.

---

## Qué hace falta

| | Comprobar escribiendo | Si falta |
|---|---|---|
| Node 20 o superior | `node -v` | nodejs.org, versión **LTS** |
| npm 10 o superior | `npm -v` | Viene con Node. Si es viejo: `npm install -g npm@latest` |
| git | `git --version` | git-scm.com |
| Claude Code | `claude --version` | `npm install -g @anthropic-ai/claude-code` |

---

## Windows: antes de nada, WSL

En Windows hay que trabajar dentro de Linux. Es un rato de instalación, pero después
todo funciona como en el resto del mundo.

**1.** Abre **PowerShell como administrador** (botón derecho sobre el menú de inicio
→ *Terminal (Administrador)*).

**2.** Escribe:
```powershell
wsl --install
```

**3.** Reinicia el ordenador cuando te lo pida.

**4.** Al volver, se abre Ubuntu y te pide crear un usuario y una contraseña.
Apúntala: te la pedirá para instalar cosas.

**5.** A partir de ahora, **todo se hace dentro de esa ventana de Ubuntu**.

⚠️ El proyecto va en `~/proyectos`, **nunca** en `/mnt/c`. En `/mnt/c` todo va varias
veces más lento y algunas cosas fallan de forma rara.

> Esto tarda entre 20 minutos y una hora según el ordenador. Si suena a problema,
> Codespaces te lo ahorra entero.

---

## Decirle a git quién eres

```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

Sin esto, el primer intento de guardar cambios falla con un mensaje raro.

---

## Conectar con GitHub

Lo más fácil es con la herramienta oficial:

```bash
gh auth login
```

Responde: **GitHub.com** → **HTTPS** → **sí** a autenticar git → **Login with a web
browser**. Copia el código que te da, ábrelo donde te diga y acepta.

✅ **Comprobación:** `gh auth status` dice que estás conectado.

---

## Ver la app en tu ordenador

Esto es **opcional**. La app se mira normalmente en su dirección de internet.

Si quieres verla en local mientras trabajas:

```bash
npm run dev
```

Y abres `http://localhost:3000`. Para pararlo: `Ctrl+C` en esa terminal.

Va más rápido para probar cambios, pero consume recursos. Si tu ordenador sufre,
déjalo y mira la app publicada.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| `command not found: node` | No está instalado, o instalaste en Windows y estás en Ubuntu. Instálalo dentro de Ubuntu |
| `EACCES` al instalar con `-g` | No uses `sudo`. Dímelo y lo resolvemos de otra forma |
| Todo va lentísimo | ¿El proyecto está en `/mnt/c`? Muévelo a `~/proyectos` |
| Se te complica | Para y vete a Codespaces. No merece la pena perder una sesión en esto |
