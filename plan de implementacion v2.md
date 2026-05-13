Este es el plan de implementación definitivo para Canis Academia, ajustado
estrictamente a tus requerimientos técnicos. Se ha diseñado con un enfoque de
alto rendimiento, eliminando rastreadores (analytics) y priorizando una
arquitectura multiplataforma robusta.

🐕 Plan de Implementación: "Canis Academia"

1. Especificaciones del Ecosistema

  - Framework: Flutter 3.x / Dart 3.x
  - Plataformas de Despliegue: Android, iOS, Web, Windows (Desktop).
  - Backend: Firebase (Console).
  - Base de Datos: Cloud Firestore (NoSQL).
  - Autenticación: Firebase Auth (Correo y Contraseña únicamente).
  - Gestión de Estado: Provider.
  - Privacidad: 0% Analíticas, 0% Rastreo de datos de usuario.

2. Diseño de UI/UX y Sistema de Color

El diseño busca un equilibrio entre lo académico (seriedad/disciplina) y lo
canino (calidez/confianza).

Paleta de Colores (Primer Plano y Marca):

  - Color Primario: #2C3E50 (Azul Medianoche Profundo) - Transmite autoridad y
    profesionalismo.
  - Color Secundario/Acento: #F39C12 (Ámbar Canino) - Utilizado para botones de
    acción (CTA) y progreso.
  - Color de Fondo: #F4F7F6 (Gris Hueso Claro) - Para evitar la fatiga visual.
  - Superficies (Cards/Modales): #FFFFFF (Blanco Puro).
  - Errores/Alertas: #E74C3C (Rojo Suave).

Experiencia de Usuario (UX):

  - Navegación: Menú lateral (Drawer) para Windows/Web y Bottom Navigation Bar
    para móviles.
  - Feedback: Micro-animaciones al completar entrenamientos sin usar servicios
    externos de log.
  - Accesibilidad: Fuentes escalables (Google Fonts: Montserrat para títulos,
    Open Sans para cuerpo).

3. Estructura de Directorios (Arquitectura Profesional)

Aunque en Flutter la lógica reside principalmente en lib, organizaremos el
núcleo de ejecución y lógica de negocio para que sea escalable, siguiendo tu
requerimiento de organización estructural.

canis_academia/
├── assets/              # Imágenes, iconos y fuentes
├── lib/                 # Código fuente principal
│   ├── main.dart        # Punto de entrada
│   ├── core/            # Constantes, temas y utilidades globales
│   ├── providers/       # Notifiers (Lógica de estado con Provider)
│   ├── services/        # Comunicación con Firebase (Auth y Firestore)
│   ├── models/          # Entidades y Data Transfer Objects (DTO)
│   ├── ui/              # Pantallas y widgets (Views)
│   └── bin/             # Scripts de utilidad local y lógica de inicialización
│       ├── firebase_config.dart   # Configuración de Firebase por plataforma
│       ├── seed_data.dart         # Script para cargar datos iniciales de ejercicios
│       └── validators.dart        # Lógica de validación de negocio
├── pubspec.yaml         # Dependencias
└── web/ android/ ios/ windows/    # Carpetas de plataforma nativa

4. Modelo de Datos (Entidades de Firestore)

Entidad: User (Colección: users)

| Atributo    | Tipo      | Descripción                    |
| :---------- | :-------- | :----------------------------- |
| `uid`       | String    | ID único de Firebase Auth      |
| `email`     | String    | Correo electrónico del usuario |
| `name`      | String    | Nombre del entrenador/dueño    |
| `createdAt` | Timestamp | Fecha de registro              |

Entidad: Dog (Colección: dogs)

| Atributo   | Tipo   | Descripción                     |
| :--------- | :----- | :------------------------------ |
| `id`       | String | ID autogenerado                 |
| `ownerId`  | String | Referencia al `uid` del usuario |
| `name`     | String | Nombre del perro                |
| `breed`    | String | Raza                            |
| `age`      | int    | Edad en años                    |
| `photoUrl` | String | Link a la foto (opcional)       |

Entidad: TrainingSession (Colección: sessions)

| Atributo       | Tipo      | Descripción                            |
| :------------- | :-------- | :------------------------------------- |
| `id`           | String    | ID único                               |
| `dogId`        | String    | Referencia al perro                    |
| `date`         | Timestamp | Fecha de la sesión                     |
| `exerciseName` | String    | Ejemplos: "Sentado", "Junto", "Quieto" |
| `score`        | int       | Calificación (1-5)                     |
| `observations` | String    | Notas del progreso                     |

5. Configuración de Dependencias (pubspec.yaml)

name: canis_academia
description: Sistema profesional de gestión de entrenamiento canino.
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # Gestión de Estado
  provider: ^6.1.1

  # Firebase (Sin Analytics)
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6

  # UI y Estilo
  google_fonts: ^6.1.0
  font_awesome_flutter: ^10.6.0
  intl: ^0.19.0

  # Utilidades
  uuid: ^4.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

6. Flujo de Implementación con Provider

1.  Auth Provider: Gestionará el estado de Firebase Auth. Al iniciar, verificará
    si hay un usuario activo. Métodos: signIn(email, pass), signUp(email, pass),
    signOut().
2.  Dog Provider: Gestionará el CRUD de los perros desde Firestore. Usará un
    StreamProvider o ChangeNotifier para reflejar cambios en tiempo real cuando
    se agregue un nuevo perro.
3.  Training Provider: Se encargará de filtrar las sesiones por perro y calcular
    el promedio de éxito del entrenamiento para mostrarlo en los widgets de UI.

7. Pasos Críticos para Multiplataforma

  - Windows: Configurar las capacidades de red en el archivo Runner.rc y
    asegurar el cumplimiento de las políticas de almacenamiento local.
  - Web: Habilitar el renderizado CanvasKit para una mejor fidelidad en los
    gráficos de entrenamiento. Configurar el index.html con las claves de
    Firebase Web.
  - Android/iOS: Configurar los archivos google-services.json y
    GoogleService-Info.plist respectivamente, asegurando que no se incluya el
    SDK de Google Analytics durante la inicialización de Firebase:

// Ejemplo de inicialización en main.dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
// Nota: No se llama a FirebaseAnalytics.instance

🛡️ Nota sobre Privacidad

Para cumplir estrictamente con tu requerimiento de no usar analíticas, se ha
omitido la dependencia firebase_analytics. En la consola de Firebase, se debe
desactivar manualmente la opción de "Google Analytics" en la configuración del
proyecto para garantizar que no se recopile información en segundo plano por
parte de los servicios de Google.

¿Deseas que genere el código base para el AuthProvider o la estructura del
Dashboard principal?
