# Antipatrones — lo que NO se hace en 7 días

Casi todo lo de esta lista es **buena ingeniería** en un producto de dos años. Aquí
mata el MVP porque consume los días que necesitas para que la acción core funcione.

## Arquitectura

| Antipatrón | Qué hacer |
|---|---|
| Monorepo, workspaces, `packages/` | Un `package.json`. Módulos = carpetas en `src/modules/` |
| Frontend y backend separados | Next.js full-stack. Los route handlers son el backend |
| Microservicios, colas, workers | Nada. Si algo tarda, que tarde |
| Redis / caché | Postgres aguanta. No hay tráfico que cachear |
| Websockets / tiempo real | Recargar la página |
| Multi-tenant, organizaciones, workspaces | Un usuario, sus datos |
| Sistema de plugins o módulos dinámicos | Código normal |
| i18n | Un idioma |
| Feature flags | Ramas no, flags no. Se construye o no se construye |
| Capa de repositorios sobre Prisma | Prisma ya es esa capa. El service la usa directo |
| `types/` global con 300 interfaces | Los tipos viven al lado de lo que describen |

## Tooling

| Antipatrón | Qué hacer |
|---|---|
| Husky, commitlint, lint-staged | Nada. Commits a mano, con cabeza |
| CI/CD con tests y linters | Vercel despliega al hacer push. Suficiente |
| Storybook | No |
| Docker para desarrollo | `npm run dev`. Docker solo para el deploy |
| Configuración de ESLint/Prettier personalizada | La que trae `create-next-app` |
| Documentación generada (mkdocs, C4, ADRs) | Un `README.md` y `docs/ALCANCE.md` |
| Cobertura de tests | Ninguno. Se prueba a mano, en producción, con una cuenta nueva |

## Producto

| Antipatrón | Qué hacer |
|---|---|
| Panel de administración | Prisma Studio |
| Roles y permisos | Un tipo de usuario |
| Onboarding, tour, tooltips | No |
| Modo oscuro | No |
| Exportar a PDF/Excel | No |
| Gráficos y estadísticas | Tres números con `count()` |
| Landing page de marketing | La app ES la landing |
| Página de precios, planes | No hay pagos en el MVP |

## Proceso

- **Ramas y pull requests.** Es una persona. Commits pequeños a `main`.
- **Refactorizar algo que funciona.** Si funciona, se deja. Se refactoriza después.
- **Dejar el deploy para el final.** Deploy el día 1 y todos los días.
- **Diseñar antes de que funcione.** Primero funciona feo, luego se pule.
- **Meter auth el día 6.** Si el producto tiene usuarios, auth el día 1: añadirla
  después obliga a reescribir cada query para filtrar por usuario.

## Cuando quieren cambiar el stack

Va a pasar: *"¿y si usamos MongoDB?"*, *"un amigo me ha dicho que Supabase no hace
falta"*, *"he visto un vídeo de Astro"*.

Respuesta:

> *"El stack está cerrado para la formación: Next, Prisma, Supabase, Vercel. No
> porque sea el único bueno, sino porque es el que podemos ayudarte a arreglar
> cuando se rompa el jueves a las once de la noche. Cambiarlo te cuesta dos días de
> los siete."*

Y sigues. **No** abras un debate técnico: quien pregunta no tiene criterio para
resolverlo y el debate consume la mañana.

Excepción real y única: si la acción core es imposible con este stack (un juego 3D,
algo que necesita Python para modelos de IA). Entonces se replantea el producto,
no el stack.

## Cuando Claude Code propone de más

Si te ves a ti mismo generando: tests que nadie pidió, un `docker-compose.yml` de
desarrollo, una carpeta `types/`, un sistema de logs, un manejador de errores
genérico, un `constants.ts` con 40 valores, un hook `useX` para algo que se usa una
vez — **para**. Nada de eso estaba en `ALCANCE.md`.

La pregunta de control: *¿esto hace que la acción core funcione antes?* Si no, fuera.

## De dónde sale esta lista

No es teoría: cada punto está tomado de dos productos reales en producción —un ERP
modular multi-tenant y una plataforma financiera con backend propio— y funciona bien
**ahí**. Lo que lo convierte en antipatrón es el plazo.

| Antipatrón | Cómo se ve en un producto grande |
|---|---|
| Monorepo pnpm + turbo | `pnpm-workspace.yaml` + `turbo.json`, builds orquestados entre paquetes |
| Packages internos | 11 y 4 paquetes propios (`core`, `db`, `ui`, `i18n`, `types`…) |
| Múltiples apps | `apps/web` + `apps/workers` + un admin aparte |
| Sistema de módulos con manifest | 26 bloques, cada uno con su `module.json` y su mapa de dependencias generado |
| Multi-tenant / white-label | Workspaces, marca configurable, test e2e de aislamiento entre tenants |
| i18n | Cientos de referencias a locale y un gate de CI que falla si hay texto sin traducir |
| Migraciones manuales | multiSchema obliga a añadir constraints a mano al SQL generado |
| C4 / documentación generada | Diagramas de arquitectura generados con Structurizr |
| commitlint + husky | Gate automático de mensajes de commit. **Uno de los dos repos no lo usa** y mantiene el 100% de commits conventional solo con disciplina escrita en su CLAUDE.md |
| Themes intercambiables | 3 temas + un paquete adaptador |
| Workers y colas | Una app aparte con BullMQ |
| Redis | Rate limiting, caché y colas; decenas de ficheros dependen de él |
| Feature flags en BD | Gestor con precedencia base de datos > variable de entorno |
| CODEOWNERS | 57 líneas, un dueño por bloque |
| Worktrees y lanes | Varias ramas `lane-*` en paralelo con protocolo de reservas de ruta |

Si el alumno pregunta *"pero en proyectos de verdad se hace así"*: sí, en productos
con años de vida y varias personas. Su MVP tiene 7 días y una persona.
