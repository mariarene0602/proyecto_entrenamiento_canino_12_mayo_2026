Perfecto, entendido. Te mando la **Versión 2 Mejorada** concreta, con las adiciones clave y ejemplos de código solo donde es indispensable. Voy directo a lo que realmente necesitas.

---

## 🐕 Plan de Implementación v2: "Canis Academia" (Mejorado)

### 1. Imagen Conceptual del Modelo de Datos

```
[Usuarios] ────┐
               ├──< [Perros] ────< [SesionesEntrenamiento]
               │                      │
               │                      └──< [Bitacora] (Subcolección)
               │
               └──< [Configuracion]
               │
               └──< [Recordatorios]
```

---

### 2. Estructura de Colecciones Firestore

#### Colección `usuarios`
| Campo | Tipo | Descripción |
|---|---|---|
| `uid` | String (ID) | ID de Firebase Auth |
| `email` | String | Correo |
| `nombre` | String | Nombre de pila |
| `fechaRegistro` | Timestamp | Fecha de creación |
| `ultimoPerroActivo` | String (opcional) | ID del último perro visto |

#### Colección `perros`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | String (Auto ID) | ID único |
| `propietarioId` | String | uid del usuario |
| `nombre` | String | Nombre del perro |
| `raza` | String | Raza |
| `fechaNacimiento` | Timestamp | Edad calculable |
| `sexo` | String | "Macho"/"Hembra" |
| `fotoUrl` | String (opcional) | URL de Storage |
| `notas` | String (opcional) | Médicas/comportamiento |

#### Colección `sesiones_entrenamiento`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | String (Auto ID) | ID único |
| `perroId` | String | Referencia a perro |
| `usuarioId` | String | Quién registró |
| `nombrePerro` | String | Denormalizado para consultas rápidas |
| `fechaHora` | Timestamp | Cuándo fue |
| `duracionMinutos` | Number | Duración |
| `tipoEntrenamiento` | String | "Obediencia", "Agilidad", "Trucos", etc. |
| `comandos` | Array\<String\> | ["Sentado", "Quieto"] |
| `notas` | String | Observaciones |
| `calificacion` | Number (1-5) | Rendimiento |
| `refuerzos` | Array\<String\> | ["Premios", "Clicker"] |

#### Subcolección `bitacora` (bajo `sesiones_entrenamiento/{id}`)
| Campo | Tipo | Descripción |
|---|---|---|
| `timestamp` | Timestamp | Momento exacto |
| `tipo` | String | "Acierto", "Error", "Distracción" |
| `descripcion` | String | "Acertó 5 veces seguidas" |

#### Colección `recordatorios`
| Campo | Tipo | Descripción |
|---|---|---|
| `id` | String (Auto ID) | ID único |
| `usuarioId` | String | uid |
| `perroId` | String | Perro asociado |
| `hora` | String | "18:00" |
| `diasSemana` | Array\<Number\> | [1,3,5] (lun, mie, vie) |
| `activo` | Boolean | true/false |
| `mensaje` | String | "¡Hora de entrenar a Max!" |

---

### 3. Herramientas del Entorno

| Herramienta | Uso | ¿Por qué agregarla? |
|---|---|---|
| **Flutter 3.22+** | SDK | Estable |
| **Firebase CLI** | Emuladores, despliegue | Desarrollo local seguro |
| **VS Code** | IDE principal | Extensiones Flutter maduras |
| **Android Studio / Xcode** | Emuladores y builds nativos | Obligatorio |
| **Postman** | Pruebas de reglas Firestore | Validar reglas sin UI |
| **Git + GitHub** | Control de versiones | PRs, ramas, CI/CD |
| **Figma** | Diseño UI/UX | Handoff de assets |
| **GitHub Actions** | CI/CD | Builds automáticos, tests |
| **Firebase Emulator Suite** | Auth, Firestore, Storage local | Cero costo en desarrollo |
| **Fastlane** | Automatizar despliegue a stores | Screenshots, metadata, builds |

---

### 4. Dependencias Clave (pubspec.yaml)

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Firebase Core
  firebase_core: ^3.1.0
  firebase_auth: ^5.1.0
  cloud_firestore: ^5.0.0
  firebase_storage: ^12.0.0
  firebase_crashlytics: ^4.0.0        # Monitoreo de crashes
  firebase_analytics: ^11.0.0         # Eventos de uso
  firebase_messaging: ^15.0.0         # Push notifications

  # Estado y Arquitectura
  flutter_riverpod: ^2.5.1            # Gestión de estado moderna
  freezed_annotation: ^2.4.1          # Modelos inmutables
  json_annotation: ^4.8.1             # Serialización

  # Navegación
  go_router: ^14.0.0

  # UI/UX
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  fl_chart: ^0.68.0                   # Gráficos
  intl: ^0.19.0
  smooth_page_indicator: ^1.1.0       # Onboarding
  flutter_animate: ^4.5.0             # Microinteracciones

  # Almacenamiento Local
  shared_preferences: ^2.2.2
  hive_flutter: ^1.1.0                # Caché offline rápido

  # Utilidades
  image_picker: ^1.0.7
  uuid: ^4.2.1
  flutter_local_notifications: ^17.0.0 # Recordatorios locales
  share_plus: ^9.0.0                  # Compartir logros
  url_launcher: ^6.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.9
  freezed: ^2.4.7
  json_serializable: ^6.7.1
  mocktail: ^1.0.3                    # Mocking moderno
  very_good_analysis: ^5.1.0          # Linter estricto
  flutter_launcher_icons: ^0.13.1
  flutter_native_splash: ^2.4.0
  patrol: ^3.6.0                      # E2E testing
```

---

### 5. Arquitectura y Gestión del Estado

**Patrón: MVVM + Repository con Riverpod**

```
lib/
  core/
    config/           # AppConfig, Environment (dev/staging/prod)
    theme/            # AppTheme, colores, tipografía
    router/           # GoRouter config
    utils/            # Extensions, helpers, validators
    analytics/        # AnalyticsService
  data/
    models/           # Entidades con freezed
    repositories/     # Implementaciones Firebase
    datasources/      
      remote/         # FirebaseAuth, Firestore
      local/          # Hive, SharedPreferences
  domain/
    repositories/     # Contratos abstractos
  presentation/
    providers/        # Riverpod providers (authentication, dogs, training)
    screens/          # Pantallas organizadas por feature
    widgets/          # Componentes reutilizables
```

**Regla de oro:** La UI nunca llama a Firebase directamente. Siempre a través de Providers → Repositories → DataSources.

---

### 6. Configuración Multi-Entorno (Flavors)

**Archivos de entrada:**
- `lib/main_dev.dart` → App Canis DEV
- `lib/main_staging.dart` → App Canis BETA  
- `lib/main_prod.dart` → App Canis Academia

**`lib/core/config/environment.dart`:**
```dart
enum Environment { dev, staging, prod }

class AppConfig {
  final Environment env;
  final String appName;
  final String firestorePrefix;
  
  static late AppConfig instance;
  
  // Configuraciones específicas por ambiente
  bool get isProduction => env == Environment.prod;
  String get usersCollection => '${firestorePrefix}usuarios';
  String get dogsCollection => '${firestorePrefix}perros';
}
```

---

### 7. Fases de Desarrollo Mejoradas

| Fase | Duración | Entregable Clave | Novedad en v2 |
|---|---|---|---|
| **F0: Setup** | 1-2 días | Proyecto Flutter con Firebase, emuladores, flavors, CI/CD básico | Flavors multi-entorno + GitHub Actions |
| **F1: UI Foundation** | 2-3 días | Sistema de diseño, navegación, onboarding animado | Tutorial interactivo + shimmer loading |
| **F2: Autenticación** | 2 días | Registro, login, recuperación, biometría | Soporte huella/Face ID para login rápido |
| **F3: Perfiles Caninos** | 2-3 días | CRUD perros con fotos, validación | Caché offline con Hive |
| **F4: Sesiones Entrenamiento** | 3-4 días | Registro con bitácora, historial, filtros | Modo offline funcional + sincronización |
| **F5: Dashboard Analítico** | 3 días | Gráficos de progreso, rachas, métricas | Confeti al completar objetivos |
| **F6: Recordatorios** | 2 días | Notificaciones locales programables | Flutter Local Notifications |
| **F7: Social & Pulido** | 2-3 días | Compartir logros, animaciones, accesibilidad | Share plus + flutter_animate |
| **F8: Testing & CI/CD** | 2-3 días | Unit, widget, integration tests. Fastlane deploy | Patrol E2E + Fastlane screenshots |
| **F9: Launch** | 1 día | Store assets, política privacidad, builds firmados | Checklist pre-lanzamiento automatizado |

---

### 8. Reglas de Seguridad Firestore (Esenciales)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Usuarios solo acceden a su propio documento
    match /usuarios/{userId} {
      allow read, update: if request.auth != null && request.auth.uid == userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.uid;
    }
    
    // Perros: solo el dueño puede CRUD
    match /perros/{dogId} {
      allow read, update, delete: if request.auth != null 
        && resource.data.propietarioId == request.auth.uid;
      allow create: if request.auth != null 
        && request.resource.data.propietarioId == request.auth.uid;
    }
    
    // Sesiones: validar propiedad y rangos
    match /sesiones_entrenamiento/{sessionId} {
      allow read, delete: if request.auth != null 
        && resource.data.usuarioId == request.auth.uid;
      allow create: if request.auth != null 
        && request.resource.data.usuarioId == request.auth.uid
        && request.resource.data.calificacion >= 1 
        && request.resource.data.calificacion <= 5;
      
      // Subcolección bitácora hereda seguridad de la sesión padre
      match /bitacora/{logId} {
        allow read, write: if request.auth != null 
          && get(/databases/$(database)/documents/sesiones_entrenamiento/$(sessionId)).data.usuarioId == request.auth.uid;
      }
    }
    
    // Recordatorios
    match /recordatorios/{reminderId} {
      allow read, update, delete: if request.auth != null 
        && resource.data.usuarioId == request.auth.uid;
      allow create: if request.auth != null 
        && request.resource.data.usuarioId == request.auth.uid;
    }
  }
}
```

---

### 9. Estrategia de Pruebas

| Tipo | Herramienta | Cobertura | Ejemplo |
|---|---|---|---|
| **Unitarias** | `flutter_test` + `mocktail` | 70%+ | Probar `DogNotifier` con repo mockeado |
| **Widget** | `flutter_test` | Componentes clave | `DogCard` renderiza nombre y foto |
| **Integración** | `patrol` | Flujos críticos | Login → Crear perro → Registrar sesión |
| **Reglas Firestore** | `@firebase/rules-unit-testing` | 100% reglas | Usuario A no puede leer perros de B |

---

### 10. CI/CD con GitHub Actions (Esencial)

```yaml
name: Canis CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.0'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Static analysis
        run: flutter analyze
      
      - name: Format check
        run: dart format --set-exit-if-changed .
      
      - name: Unit & Widget tests
        run: flutter test --coverage
      
      - name: Build Android (solo PRs a main)
        if: github.ref == 'refs/heads/main'
        run: flutter build apk --release --flavor prod
```

---

### 11. Checklist Pre-Lanzamiento

- [ ] `flutter analyze` sin errores ni warnings
- [ ] Tests unitarios > 70% cobertura
- [ ] Firebase Emulator Suite: reglas de seguridad probadas
- [ ] Build Android (AAB) e iOS (IPA) sin errores
- [ ] Crashlytics configurado y verificando crashes en consola
- [ ] Política de privacidad publicada (URL en store listing)
- [ ] Screenshots actualizados para App Store y Google Play
- [ ] App icon y splash screen nativos (todas las densidades)
- [ ] Probado en dispositivo físico iOS y Android
- [ ] Permisos de cámara/fotos justificados en manifiestos
- [ ] Modo offline probado: avión + abrir app + reconectar
- [ ] Accessibility: VoiceOver/TalkBack funcional en pantallas clave

---

### 12. Instrucciones de Setup Rápido para el Equipo

```bash
# 1. Clonar repositorio
git clone [repo-url] && cd canis_academia

# 2. Instalar Firebase CLI y emuladores
npm install -g firebase-tools
firebase login
firebase init emulators

# 3. Instalar dependencias Flutter
flutter pub get

# 4. Generar modelos con freezed
dart run build_runner build --delete-conflicting-outputs

# 5. Iniciar emuladores Firebase (Auth, Firestore)
firebase emulators:start --import=./seed_data

# 6. Ejecutar en modo desarrollo
flutter run --flavor dev -t lib/main_dev.dart

# 7. Ejecutar tests
flutter test

# 8. Build producción
flutter build apk --release --flavor prod -t lib/main_prod.dart
```

---

## 📌 Resumen: ¿Qué mejoró en v2?

| Aspecto | v1 Original | v2 Mejorada |
|---|---|---|
| **Modelo de datos** | Básico (users, dogs, sessions) | Agregado: bitácora, recordatorios, datos denormalizados |
| **Dependencias** | Lista genérica | Categorizadas con justificación, agregadas Crashlytics, Analytics, notificaciones locales |
| **Arquitectura** | Provider genérico | Riverpod + MVVM concreto con estructura de carpetas |
| **Entornos** | No especificado | Flavors dev/staging/prod con AppConfig |
| **Seguridad** | Reglas básicas | Reglas con validación de rangos, herencia en subcolecciones |
| **CI/CD** | Mencionado | GitHub Actions concreto + Fastlane para despliegue |
| **Testing** | Solo mencionado | Estrategia por capas + Patrol E2E + test de reglas Firestore |
| **Offline** | Mencionado | Hive + persistencia Firestore con estrategia clara |
| **Checklist** | No existía | 12 puntos verificables antes de publicar |

---

¿Quieres que profundice en alguna sección específica o comenzamos con la implementación de la **Fase 0**?
