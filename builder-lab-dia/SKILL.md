---
name: builder-lab-dia
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

## Qué toca cada día

| Día | Objetivo | Gate para darlo por cerrado |
|---|---|---|
| 2 | Login y registro funcionando, y las 2 pantallas del camino core con datos del seed | Entras con una cuenta nueva y recorres la acción core a mano, aunque sea feo |
| 3 | Escritura real: crear/editar la entidad principal | Los datos persisten y se ven tras recargar |
| 4 | Terminar P0 + el resto del camino core | **P0 completo de punta a punta en local** |
| 5 | P1: lo que hace la app usable (errores, vacíos, carga) | P0 recorrido en producción con una cuenta recién creada, sin errores técnicos a la vista |
| 6 | Pulido visual, móvil, auditoría de seguridad | Checklist de seguridad pasada entera, con lo grave corregido |
| 7 | Datos de demo, deploy final, guion y ensayo | Demo de 3 min ensayada sobre la URL pública |

Detalle de cada día en `references/plan-7-dias.md`.

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

## La regla del día 5 — el protocolo de pánico

**Día 5, 18:00. Si el P0 no está completo:**

1. Se borra **todo el P2** del repo. Hoy, no "cuando haya tiempo".
2. Se recorta el P1 a lo imprescindible para que la demo no dé vergüenza.
3. Se reescribe el `ALCANCE.md` con lo que queda y se acepta.

Esto no es un fracaso, es el plan. Se decidió el día 1. Recuérdaselo con esas
palabras: *"esto ya lo decidiste el lunes"*.

Un MVP con una sola cosa que funciona bien es un MVP. Cinco cosas a medias no lo son.

## Señales de alarma — dilas en voz alta

- Día 3 y todavía no hay nada que se guarde en la base de datos → recortar ya.
- Día 4 y se está tocando el diseño → parar el diseño, terminar P0.
- La persona quiere añadir una feature que no está en el `ALCANCE.md` → "Después del MVP".
- Se está reescribiendo algo que ya funcionaba → parar. Funcionar gana a elegante.
- Dos días sin desplegar → desplegar ahora mismo.

## Referencias

| Fichero | Cuándo |
|---|---|
| `references/plan-7-dias.md` | Detalle de cada día y sus gates |
| `references/atascos.md` | 3 intentos fallidos, bucles, deploy roto, rollback |
| `references/demo.md` | Día 7: datos de demo, guion de 3 minutos, ensayo |

Las convenciones de código, estructura y seguridad están en el `CLAUDE.md` del
proyecto. No las repitas aquí: léelas de allí.
