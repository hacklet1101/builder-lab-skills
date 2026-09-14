---
name: builder-lab-hitos
description: Avanzar un MVP de Builder Lab hito a hito, desde que el proyecto existe hasta la demo. Úsala cuando alguien diga "qué toca ahora", "sigo con mi app", "en qué hito estoy", "voy tarde", "no me va a dar tiempo", "hay que publicar", "preparar la demo", o retome un proyecto que ya tiene docs/ALCANCE.md. Abre la sesión, elige lo siguiente del P0, cierra la sesión con el trabajo publicado. No la uses para arrancar un proyecto nuevo: para eso está builder-lab-mvp.
---

# Builder Lab — avanzar por hitos

El progreso **no se mide en días**. Hay quien cierra tres hitos en una tarde y quien
tarda dos días en uno. Se mide en hitos, y cada hito tiene un gate que no es opinable.

Una sesión de trabajo tiene tres momentos: **abrir**, **construir**, **cerrar**. Los
tres son obligatorios. Quien se salta el cierre llega a la demo sin nada publicado.

## Los ocho hitos

| Hito | Está cerrado cuando… |
|---|---|
| **H0 · Preparado** | Tienes las cuentas y un sitio donde trabajar |
| **H1 · Decidido** | `docs/ALCANCE.md` aprobado y el modelo de datos aplicado |
| **H2 · Publicado** | Hay una URL pública que carga, aunque la app esté vacía |
| **H3 · Se entra** | Registro y login funcionan en esa URL *(se salta si tu app no tiene usuarios)* |
| **H4 · Se usa** | El camino core se recorre a mano: se ven datos y se crean datos |
| **H5 · Funciona entero** | El P0 completo, de punta a punta, hecho por alguien que no eres tú |
| **H6 · Aguanta** | Errores, pantallas vacías, móvil y la checklist de seguridad |
| **H7 · Presentable** | Datos de demo, guion de 3 minutos y ensayo |

H0, H1 y H2 los cierra la skill `builder-lab-mvp`. De H3 en adelante, esta.

**H5 es el hito que decide si hay MVP.** Todo lo que viene después es acabado.

Si te preguntan cuánto falta, responde en hitos: *"H4 cerrado, estamos dentro de H5,
te queda la pantalla de confirmación"*. Nunca "vas por el 60%".

## Al abrir la sesión (5 min, siempre)

1. Lee `docs/ALCANCE.md`. Di en voz alta cuál es la acción core y **en qué hito estás**.
2. `git status` — si hay cambios sin guardar de la última vez, commitea o descarta
   antes de tocar nada.
3. `git log --oneline -5` — qué se hizo de verdad la última vez.
4. Di qué se va a cerrar hoy: **un hito, o un trozo concreto de uno**. No más.
5. Abre la URL pública y comprueba que sigue viva.

Nunca empieces preguntando "¿qué quieres hacer?". Lo dice el `ALCANCE.md`.

## Durante

- **Una capacidad cada vez.** Antes de cada una: di qué ficheros vas a tocar, espera
  confirmación, commitea lo anterior, y entonces escribe.
- Cada capacidad termina **probada en la URL pública**, no "debería funcionar".
- Cada pantalla se mira a 390px de ancho el mismo día que se hace.
- Si algo sale del `ALCANCE.md`, no se construye: se anota en "Después del MVP".
- Si llevas 3 intentos con el mismo error, **para**. Lee `references/atascos.md`.

## Al cerrar la sesión (15 min, obligatorio)

1. Todo commiteado y subido (`git push`).
2. Vercel publica solo. Abre la URL y comprueba que lo de hoy está ahí.
3. `npm run check` en verde.
4. Actualiza `docs/ALCANCE.md`: marca lo hecho y anota el hito en el que estás.
5. Escribe en dos líneas dónde se retoma.

Si la publicación falla y no se arregla en 30 minutos: rollback (ver
`references/atascos.md`) y se investiga con la cabeza fresca. **Nunca se termina una
sesión con la URL pública rota.**

## El corte — protocolo de pánico

No se dispara en una fecha. Se dispara cuando **has gastado dos tercios de tu tiempo
y H5 no está cerrado**. En una semana de trabajo, eso cae al final del quinto día.

1. Se borra **todo el P2** del repo. Ahora, no "cuando haya tiempo".
2. Se recorta el P1 a lo imprescindible para que la demo no dé vergüenza.
3. Se reescribe el `ALCANCE.md` con lo que queda y se acepta.

Esto no es un fracaso, es el plan: se decidió al aprobar el alcance. Recuérdaselo con
esas palabras: *"esto ya lo decidiste tú al principio"*.

Un MVP con una sola cosa que funciona bien es un MVP. Cinco cosas a medias no lo son.

## Señales de alarma — dilas en voz alta

- Estás en H4 y todavía no se guarda nada → recortar ya, no al final.
- Estás en H4 o H5 y se está tocando el diseño → parar el diseño, cerrar el hito.
- Quieren añadir algo que no está en el `ALCANCE.md` → "Después del MVP".
- Se está reescribiendo algo que ya funcionaba → parar. Funcionar gana a elegante.
- Dos sesiones sin mirar la URL pública → mirarla ahora mismo.

## Referencias

| Fichero | Cuándo |
|---|---|
| `references/hitos.md` | Qué hay dentro de cada hito y su gate |
| `references/atascos.md` | 3 intentos fallidos, bucles, publicación rota, rollback |
| `references/demo.md` | H7: datos de demo, guion de 3 minutos, ensayo |

Las guías paso a paso para dictar viven en la otra skill, y se pueden leer desde aquí:

| Guía | Para qué |
|---|---|
| `~/.claude/skills/builder-lab-mvp/guias/subir-cambios.md` | Guardar y publicar los cambios |
| `~/.claude/skills/builder-lab-mvp/guias/vercel.md` | Si hay que tocar algo del despliegue |
| `~/.claude/skills/builder-lab-mvp/guias/supabase.md` | Si hay que tocar la base de datos o el login |

**La primera vez que alguien tiene que guardar cambios, dicta la guía entera.** A
partir de la tercera vez ya lo hace solo.

Las convenciones de código, estructura y seguridad están en el `CLAUDE.md` del
proyecto. No las repitas aquí: léelas de allí.
