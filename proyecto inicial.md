Para un negocio de entrenamiento canino necesitas **11 entidades** agrupadas en cuatro dominios:

<img width="732" height="726" alt="image" src="https://github.com/user-attachments/assets/964e7fec-a688-4459-9934-4633bf33fa3d" />


**Clientes y mascotas**
`CLIENTE` y `MASCOTA` son el núcleo. Un cliente puede tener varias mascotas, y cada mascota lleva su propia ficha con raza, edad, nivel de entrenamiento y observaciones médicas/conductuales relevantes.

**Catálogo de servicios**
`SERVICIO` define lo que ofreces: clases grupales, sesiones individuales, adiestramiento en domicilio, etc. `PAQUETE` agrupa varios servicios en bundles comerciales (p. ej. "10 sesiones de obediencia básica").

**Operación de sesiones**
`SESION` es el evento concreto: quién entrena a qué mascota, con qué servicio, en qué fecha. `ENTRENADOR` y `INSTALACION` se asocian a cada sesión mediante `RESERVACION`, controlando disponibilidad de espacios (agility, sala cubierta, etc.).

**Comercial y seguimiento**
`CONTRATACION` registra la compra de un paquete por parte de un cliente, con vigencia y sesiones consumidas. `PAGO` lleva el historial de cobros y métodos. `PROGRESO` permite documentar el avance de cada mascota por habilidad en cada sesión, algo muy valorado por los dueños.

Algunas extensiones que podrías añadir más adelante: una entidad `VETERINARIO` o `HISTORIAL_SALUD` si ofreces seguimiento médico, o `NOTIFICACION` para recordatorios de sesiones y vencimiento de paquetes.
