# Los seis hitos

La promesa son 7 días. El trabajo se mide en **hitos**: cada uno tiene un día
objetivo y un gate que no es opinable. Ir un día por detrás no es fracasar; es estar
en el hito anterior y saberlo.

| | | Día |
|---|---|---|
| H1 | Arranca | 1 |
| H2 | Se entra y se ve | 2 |
| H3 | Se escribe | 3 |
| H4 | P0 completo | 4 |
| H5 | No se rompe | 5 |
| H6 | Presentable | 6-7 |

**H4 es el que decide si hay MVP.** Todo lo que va después es acabado.

---

## H1 · Arranca — día 1

Lo cubre la skill `builder-lab-mvp`.

**Gate H1:** existe una URL pública que carga, `docs/ALCANCE.md` aprobado y el primer
commit hecho.

---

## H2 · Se entra y se ve — día 2

**Primero el login.** El scaffold ya lo trae; hoy se comprueba que funciona de verdad.
Si el producto no tiene usuarios, sáltate los puntos 1 y 2.

1. Crear una cuenta desde `/login` y entrar. Cerrar sesión y volver a entrar.
2. Una página privada manda a `/login` si no hay sesión (pruébalo en incógnito).
3. `npm run seed` con datos realistas (nombres de verdad, fechas de verdad).
4. La pantalla principal lista esos datos, **filtrados por el usuario de la sesión**.
5. La pantalla de detalle muestra uno.
6. Navegación mínima entre ambas.

Feo está bien. Sin estilo está bien. El objetivo es **ver datos reales en pantalla**.

**Gate:** creas una cuenta nueva en producción, entras, y recorres el camino core con
el ratón, aunque todavía no se pueda crear nada. Desplegado.

**Trampa de H2:** ponerse a diseñar. Si aparece la palabra "color", vuelve a la lista.

---

## H3 · Se escribe — día 3

El formulario que crea la entidad principal, de punta a punta.

1. Esquema zod en `<feature>.schema.ts`.
2. Función de creación en `<feature>.service.ts`.
3. Server action o route handler que valida y llama al service.
4. Formulario, con el error visible si la validación falla.
5. Editar y borrar, si el producto los necesita. Si no, no.

**Gate:** creas algo desde la interfaz, recargas y sigue ahí. En producción, no solo
en local.

**Trampa de H3:** el formulario bonito. Un `input` sin estilo que guarda vale más
que uno precioso que no.

---

## H4 · P0 completo — día 4

El día que decide si hay MVP. Se termina **todo** lo que queda del P0 y nada más.

- Si el P0 ya estaba, se empieza el P1 y vas bien.
- Si falta más de la mitad del P0, **avisa hoy**: mañana toca recortar.

**Gate:** la acción core funciona de punta a punta, en producción, con un usuario que
no eres tú (crea una cuenta nueva y hazlo).

**Trampa de H4:** empezar algo nuevo del P1 con el P0 a medias. Terminar gana a empezar.

---

## H5 · No se rompe — día 5

Hoy la app deja de romperse cuando el usuario hace algo raro.

1. **Estados vacíos:** qué se ve cuando no hay datos. Nunca una pantalla en blanco.
2. **Errores:** qué se ve cuando algo falla. Un mensaje en español, no un stack.
3. **Carga:** algo que indique que está trabajando.
4. **Validaciones visibles:** el usuario entiende qué ha hecho mal.

**Al acabar el día 5 — el corte.** Si H4 no está cerrado: se borra todo el P2, se
recorta el P1 y se reescribe el `ALCANCE.md`. Se decidió el día 1.

**Gate:** recorres el P0 entero **en producción, con una cuenta recién creada**, y la
app no enseña ningún error técnico. Esa cuenta nueva es la prueba de verdad: descubre
los datos que solo existían en tu usuario y las pantallas que nunca viste vacías.

---

## H6 · Presentable (1/2) — día 6

1. **Móvil primero:** cada pantalla a 390px. Es donde se va a ver la demo.
2. Tipografía, espaciados y colores desde los tokens. Cero hex sueltos
   (`npm run check`).
3. Estados de foco y botones que se ven pulsados. Nada más de diseño.
4. **Auditoría de seguridad:** la checklist del día 6, al final de
   `seguridad-mvp.md` (en la skill `builder-lab-mvp`). Se pasa entera. El punto 1,
   autorización por recurso, se prueba con una segunda cuenta.
5. Reactivar "Confirm email" en Supabase si se desactivó el día 1.

**Gate:** checklist de seguridad pasada entera y sin nada grave abierto —en especial,
una segunda cuenta no puede ver los datos de la primera—, y la app usable en un móvil
de verdad (el tuyo, no el simulador).

**Trampa de H6:** rediseñarlo todo. Hoy se pule lo que hay, no se rehace.

---

## H6 · Presentable (2/2) — día 7

**Cero código nuevo.** Hoy no se arregla nada que no rompa la demo.

1. Datos de demo definitivos: `npm run seed` con contenido que cuente una historia.
2. Usuario de demo con credenciales que funcionan, apuntadas en el README.
3. Deploy final y **recorrer el camino core entero en producción**, dos veces.
4. README actualizado con la URL y las credenciales.
5. Guion de 3 minutos y **ensayarlo en voz alta** (ver `demo.md`).

**Gate:** has hecho la demo completa, en voz alta, sobre la URL pública, sin tocar
código. Si algo falla durante el ensayo, eso —y solo eso— se arregla.

---

## Regla que vale para los seis hitos

**Se despliega todos los días.** Un día sin desplegar es deuda que se cobra el día 7
con intereses.
