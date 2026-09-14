# Los 7 días, día a día

Cada día tiene un **objetivo** y un **gate**. El gate no es opinable: o se cumple o
el día no está cerrado. Un día sin cerrar se arrastra y se come el siguiente.

---

## Día 1 — Alcance, modelo, scaffold, deploy vacío

Lo cubre la skill `builder-lab-mvp`.

**Gate:** existe una URL pública que carga, `docs/ALCANCE.md` aprobado y el primer
commit hecho.

---

## Día 2 — Entrar y ver datos

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

**Trampa del día 2:** ponerse a diseñar. Si aparece la palabra "color", vuelve a la lista.

---

## Día 3 — Escribir datos

El formulario que crea la entidad principal, de punta a punta.

1. Esquema zod en `<feature>.schema.ts`.
2. Función de creación en `<feature>.service.ts`.
3. Server action o route handler que valida y llama al service.
4. Formulario, con el error visible si la validación falla.
5. Editar y borrar, si el producto los necesita. Si no, no.

**Gate:** creas algo desde la interfaz, recargas y sigue ahí. En producción, no solo
en local.

**Trampa del día 3:** el formulario bonito. Un `input` sin estilo que guarda vale más
que uno precioso que no.

---

## Día 4 — Cerrar el P0

El día que decide si hay MVP. Se termina **todo** lo que queda del P0 y nada más.

- Si el P0 ya estaba, se empieza el P1 y vas bien.
- Si falta más de la mitad del P0, **avisa hoy**: mañana toca recortar.

**Gate:** la acción core funciona de punta a punta, en producción, con un usuario que
no eres tú (crea una cuenta nueva y hazlo).

**Trampa del día 4:** empezar algo nuevo del P1 con el P0 a medias. Terminar gana a empezar.

---

## Día 5 — Que no se rompa + el corte

Hoy la app deja de romperse cuando el usuario hace algo raro.

1. **Estados vacíos:** qué se ve cuando no hay datos. Nunca una pantalla en blanco.
2. **Errores:** qué se ve cuando algo falla. Un mensaje en español, no un stack.
3. **Carga:** algo que indique que está trabajando.
4. **Validaciones visibles:** el usuario entiende qué ha hecho mal.
5. Un test e2e del camino core (Playwright). **Uno.**
6. Cambio de `db push` a `migrate dev --name init` (ver `modelo-datos.md` del skill de arranque).

**A las 18:00 — la regla del día 5.** Si el P0 no está completo: se borra todo el P2,
se recorta el P1 y se reescribe el `ALCANCE.md`. Se decidió el día 1.

**Gate:** el test e2e pasa y la app no enseña ningún error técnico al usuario.

---

## Día 6 — Que se vea bien + que no sea vulnerable

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

**Trampa del día 6:** rediseñarlo todo. Hoy se pule lo que hay, no se rehace.

---

## Día 7 — Demo

**Cero código nuevo.** Hoy no se arregla nada que no rompa la demo.

1. Datos de demo definitivos: `npm run seed` con contenido que cuente una historia.
2. Usuario de demo con credenciales que funcionan, apuntadas en el README.
3. Deploy final y **recorrer el camino core entero en producción**, dos veces.
4. README actualizado con la URL y las credenciales.
5. Guion de 3 minutos y **ensayarlo en voz alta** (ver `demo.md`).

**Gate:** has hecho la demo completa, en voz alta, sobre la URL pública, sin tocar
código. Si algo falla durante el ensayo, eso —y solo eso— se arregla.

---

## Regla que vale para los 7 días

**Se despliega todos los días.** Un día sin desplegar es deuda que se cobra el día 7
con intereses.
