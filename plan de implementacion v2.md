¡Excelente proyecto, Canis Academia! Tienes una base muy sólida en el plan v1. Mi objetivo es ayudarte a refinarlo con la estructura y el nivel de detalle que muestras en el ejemplo de la tienda, manteniendo la esencia de tu proyecto original pero llevándolo a una "Versión 2" más concreta, técnica y procesable.

He reorganizado, desglosado y añadido detalles técnicos específicos para un proyecto de entrenamiento canino, inspirándome en el formato de tu ejemplo. Aquí tienes la **Versión 2**:

---

## 🐕 Plan de Implementación v2: "Canis Academia"

### 1. Imagen Conceptual del Modelo de Datos (Entidades y Relaciones)

Esta es la representación visual de las colecciones principales en Firestore y cómo se conectan, reflejando el flujo de entrenamiento.

```
[Usuarios] ────┐
               ├──< [Perros] ────< [SesionesEntrenamiento]
               │                      │
               │                      └──< [Bitácora] (Subcolección opcional para notas diarias)
               │
               └──< [Configuracion] (Preferencias de UI/Notificaciones por usuario)
```

**Relaciones Clave:**
*   Un **Usuario** tiene muchos **Perros** (Relación 1:N).
*   Un **Perro** tiene muchas **Sesiones de Entrenamiento** (Relación 1:N).
*   Una **Sesión de Entrenamiento** puede tener una **Bitácora** (Relación 1:1 o 1:N, implementada como subcolección para no sobrecargar el documento de la sesión).
*   Un **Usuario** tiene un único documento de **Configuración** (Relación 1:1).

---

### 2. Colecciones en Firestore (Estructura de Datos Detallada)

Aquí se define el esquema NoSQL para la base de datos.

#### Colección `usuarios`
| Campo | Tipo | Descripción |
|---|---|---|
| `uid` | `String` (ID) | ID del usuario desde Firebase Auth. |
| `email` | `String` | Correo electrónico del usuario. |
| `nombre` | `String` | Nombre de pila para personalización. |
| `fechaRegistro` | `Timestamp` | Marca de tiempo de creación de la cuenta. |
| `esEntrenador` | `Boolean` | (Opcional Futuro) Flag para funcionalidades de entrenador profesional. |

#### Colección `perros`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` (Auto ID) | ID único del perfil del perro. |
| `propietarioId` | `String` | `uid` del usuario en la colección `usuarios`. |
| `nombre` | `String` | Nombre del perro. |
| `raza` | `String` | Raza (ej: "Border Collie"). |
| `fechaNacimiento` | `Timestamp` | Para calcular la edad. |
| `sexo` | `String` | "Macho", "Hembra". |
| `fotoUrl` | `String` (Opcional) | URL de Firebase Storage para la foto de perfil. |
| `notas` | `String` (Opcional) | Notas médicas o de comportamiento relevantes. |

#### Colección `sesiones_entrenamiento`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` (Auto ID) | ID único de la sesión. |
| `perroId` | `String` | Referencia al perro en la colección `perros`. |
| `usuarioId` | `String` | Referencia al usuario que registró la sesión (para reglas de seguridad). |
| `fechaHora` | `Timestamp` | Cuándo se realizó o registró la sesión. |
| `duracionMinutos` | `Number` | Duración en minutos. |
| `tipoEntrenamiento` | `String` | "Obediencia Básica", "Agilidad", "Trucos", "Socialización", etc. |
| `comandosPracticados` | `Array<String>` | Lista de comandos: `["Sentado", "Quieto", "Junto"]`. |
| `notasSesion` | `String` | Notas del usuario sobre cómo fue la sesión. |
| `calificacion` | `Number` (1-5) | Valoración subjetiva del dueño/entrenador (1=Muy Mal, 5=Excelente). |
| `usoRefuerzo` | `Array<String>` | `["Premios", "Juguete", "Clicker", "Caricias"]`. |

#### Subcolección `bitacora` (bajo `sesiones_entrenamiento/{sesionId}`)
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` (Auto ID) | ID único de la entrada de bitácora. |
| `timestamp` | `Timestamp` | Marca de tiempo del evento o nota (permite múltiples por sesión). |
| `tipoEvento` | `String` | "Acierto", "Error", "Distracción", "Nota". |
| `descripcion` | `String` | "Acertó 5 'Sentado' seguidos", "Se distrajo con una paloma". |
| `comandoRelacionado` | `String` (Opcional) | "Sentado". |

#### Colección `configuracion_usuario`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | `String` (ID = `uid`) | Coincide con el `uid` del usuario para fácil acceso. |
| `temaOscuro` | `Boolean` | Preferencia de tema. |
| `ultimoPerroSeleccionado` | `String` (Opcional) | ID del último perfil de perro visto. |
| `notificacionesActivadas` | `Boolean` | Para recordatorios de entrenamiento (futuro). |

> **Principio de Denormalización:** En la vista de historial, para evitar lecturas extra, podríamos denormalizar el `nombreDelPerro` en el documento `sesiones_entrenamiento`. Esto se evalúa en la Fase 5.

---

### 3. Diseño UI/UX para Canis Academia (en Flutter)

**Principios UX Esenciales:**
*   **Navegación Inferior (Móvil) / Rail (Tablet/Web):** Inicio (Dashboard), Mis Perros, Historial, Configuración.
*   **Dashboard Persuasivo:** Resumen semanal con "Racha de entrenamiento", "Comandos más practicados", y acceso rápido a "Iniciar Nueva Sesión".
*   **Flujo de Sesión sin Fricción:** Registro en 2 pasos:
    1.  Seleccionar tipo, duración y comandos (con chips predefinidos).
    2.  Notas, calificación y bitácora rápida.
*   **Visualización de Progreso:** Gráficos simples (barras o líneas) en el historial para ver la frecuencia de entrenamiento y la evolución de la `calificacion`.
*   **Paleta de Colores:** "Paleta Canina" (Tonos tierra, verdes bosque, naranjas cálidos y cremas). Alto contraste para uso en exteriores. Accesibilidad WCAG 2.1 AA.

**Componentes UI Clave y Librerías:**
*   `google_fonts`: Para tipografía amigable (ej: Nunito, Raleway).
*   `flutter_svg`: Iconografía de patitas, huesos, etc.
*   `cached_network_image`: Fotos de perfil de perros.
*   `shimmer`: Efecto de carga atractivo para tarjetas de perros y sesiones.
*   `fl_chart` o `syncfusion_flutter_charts`: Para gráficos de progreso en el dashboard.

**Estructura de Pantallas:**
```
lib/
  screens/
    splash_screen.dart
    onboarding/
    auth/
      login_screen.dart
      register_screen.dart
      forgot_password_screen.dart
    dashboard/
      dashboard_screen.dart
    dogs/
      dog_list_screen.dart
      dog_profile_screen.dart
      add_edit_dog_screen.dart
    training/
      new_session_screen.dart
      session_detail_screen.dart
    history/
      history_list_screen.dart
      history_detail_screen.dart
    settings/
      settings_screen.dart
  widgets/
    dog_card.dart
    session_summary_card.dart
    rating_bar.dart
    command_chips.dart
    primary_button.dart
    app_scaffold.dart
```

---

### 4. Arquitectura y Gestión del Estado

**Patrón:** **MVVM (Model-View-ViewModel) con Repositorios Abstractos**
Una adaptación de Clean Architecture que encaja perfectamente con `Provider` y es escalable.

```
lib/
  core/               # Utilidades, constantes, tema, rutas
    theme/
    router/
    utils/
  data/
    models/           # Perro, SesionEntrenamiento, Usuario (con freezed)
    repositories/     # Implementaciones concretas (Firebase)
      auth_repository_impl.dart
      dog_repository_impl.dart
      training_repository_impl.dart
    datasources/      # Fuentes de datos: remoto (Firebase) y local (Hive/SharedPrefs)
      remote/
        firebase_auth_datasource.dart
        firestore_datasource.dart
      local/
        local_storage_datasource.dart
  domain/
    repositories/     # Contratos abstractos de los repositorios
      auth_repository.dart
      dog_repository.dart
      training_repository.dart
  presentation/
    providers/        # Notifiers que actúan como ViewModels
      auth/
        auth_notifier.dart
        auth_state.dart
      dogs/
        dog_list_notifier.dart
        dog_form_notifier.dart
      training/
        session_notifier.dart
      settings/
        settings_notifier.dart
    screens/          # Cada pantalla consume uno o más Providers
```

**Estado Elegido:** **Provider + ChangeNotifier/Notifier (con `freezed` para estados inmutables)**

**Ejemplo de un Provider para la lista de perros (ViewModel):**

```dart
// dog_list_state.dart
@freezed
class DogListState with _$DogListState {
  const factory DogListState.initial() = _Initial;
  const factory DogListState.loading() = _Loading;
  const factory DogListState.data(List<Perro> dogs) = _Data;
  const factory DogListState.error(String message) = _Error;
}

// dog_list_notifier.dart
class DogListNotifier extends StateNotifier<DogListState> {
  final DogRepository _repository;
  DogListNotifier(this._repository) : super(const DogListState.initial());

  Future<void> fetchDogsForUser(String userId) async {
    state = const DogListState.loading();
    try {
      final dogs = await _repository.getDogsByUserId(userId);
      state = DogListState.data(dogs);
    } catch (e) {
      state = DogListState.error('Error al cargar los perros: $e');
    }
  }

  Future<void> deleteDog(String dogId) async {
    try {
      await _repository.deleteDog(dogId);
      fetchDogsForUser(/* userId */); // Recargar la lista
    } catch (e) {
      // Manejo de error
    }
  }
}
```

---

### 5. Configuraciones Necesarias (Firebase + Flutter)

1.  **Firebase Console:**
    *   Crear proyecto `CanisAcademia`.
    *   Registrar apps Android (ej: `com.planckstudio.canis_academia`) e iOS.
    *   Descargar `google-services.json` y `GoogleService-Info.plist` y colocarlos en sus carpetas.
    *   **Authentication:** Habilitar `Email/Password`. (Opcional Futuro: Google Sign-In).
    *   **Cloud Firestore:** Crear base de datos en modo producción (con reglas estrictas).
    *   **Storage:** (Opcional, Fase 6) Para fotos de perros y sesiones.

2.  **Reglas de Seguridad de Firestore (v1):**
    ```javascript
    rules_version = '2';
    service cloud.firestore {
      match /databases/{database}/documents {
        match /usuarios/{userId} {
          allow read, update, delete: if request.auth != null && request.auth.uid == userId;
          allow create: if request.auth != null && request.auth.uid == request.resource.data.uid;
        }
        match /perros/{dogId} {
          allow read, update, delete: if request.auth != null && resource.data.propietarioId == request.auth.uid;
          allow create: if request.auth != null && request.resource.data.propietarioId == request.auth.uid;
        }
        match /sesiones_entrenamiento/{sessionId} {
          allow read, update, delete: if request.auth != null && resource.data.usuarioId == request.auth.uid;
          allow create: if request.auth != null && request.resource.data.usuarioId == request.auth.uid;
          // Reglas para subcolección bitácora
          match /bitacora/{logId} {
            allow read, write: if request.auth != null && get(/databases/$(database)/documents/sesiones_entrenamiento/$(sessionId)).data.usuarioId == request.auth.uid;
          }
        }
        match /configuracion_usuario/{userId} {
          allow read, update: if request.auth != null && request.auth.uid == userId;
          allow create: if request.auth != null && request.auth.uid == request.resource.data.id;
        }
      }
    }
    ```

3.  **Configuración en Flutter (`main.dart`):**
    ```dart
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Activar persistencia offline
      FirebaseFirestore.instance.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );

      runApp(const CanisAcademiaApp());
    }
    ```

---

### 6. Estrategia de Dependencias (`pubspec.yaml`)

Aquí se actualizan y categorizan las dependencias para un desarrollo robusto.

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Core Firebase
  firebase_core: ^3.1.0
  firebase_auth: ^5.1.0
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0   # Para fotos de perro/progreso

  # Estado y Arquitectura
  provider: ^6.1.1
  flutter_riverpod: ^2.5.1    # (Alternativa moderna a Provider. Si prefieres Provider, mantenlo. La lista refleja opciones de mercado)
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # Navegación
  go_router: ^14.0.0

  # UI y UX
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  fl_chart: ^0.68.0           # Gráficos de progreso
  intl: ^0.19.0               # Formato de fechas y números

  # Utilidades y Datos Locales
  shared_preferences: ^2.2.2
  uuid: ^4.2.1
  path: ^1.8.3
  flutter_dotenv: ^5.1.0      # Variables de entorno

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  mockito: ^5.4.3
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.4.0
  very_good_analysis: ^5.1.0   # Linter estricto
```

---

### 7. Fases de Desarrollo (Plan de Trabajo Táctico)

| Fase | Entregable Clave | Criterio de Finalización Detallado |
| :--- | :--- | :--- |
| **F0: Fundación** | Proyecto Flutter configurado, Firebase integrado, emuladores corriendo, arquitectura de carpetas definida. | `flutter run` muestra la app en 2 plataformas. Login/Register con Firebase Auth funcional en emulador. `analysis_options.yaml` con `very_good_analysis` sin errores. |
| **F1: UI/UX Esencial** | Sistema de diseño (tema, colores, tipografía), navegación completa (GoRouter), componentes reutilizables (`DogCard`, `AppScaffold`, etc.). | El "esqueleto" de la app es navegable con datos mock. El diseño es responsive en móvil y tablet. Los componentes se ven y se sienten como la guía de Figma. |
| **F2: Auth y Perfiles** | Flujo de autenticación completo (registro, login, recuperación, cierre de sesión). CRUD de perfiles de `perros` (nombre, raza, edad) vinculado a Firestore y Provider. | Un usuario puede registrarse, iniciar sesión, crear 3 perros, editar uno y eliminarlo. Los cambios persisten al cerrar y abrir la app. Las reglas de seguridad de Firestore validan que un usuario no puede ver/editar los perros de otro. |
| **F3: Registro de Sesión** | Pantalla `NuevaSesion` funcional, guardando datos en `sesiones_entrenamiento`. `Dashboard` muestra resumen real (últimas 2 sesiones). `Historial` lista todas las sesiones del perro activo. | El flujo de extremo a extremo funciona: Dashboard -> Seleccionar Perro -> Nueva Sesión -> Llenar formulario -> Guardar -> Ver en Dashboard/Historial. Los datos son consistentes. |
| **F4: Seguridad y Offline** | Refinamiento de reglas de seguridad. Implementación de persistencia offline y manejo de estado de red. Pruebas de estrés y validación de UX offline. | Si se corta internet, la app muestra los datos cacheados y una UI de "Sin conexión". Al volver la red, los datos se sincronizan sin errores. Las reglas de Firestore pasan un conjunto de pruebas de intentos no autorizados. |
| **F5: Analíticas y Progreso** | Implementación de gráficos (`fl_chart`) en el Dashboard e Historial. Agregación de métricas (racha, comandos top). Cálculo de estadísticas en el Notifier. | El Dashboard muestra gráficos de frecuencia de entrenamiento (barras) y evolución de calificación (línea) para el perro seleccionado. Los datos se calculan eficientemente usando queries de Firestore. |
| **F6: Pulido y Multimedia** | Soporte para fotos de perfil de perros (Firebase Storage + Cámara/Galería). Animaciones, splash screen, icono de la app. Internacionalización (es/en). | La app se siente fluida y pulida. Los tiempos de carga son mínimos gracias a `cached_network_image`. La app soporta inglés y español según el idioma del dispositivo. |
| **F7: Pruebas y CI/CD** | Tests unitarios (Notifiers, Repositorios), de widget (componentes clave) y de integración. Pipeline CI/CD con GitHub Actions. | Cobertura de tests > 70%. El pipeline de CI ejecuta análisis estático y tests en cada PR. La build de release se genera y se despliega a TestFlight y Firebase App Distribution automáticamente. |
| **F8: Lanzamiento** | Creación de stores assets, política de privacidad, builds de producción firmados, envío a revisión en App Store y Google Play. | La app es "Ready for Sale" en ambas consolas. Se versiona con `1.0.0` y el changelog está completo. |

---

### 8. Consideraciones Finales y Buenas Prácticas

*   **Rendimiento Firestore:**
    *   Usa **índices compuestos** para consultas frecuentes como "sesiones de un perro ordenadas por fecha".
    *   Implementa **paginación** (`limit` + `startAfterDocument`) para el historial de sesiones si es muy extenso.
    *   La **denormalización** es clave: si el dashboard requiere mostrar el nombre del perro junto a la sesión más reciente, copia el `nombreDelPerro` al documento `sesiones_entrenamiento`.
*   **Manejo de Errores:** Centraliza el manejo de excepciones en los repositorios. Los Notifiers mapean errores a estados de UI (`ErrorState` con un mensaje amigable). Usa `try/catch` alrededor de las operaciones de red.
*   **Seguridad:** Las reglas de Firestore son la única línea de defensa del backend. Sé extremadamente estricto. Valida tipos de datos, rangos (ej: `calificacion` entre 1 y 5) y propiedad (`request.auth.uid == resource.data.usuarioId`).
*   **Provider vs. Riverpod:** Aunque en el plan original mencionabas Provider, el ecosistema avanza hacia Riverpod por su seguridad de tipos, testabilidad y capacidad de autodisponerse. Riverpod resuelve muchos problemas de Provider, pero el concepto MVVM es el mismo. Yo te recomendaría considerar `flutter_riverpod` para un proyecto nuevo. El resto de la arquitectura se mantiene igual.

**Próximo paso:** Validemos esta estructura. ¿Quieres que empecemos a detallar la **Fase 0: Fundación**, definiendo la estructura exacta de carpetas y los archivos de configuración inicial?
