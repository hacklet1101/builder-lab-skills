# Los 7 días — resumen

El detalle, los gates y el protocolo de corte están en la skill **`builder-lab-dia`**,
que se invoca cada mañana. Esto es el mapa para explicárselo a la persona el día 1.

La promesa son 7 días. El trabajo se mide en **seis hitos**, cada uno con su día
objetivo: quien va un día por detrás no ha fallado, está en el hito anterior y sabe
exactamente qué le falta.

| Hito | Qué significa | Día | Al cerrarlo existe |
|---|---|---|---|
| **H1 · Arranca** | Entrevista, alcance, modelo, scaffold, **deploy vacío** | 1 | Una URL pública que carga y un `ALCANCE.md` aprobado |
| **H2 · Se entra y se ve** | Login y las pantallas del camino core con datos del seed | 2 | Entras con una cuenta nueva y recorres la acción core a mano |
| **H3 · Se escribe** | El formulario que crea la entidad principal | 3 | Creas algo, recargas y sigue ahí |
| **H4 · P0 completo** | La acción core entera | 4 | Alguien que no eres tú hace la acción core de principio a fin |
| **H5 · No se rompe** | Errores, estados vacíos, carga. **Corte de P2 si hace falta** | 5 | La app aguanta que el usuario haga cosas raras |
| **H6 · Presentable** | Móvil, seguridad, datos de demo, guion | 6-7 | Demo de 3 minutos ensayada sobre la URL pública |

**H4 es el hito que decide si hay MVP.** Lo de después es acabado.

## Lo que cuesta más de lo que parece

Dilo el día 1, para que no sorprenda:

- **Auth completa** (registro, login, recuperar contraseña): casi un día si se hace a
  mano. Por eso usamos Supabase Auth.
- **Subir ficheros**: medio día la primera vez.
- **Enviar emails**: medio día, y siempre hay un problema de dominio o de spam.
- **Pagos**: dos días como mínimo. Por eso están fuera.
- **El primer deploy**: 2-4 horas si es el día 7 y tienes prisa. 30 minutos si es el
  día 1 y la app está vacía.
- **Que se vea bien en móvil**: el doble de lo previsto si se deja para el final.

## Lo que cuesta menos de lo que parece

- CRUD de una entidad con Claude Code: menos de una hora si el modelo está bien.
- Una pantalla de lista con filtro: media hora.
- El seed de datos: 15 minutos y salva la demo.

## El hito que decide todo

**H4.** Si al acabar el día 4 el P0 no está cerca, el 5 se recorta. Quien llega al
día 5 con H4 cerrado, termina. Quien llega con el 60% y cinco cosas empezadas, no.
