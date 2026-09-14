# La demo

Un MVP que funciona y no se sabe presentar se percibe como un fracaso. La demo no es
el adorno: es el entregable.

## Datos de demo

La demo se hace con el seed, no con lo que quedó de las pruebas.

- Nombres reales, no "Test 1", "asdasd", "prueba".
- Fechas coherentes: cosas la semana que viene, no en 1970.
- Cantidad suficiente para que la pantalla se vea llena, pero no tanta que estorbe.
  5-8 elementos.
- Un usuario de demo con contraseña que funciona, **apuntada en el README**.

Comprueba que los datos de demo están **en la base de datos que usa la URL pública**,
no solo en la tuya. Comprobado hoy, no cinco minutos antes de presentar.

## El guion de 3 minutos

```
0:00  El problema
      "Cuando [usuario] quiere [algo], hoy tiene que [dolor actual]."
      Una frase. Sin currículum, sin "llevo tiempo pensando".

0:20  Qué he construido
      "He hecho [nombre], donde [usuario] puede [acción core]."

0:40  LA DEMO. En vivo, sobre la URL pública.
      Recorres el camino core de punta a punta. En silencio si hace falta:
      que se vea funcionar.
      Nada de "esto todavía no está", "aquí falta", "perdón por el diseño".

2:20  Qué he aprendido
      Una cosa técnica y una cosa sobre el producto.

2:40  Qué viene después
      Los dos primeros items de "Después del MVP". Que se vea que sabes dónde vas.
```

## Reglas de la demo

- **En vivo, sobre la URL pública.** No en local, no un vídeo, no capturas.
- **Ensayada en voz alta, entera, al menos dos veces.** Cronometrada.
- **Nunca pidas perdón.** No digas "es muy simple" ni "solo hace una cosa". Hace una
  cosa **y funciona**, que es más de lo que se termina normalmente en 7 días.
- Si algo falla en vivo: lo dices con naturalidad, sigues con lo siguiente, y te lo
  apuntas. Nadie recuerda el fallo; recuerdan si te bloqueaste.
- **Plan B:** una grabación de pantalla del camino core hecha hoy. Si internet falla,
  la pones. Que exista aunque no se use. Desde el móvil se graba en 30 segundos.

## Checklist final

- [ ] La URL pública carga y no tiene errores en la consola del navegador
- [ ] El camino core recorrido entero **dos veces** en producción, hoy
- [ ] Usuario de demo funcionando, credenciales en el README
- [ ] Seed con datos que cuentan una historia
- [ ] Se ve bien en el móvil con el que vas a enseñarlo
- [ ] README con: qué es, URL, credenciales, cómo arrancarlo
- [ ] `docs/ALCANCE.md` actualizado con lo que se hizo y lo que quedó fuera
- [ ] Guion ensayado en voz alta, dentro de 3 minutos
- [ ] Grabación de plan B guardada
- [ ] Todo commiteado y desplegado

## Después de la demo

Dos cosas, hoy mismo, mientras está fresco:

1. Anota en `ALCANCE.md` qué te preguntaron y qué falló. Esa es tu lista de tareas
   siguiente.
2. El proyecto de Supabase del plan gratis se pausa tras unos días sin uso. Si quieres
   enseñarlo más adelante, entra cada pocos días o súbelo de plan.
