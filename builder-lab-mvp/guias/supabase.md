# Guía — Supabase: la base de datos

**Para dictar paso a paso.** Uno cada vez. Espera confirmación antes de seguir.

**Esta es la guía donde más gente se pierde.** Ve despacio y comprueba cada paso.

Explícaselo así:
*"Supabase es donde se van a guardar los datos de tu app: los usuarios, las reservas,
lo que sea. Es una base de datos que está en internet, gratis, y no hay que instalar
nada."*

---

## Parte 1 — Crear el proyecto

**1.** Abre **supabase.com** y pulsa **Start your project** (o **Sign in** si ya tienes
cuenta).

**2.** Elige **Continue with GitHub** y acepta. Usamos GitHub para no tener otra
contraseña más.

**3.** Si es tu primera vez, te pedirá crear una **organización**. Ponle tu nombre y
elige el plan **Free**. Si te pide "¿para qué la usas?", cualquier respuesta vale.

**4.** Pulsa **New project** y rellena:
- **Name:** el nombre de tu app.
- **Database Password:** pulsa **Generate a password** para que te genere una.
  ⚠️ **Cópiala y guárdala ahora mismo** en tus notas o en tu gestor de contraseñas.
  **No se puede volver a ver.** Si la pierdes hay que cambiarla y rehacer parte de
  esto.
- **Region:** la más cercana a ti. *(Si estás en España: Frankfurt o Ireland.)*

**5.** Pulsa **Create new project**. Tarda **un par de minutos** en estar listo.

✅ **Comprobación:** cuando termine, ves el panel de tu proyecto con menús a la
izquierda (Table Editor, SQL Editor, Authentication…).

---

## Parte 2 — Las dos cadenas de conexión

Necesitamos dos direcciones distintas de la misma base de datos. Pide las dos y no
sigas sin tenerlas.

**1.** Abajo a la izquierda, pulsa el engranaje: **Project Settings**.

**2.** En el menú, entra en **Database**.

**3.** Busca el bloque **Connection string**. Verás varias pestañas u opciones.

**4.** Me tienes que pasar **dos** direcciones. Las reconoces por el **número que
llevan después de los dos puntos**, no por el nombre de la pestaña:

| Cuál | Cómo la reconoces |
|---|---|
| **La de la app** | Lleva **:6543**. Suele estar en la pestaña *Transaction pooler* o *Connection pooling* |
| **La de las migraciones** | Lleva **:5432**. Suele estar en *Session pooler* o *Direct connection* |

Las dos empiezan por `postgresql://` y son largas.

**5.** Cópialas enteras y pásamelas. Donde ponga `[YOUR-PASSWORD]`, yo pongo la
contraseña que guardaste antes.

→ *Si solo ves una*, dime qué pestañas te aparecen y lo resolvemos.
→ *Si no encuentras "Connection string"*, dime qué secciones ves dentro de Database.

---

## Parte 3 — Las claves de la API

**1.** Sigues en **Project Settings**. Entra ahora en **API** (o *API Keys*).

**2.** Necesito dos cosas:
- **Project URL** — algo como `https://abcdefgh.supabase.co`
- La clave **anon** (a veces la llaman *public* o *publishable*) — un texto larguísimo

**3.** Pásamelas.

⚠️ En esa misma pantalla hay otra clave que pone **service_role** y avisa de que es
secreta. **No me la pases ni la copies a ningún sitio.** No la necesitamos, y esa
clave da acceso total a todos los datos.

---

## Parte 4 — Que el registro funcione mientras construimos

Por defecto, Supabase manda un correo de confirmación a cada persona que se registra.
Mientras construyes eso es un incordio: cada usuario de prueba necesitaría un correo
real.

**1.** Menú izquierdo: **Authentication**.

**2.** Entra en **Sign In / Providers** (o *Providers*) y busca **Email**.

**3.** Desactiva **Confirm email**.

**4.** Guarda.

📌 **Apúntalo: esto hay que volver a activarlo antes de enseñar la app a nadie.**
Está en la checklist del hito H6.

---

## Parte 5 — Después de crear las tablas

Cuando ya hayamos aplicado el modelo de datos (yo ejecuto `npx prisma db push`):

**1.** Menú izquierdo: **Table Editor**.

✅ **Comprobación:** ves tus tablas en la lista. Si están, la base de datos está
funcionando de verdad.

**2.** En cada tabla, activa **RLS** (Row Level Security) si te aparece un aviso de
que está desactivado. Es una segunda capa de seguridad; la app sigue funcionando
igual porque entra por otra vía.

---

## Si algo va mal

| Lo que pasa | Qué hacer |
|---|---|
| Perdiste la contraseña de la base de datos | Project Settings → Database → **Reset database password**. Genera otra, guárdala, y pásamela para actualizarlo todo |
| "Project is paused" | El plan gratis pausa el proyecto tras días sin uso. Pulsa **Restore** y espera un minuto |
| La app dice que no puede conectar | Casi siempre es que la contraseña no se pegó bien dentro de la dirección, o que se usó la del puerto equivocado |
| No encuentras una sección | Supabase cambia su diseño a menudo. Dime qué ves y te digo dónde mirar |
