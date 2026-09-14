# Builder Lab — skills de Claude Code

Dos skills que llevan a alguien de cero a un MVP desplegado en 7 días, con la
estructura y las convenciones de Builder Lab.

| Skill | Cuándo se usa |
|---|---|
| **`builder-lab-mvp`** | Día 1. Entrevista, alcance, modelo de datos, scaffolding y primer deploy |
| **`builder-lab-dia`** | Días 2-7. Ritual diario, gates, protocolo de recorte, demo |

## Instalación

```bash
git clone https://github.com/hacklet1101/builder-lab-skills.git ~/builder-lab-skills
bash ~/builder-lab-skills/install.sh
```

Crea enlaces simbólicos en `~/.claude/skills/`. Para actualizar: `git pull`.

Comprueba que funciona diciéndole a Claude Code: *"quiero arrancar el MVP de mi app"*.

## Antes del día 1

```bash
bash ~/builder-lab-skills/builder-lab-mvp/scripts/check-entorno.sh
```

Y ten listas estas cuentas: **Supabase**, **Vercel** y **GitHub**.

## El stack

Next.js (App Router) · TypeScript · Prisma · PostgreSQL en Supabase · Supabase Auth ·
Tailwind · Vercel (plan gratuito).

Está cerrado a propósito: uniforme para todos los alumnos, para poder ayudarles
cuando algo se rompa.

## Qué hay dentro

```
builder-lab-mvp/
  SKILL.md              flujo del día 1
  references/           día 0, alcance, modelo de datos, estructura, supabase,
                        seguridad, deploy, antipatrones
  templates/            CLAUDE.md, ALCANCE.md, schema.prisma, env/db/seed,
                        tokens.css, globals.css, page/layout…
  scripts/              check-entorno.sh, init-mvp.sh, check-reglas.sh
builder-lab-dia/
  SKILL.md              ritual diario
  references/           plan de 7 días, atascos, demo
test-skill.sh           prueba el skill de punta a punta
```

## Antes de cada edición de la formación

```bash
bash test-skill.sh
```

Crea un proyecto en un temporal, compila, comprueba tipos y valida las reglas. El
ecosistema cambia debajo —versiones de Next, de Prisma, de Tailwind— y este comando
es lo que avisa antes de que se entere un alumno.

La pieza más importante es `builder-lab-mvp/templates/CLAUDE.md`: es lo que se copia
al proyecto del alumno y lo que Claude Code lee en **cada** sesión durante los 7 días.
Los skills se invocan de vez en cuando; ese fichero actúa siempre.

## Las reglas se comprueban solas

Dentro del proyecto de un alumno, `npm run check` dice en 2 segundos si respeta las
fronteras, los tokens de diseño, los secretos y la autorización. Una regla que no se
verifica con un comando no se cumple: los dos repos que sirvieron de referencia para
este kit definían tokens de color y aun así tenían 16 y 33 colores sueltos.

## Licencia

MIT. Úsalo, cópialo y adáptalo.
