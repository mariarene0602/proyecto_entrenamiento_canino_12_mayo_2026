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

Aquí tienes las tablas con todos los atributos
<img width="658" height="359" alt="image" src="https://github.com/user-attachments/assets/b9009845-07af-4ff5-8763-bbe703d41b36" />
<img width="651" height="382" alt="image" src="https://github.com/user-attachments/assets/5a50ce52-46ee-489a-abeb-5af00eab015e" />
<img width="655" height="392" alt="image" src="https://github.com/user-attachments/assets/ff67b443-3cb0-4eb7-8ea7-7c1bbb9d6187" />
<img width="650" height="302" alt="image" src="https://github.com/user-attachments/assets/30154dd7-5831-4107-8361-abb45ff6c10a" />
<img width="652" height="306" alt="image" src="https://github.com/user-attachments/assets/c494e474-5899-486b-b746-050ab407de62" />
<img width="647" height="346" alt="image" src="https://github.com/user-attachments/assets/ba30b7f3-1d23-41c7-becb-e6e4b070f9be" />
<img width="652" height="345" alt="image" src="https://github.com/user-attachments/assets/a28377d9-3496-40d3-ba74-8f47bac7a594" />
<img width="651" height="416" alt="image" src="https://github.com/user-attachments/assets/29a44292-e979-468c-84bf-0f0cbf8f7638" />
<img width="655" height="278" alt="image" src="https://github.com/user-attachments/assets/d3c65bd3-dccf-46b2-a435-deba70b84f03" />
<img width="649" height="347" alt="image" src="https://github.com/user-attachments/assets/284f67c9-9e49-4a7f-b116-72a90b15d4b4" />
<img width="650" height="276" alt="image" src="https://github.com/user-attachments/assets/dfd70af6-3e55-4d7d-b19e-501d9e624630" />
