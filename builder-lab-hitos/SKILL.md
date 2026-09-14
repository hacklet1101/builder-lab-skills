---
name: builder-lab-hitos
description: Ritual diario de Builder Lab para los días 2 a 7 de un MVP de 7 días. Úsala cuando alguien diga "empezamos el día 3", "qué toca hoy", "sigo con el MVP", "voy tarde", "no me va a dar tiempo", "hay que desplegar", "preparar la demo", o retome un proyecto que tiene docs/ALCANCE.md. Abre el día, elige la siguiente tarea del P0, cierra el día con deploy y checklist. No la uses para arrancar un proyecto nuevo: para eso está builder-lab-mvp.
---

# Builder Lab — día a día (días 2-7)

Un día de MVP tiene tres momentos: **abrir**, **construir**, **cerrar**. Los tres
son obligatorios. El que se salta el cierre llega al día 7 sin nada desplegado.

## Al abrir el día (5 min, siempre)

1. Lee `docs/ALCANCE.md`. En voz alta: cuál es la acción core y en qué punto del P0 estamos.
2. `git status` — si hay cambios sin commitear de ayer, commitea o descarta antes de tocar nada.
3. `git log --oneline -5` — qué se hizo ayer de verdad.
4. Di qué se va a hacer hoy: **1 a 3 items del P0**, no más. Si el P0 está completo, pasa al P1.
5. Verifica que la URL de producción sigue viva.

Nunca empieces el día preguntando "¿qué quieres hacer hoy?". Lo dice el `ALCANCE.md`.

## Durante el día

- **Una capacidad cada vez.** Antes de cada una: di qué ficheros vas a tocar, espera
  confirmación, haz commit del estado anterior, y entonces escribe.
- Cada capacidad termina **probada en el navegador**, no "debería funcionar".
- Cada pantalla se revisa a 390px el mismo día.
- Si algo sale del `ALCANCE.md`, no se construye: se anota en "Después del MVP".
- Si llevas 3 intentos con el mismo error, **para**. Lee `references/atascos.md`.

## Los seis hitos

El progreso se mide por **hitos**, no por días. El día es el objetivo; el hito es lo
que cuenta. Quien va un día por detrás no ha fallado: está en el hito 3 en vez de en
el 4, y sabe exactamente qué le falta.

| Hito | Qué significa | Día objetivo | Gate |
|---|---|---|---|
| **H1 · Arranca** | Alcance, modelo y una URL pública vacía | 1 | Lo cierra la skill `builder-lab-mvp` |
| **H2 · Se entra y se ve** | Login funciona y las pantallas del camino core muestran datos del seed | 2 | Entras con una cuenta nueva y recorres la acción core a mano, aunque sea feo |
| **H3 · Se escribe** | El formulario que crea la entidad principal | 3 | Creas algo desde la interfaz, recargas y sigue ahí. En producción |
| **H4 · P0 completo** | La acción core entera | 4 | Un usuario que no eres tú hace la acción core de principio a fin |
| **H5 · No se rompe** | Estados vacíos, errores, carga, validaciones visibles | 5 | P0 recorrido en producción con una cuenta recién creada, sin errores técnicos a la vista |
| **H6 · Presentable** | Móvil, seguridad, datos de demo y guion | 6-7 | Checklist de seguridad pasada y demo de 3 min ensayada sobre la URL pública |

**Al abrir el día, di en qué hito estás.** No "es el día 4", sino "estamos en H3 y hoy
cerramos H4". Es la diferencia entre ir con retraso y no saber dónde estás.

Detalle de cada hito en `references/hitos.md`.

## Al cerrar el día (15 min, obligatorio)

1. Todo commiteado.
2. **Push a `main`.** Vercel despliega solo. Todos los días, no solo el 7. Si el
   deploy rompe, se arregla hoy, no mañana.
3. Abre la URL pública y comprueba que lo de hoy está ahí.
4. Actualiza `docs/ALCANCE.md`: marca lo hecho.
5. Escribe en dos líneas dónde se retoma mañana.

Si el deploy falla y no se arregla en 30 minutos: rollback al commit anterior
(`references/atascos.md` § rollback) y se investiga mañana con la cabeza fresca.
Nunca se acaba el día con producción rota.

## El corte — protocolo de pánico

**Se dispara cuando acaba el día 5 y H4 (P0 completo) no está cerrado:**

1. Se borra **todo el P2** del repo. Hoy, no "cuando haya tiempo".
2. Se recorta el P1 a lo imprescindible para que la demo no dé vergüenza.
3. Se reescribe el `ALCANCE.md` con lo que queda y se acepta.

Esto no es un fracaso, es el plan. Se decidió el día 1. Recuérdaselo con esas
palabras: *"esto ya lo decidiste el lunes"*.

Un MVP con una sola cosa que funciona bien es un MVP. Cinco cosas a medias no lo son.

## Señales de alarma — dilas en voz alta

- Acaba el día 3 y H3 no está (nada se guarda todavía) → recortar ya, no el día 5.
- Estás en H3 y se está tocando el diseño → parar el diseño, cerrar H4.
- La persona quiere añadir una feature que no está en el `ALCANCE.md` → "Después del MVP".
- Se está reescribiendo algo que ya funcionaba → parar. Funcionar gana a elegante.
- Dos días sin desplegar → desplegar ahora mismo.

## Referencias

| Fichero | Cuándo |
|---|---|
| `references/hitos.md` | Detalle de cada día y sus gates |
| `references/atascos.md` | 3 intentos fallidos, bucles, deploy roto, rollback |
| `references/demo.md` | Día 7: datos de demo, guion de 3 minutos, ensayo |

Las convenciones de código, estructura y seguridad están en el `CLAUDE.md` del
proyecto. No las repitas aquí: léelas de allí.
