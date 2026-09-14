# Los ocho hitos

Cada hito tiene un **gate**: o se cumple o el hito no está cerrado. Un hito abierto
que se da por bueno se arrastra y contamina los siguientes.

El esfuerzo típico es orientación, no promesa. Depende del producto y de la persona.

| Hito | Esfuerzo típico | Quién lo lleva |
|---|---|---|
| H0 · Preparado | 30-60 min | `builder-lab-mvp` |
| H1 · Decidido | 1 h | `builder-lab-mvp` |
| H2 · Publicado | 20-30 min | `builder-lab-mvp` |
| H3 · Se entra | 1-2 h | esta skill |
| H4 · Se usa | media jornada | esta skill |
| H5 · Funciona entero | 1 jornada o más | esta skill |
| H6 · Aguanta | media jornada | esta skill |
| H7 · Presentable | 2-3 h | esta skill |

**Si tienes una semana**, el reparto sale solo: H0-H2 el primer día, H3-H4 el segundo
y el tercero, H5 el cuarto, H6 el quinto y el sexto, H7 el séptimo. Pero el calendario
es consecuencia de los hitos, no al revés.

---

## H0 · Preparado

Cuentas creadas y un sitio donde trabajar. Lo cubre `references/preparacion.md` de la
skill `builder-lab-mvp`.

**Gate:** puedes escribir código en algún sitio y tienes acceso a GitHub, Supabase y
Vercel.

---

## H1 · Decidido

`docs/ALCANCE.md` aprobado —acción core, P0/P1/P2, lo que NO se hace y el acuerdo del
corte— y el modelo de datos aplicado con `npx prisma db push`.

**Gate:** las tablas se ven en el panel de Supabase, y la persona ha dicho que sí al
alcance y al acuerdo del corte.

---

## H2 · Publicado

La app vacía, en internet, con su URL.

Va antes que cualquier pantalla a propósito. Publicar por primera vez al final es la
causa número uno de terminar sin MVP: cuando algo falla —y falla— es mejor que falle
con una app vacía que con siete pantallas encima.

**Gate:** abres la URL desde el móvil y carga.

---

## H3 · Se entra

*Si tu app no tiene usuarios, sáltate este hito entero y borra `src/proxy.ts` y
`src/app/(auth)`.*

El scaffold ya trae login y registro. Aquí se comprueba que funcionan de verdad **en
la URL pública**, no en una pantalla de prueba.

1. Crear una cuenta y entrar.
2. Cerrar sesión y volver a entrar.
3. Abrir una página privada sin sesión: debe mandar a `/login`. Pruébalo en una
   ventana de incógnito.

**Gate:** creas una cuenta nueva en la URL pública, entras, sales y vuelves a entrar.

**Trampa:** probarlo solo con tu propia sesión ya abierta. La cuenta nueva es la
prueba; la tuya, no.

---

## H4 · Se usa

El camino core recorrible a mano: se ven datos y se crean datos. Feo está bien. Sin
estilo está bien.

1. `npm run seed` con datos realistas (nombres de verdad, fechas de verdad).
2. La pantalla principal lista esos datos, **filtrados por el usuario de la sesión**.
3. La pantalla de detalle muestra uno.
4. El formulario que crea la entidad principal: esquema zod, función en el service,
   server action, error visible si algo falla.
5. Editar y borrar, solo si el producto los necesita.

**Gate:** creas algo desde la interfaz en la URL pública, recargas, y sigue ahí.

**Trampa:** el formulario bonito. Un `input` sin estilo que guarda vale más que uno
precioso que no.

---

## H5 · Funciona entero — el hito que decide

El P0 completo. Nada más. Si el P0 ya estaba, empiezas el P1 y vas sobrado.

**Gate:** **alguien que no eres tú** —una cuenta recién creada— hace la acción core de
principio a fin en la URL pública, sin que tú le expliques nada.

Esa cuenta nueva es la prueba de verdad: descubre los datos que solo existían en tu
usuario y las pantallas que nunca viste vacías.

**Trampa:** empezar algo del P1 con el P0 a medias. Terminar gana a empezar.

**Aquí se mide el corte.** Si has gastado dos tercios de tu tiempo y este hito no está
cerrado, se recorta (ver el `SKILL.md`).

---

## H6 · Aguanta

La app deja de romperse cuando el usuario hace algo raro, y deja de tener agujeros.

1. **Estados vacíos:** qué se ve cuando no hay datos. Nunca una pantalla en blanco.
2. **Errores:** un mensaje en español, nunca un stack.
3. **Carga:** algo que indique que está trabajando.
4. **Validaciones visibles:** el usuario entiende qué ha hecho mal.
5. **Móvil:** cada pantalla a 390px, en un móvil de verdad.
6. **Seguridad:** la checklist de `seguridad-mvp.md`, entera. El punto 1
   —autorización por recurso— se prueba con una segunda cuenta.
7. Reactivar "Confirm email" en Supabase si se desactivó al principio.

**Gate:** checklist de seguridad pasada sin nada grave abierto —en especial, una
segunda cuenta no puede ver los datos de la primera— y la app usable en tu móvil.

**Trampa:** rediseñarlo todo. Aquí se pule lo que hay, no se rehace.

---

## H7 · Presentable

**Cero código nuevo.** Solo se arregla lo que rompa la demo.

1. Datos de demo definitivos que cuenten una historia.
2. Usuario de demo con credenciales que funcionan, apuntadas en el README.
3. Recorrer el camino core entero en la URL pública, **dos veces**.
4. Guion de 3 minutos y ensayarlo en voz alta (ver `demo.md`).
5. Grabación de pantalla como plan B.

**Gate:** has hecho la demo completa, en voz alta, sobre la URL pública, sin tocar
código.

---

## Lo que cuesta más de lo que parece

Dilo al principio, para que no sorprenda:

- **Subir ficheros:** medio día la primera vez.
- **Enviar emails:** medio día, y siempre hay un problema de dominio o de spam.
- **Pagos:** dos días como mínimo. Por eso están fuera.
- **Que se vea bien en móvil:** el doble de lo previsto si se deja para el final.

## Lo que cuesta menos de lo que parece

- Un CRUD de una entidad, con el modelo bien: menos de una hora.
- Una lista con filtro: media hora.
- El seed de datos: 15 minutos, y salva la demo.

## Regla que vale para los ocho

**Se publica en cada sesión.** Con Vercel es `git push`. Una sesión sin mirar la URL
pública es deuda que se cobra en la demo, con intereses.
