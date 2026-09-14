# Plan de 7 días — resumen

El detalle diario, los gates y el protocolo de pánico están en la skill
**`builder-lab-dia`**, que se invoca cada mañana. Esto es solo el mapa para
explicárselo a la persona el día 1.

| Día | Qué pasa | Al final del día existe |
|---|---|---|
| **1** | Entrevista, alcance, modelo de datos, scaffolding, **deploy vacío** | Una URL pública que carga, y `ALCANCE.md` aprobado |
| **2** | Las pantallas del camino core, leyendo datos del seed | Puedes recorrer la acción core a mano, aunque sea feo |
| **3** | Escritura real: crear y editar la entidad principal | Los datos persisten y siguen ahí al recargar |
| **4** | Terminar el P0 completo | La acción core funciona de punta a punta en local |
| **5** | P1: errores, estados vacíos, carga. Test e2e. **Corte de P2 si hace falta** | La app no se rompe si el usuario hace algo raro |
| **6** | Pulido visual, móvil, auditoría de seguridad | Se ve bien en un móvil y no tiene agujeros graves |
| **7** | Datos de demo, deploy final, guion y ensayo | Demo de 3 minutos ensayada sobre la URL pública |

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

## El día que se decide todo

El **día 4**. Si el día 4 por la noche el P0 no está cerca de estar completo, el día
5 se recorta. Quien llega al día 5 con el P0 hecho, termina. Quien llega con el 60%
y cinco cosas empezadas, no.
