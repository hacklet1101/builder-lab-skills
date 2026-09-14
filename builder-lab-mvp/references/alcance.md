# Recortar el alcance

Tu trabajo en el paso 2 no es apuntar lo que quiere. Es **quitarle cosas sin que se
desanime**. Esto se hace con una regla, no con opiniones.

## La regla del camino único

Un MVP de 7 días de alguien que está aprendiendo es:

- **1 camino** de punta a punta (entrar → hacer la acción core → verla hecha)
- **2-4 tablas**
- **3-5 pantallas**
- **1 tipo de usuario** (más "el dueño" si hace falta)

Todo lo que no esté en ese camino es P2 o "Después del MVP".

## Cómo se recorta, en la práctica

Coge cada cosa que ha mencionado y pásala por estas preguntas, en orden:

1. **¿Sin esto la acción core funciona?** Si sí → no es P0.
2. **¿Se puede hacer a mano el día de la demo?** (crear usuarios, meter datos,
   enviar un email) Si sí → fuera. Un MVP puede tener trabajo manual detrás.
3. **¿Se puede enseñar con datos del seed en vez de construirlo?** Si sí → seed.
4. **¿Es una pantalla nueva o es un campo más en una que ya existe?** Campo gana.

## Lo que siempre se recorta (di que no de entrada)

| Lo que piden | Qué se hace en el MVP |
|---|---|
| Panel de administración | Prisma Studio. Es un panel de admin gratis. |
| Roles y permisos | Un solo tipo de usuario. Como mucho, un campo `isOwner`. |
| Pagos | Fuera. Si es el core: un Payment Link de Stripe, sin integración. |
| Notificaciones push / tiempo real | Fuera. Recargar la página es suficiente. |
| Buscador con filtros | Un `input` que filtra por nombre. Nada más. |
| Subida de imágenes | Solo si la acción core la necesita. Si no, una URL en un campo de texto. |
| Emails automáticos | Uno solo, con Resend, y el día 5. Si no es core, ninguno. |
| Estadísticas / dashboard | Tres números contados con `count()`. Sin gráficos. |
| Exportar a PDF / Excel | Fuera siempre. |
| Modo oscuro, animaciones, onboarding | P2. Es decir: probablemente nunca. |
| App móvil | Es una web responsive. Punto. |
| Multi-idioma | Un idioma. |

## Cómo decir que no sin desanimar

No digas "eso es demasiado". Di **dónde va**:

> *"Eso va en 'Después del MVP' — lo apunto ahora mismo para que no se pierda. El
> día 7 queremos enseñar que [acción core] funciona de verdad; si metemos esto,
> llegamos al día 7 con dos cosas a medias en vez de una entera."*

Y apúntalo **literalmente** en `ALCANCE.md`. La lista de "Después del MVP" no es un
cementerio: es lo que hace que acepte el recorte.

## Señales de que el alcance sigue siendo demasiado grande

- Más de 4 tablas en el modelo.
- Más de 5 items en P0.
- Aparece la palabra "y también" más de tres veces en la entrevista.
- Hay dos tipos de usuario con pantallas distintas.
- Hay algo que depende de un servicio externo que no sea Supabase o Resend.

Si ves dos o más, vuelve al paso 2 y recorta otra vez. Es más barato ahora.

## El acuerdo del corte

Antes de cerrar el `ALCANCE.md`, léele esto y pide un sí explícito:

> *"Si al acabar el día 5 el P0 no está terminado, borramos todo el P2 y seguimos
> solo con lo esencial. ¿De acuerdo?"*

Ese sí de hoy es lo que salva la semana. Anótalo en el documento con la fecha.
