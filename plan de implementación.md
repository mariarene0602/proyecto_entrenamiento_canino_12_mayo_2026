# 🐕 Plan de Implementación: "Entrenamiento Canino"

## 1. Visión General del Proyecto
Aplicación multiplataforma (iOS, Android y Web) diseñada para registrar, planificar y dar seguimiento a rutinas de entrenamiento canino. El producto permite a usuarios crear perfiles, gestionar fichas de perros, registrar sesiones, medir progreso y sincronizar información en tiempo real mediante Firebase. La experiencia se centra en simplicidad, accesibilidad y visualización clara de métricas.

---

## 2. Arquitectura y Stack Tecnológico
| Capa | Tecnología / Patrón |
|------|---------------------|
| **Frontend** | Flutter 3.x (Dart 3.x) |
| **Estado** | `provider` + `ChangeNotifier`/`Notifier` (separación estricta UI ↔ lógica) |
| **Navegación** | Router declarativo (`go_router` o `auto_route`) |
| **Backend** | Firebase Authentication (email/password) + Cloud Firestore |
| **Arquitectura** | MVVM / Feature-First con repositorios abstractos para desacoplar UI y datos |
| **Offline** | Caché local sincronizable + listeners de Firestore con gestión de estado de red |

---

## 3. Estrategia de UI/UX
- **Sistema de Diseño:** Material 3 adaptado con paleta canina (tonos cálidos, alto contraste para exteriores), tipografía escalable y componentes reutilizables (cards, progress rings, timeline).
- **Flujos Principales:** Onboarding → Autenticación → Dashboard (resumen semanal) → Ficha del perro → Registro de sesión → Historial/Estadísticas → Configuración.
- **Accesibilidad:** Soporte de VoiceOver/TalkBack, contraste WCAG 2.1 AA, tamaño de fuente dinámico, navegación por teclado en Web.
- **Prototipado:** Figma o Adobe XD para wireframes de baja/media fidelidad, validación de usabilidad antes de desarrollo.
- **Responsive:** Layouts adaptativos (`Breakpoints`, `LayoutBuilder`), navegación tipo `NavigationRail` en tablet/desktop y `BottomNavigationBar` en móvil.

---

## 4. Entorno de Desarrollo y Herramientas
| Herramienta | Propósito |
|-------------|-----------|
| **VS Code** | IDE principal con extensiones: Flutter, Dart, Firebase, Error Lens, GitLens |
| **Flutter SDK + Dart SDK** | Compilación, hot reload, gestión de plataformas |
| **Firebase CLI + Emulators** | Desarrollo local seguro, pruebas de Auth y Firestore sin afectar producción |
| **Git + GitHub/GitLab** | Control de versiones, ramas feature/release, PRs con revisión |
| **Figma** | Diseño UI/UX, handoff de assets y especificaciones |
| **Android Studio / Xcode** | Compilación nativa, gestión de certificados y simuladores |
| **Postman / Thunder Client** | Validación de endpoints y payloads de Firestore REST (si aplica) |
| *Nota sobre Antigravity:* No es un IDE reconocido para desarrollo Flutter. Se recomienda mantener VS Code como entorno principal por su ecosistema maduro, soporte nativo y extensión oficial de Flutter/Dart.

---

## 5. Integración con Firebase
- **Authentication:** Registro e inicio de sesión por email/password, validación de formato, manejo de errores de red, tokens de sesión, cierre seguro, recuperación de contraseña vía Firebase.
- **Cloud Firestore:** 
  - Colecciones: `users`, `dogs`, `training_sessions`, `milestones`, `settings`
  - Modelo relacional débil con referencias por `documentId`
  - Subcolecciones para historial de sesiones y logs de progreso
- **Reglas de Seguridad:** Acceso estricto por `auth.uid`, validación de tipos y rangos, restricciones de escritura por rol/propiedad, bloqueo de operaciones no autorizadas.
- **Emuladores:** Ejecución local de Auth y Firestore para desarrollo, seeding de datos de prueba, validación de reglas antes de despliegue.
- **Configuración Multiplataforma:** Generación de `firebase_options.dart` por plataforma, variables de entorno para diferentes entornos (dev/staging/prod).

---

## 6. Gestión de Estado con Provider
- **Separación de Responsabilidades:** 
  - `AuthNotifier`: estado de autenticación, sesión, token, errores
  - `DogRepository` + `DogNotifier`: CRUD de perfiles caninos, sincronización
  - `TrainingNotifier`: registro, filtrado, agregación de métricas
  - `UIStateNotifier`: loading, errores, navegación, tema, preferencias locales
- **Inyección de Dependencias:** `MultiProvider` en la raíz, exposición controlada a subtrees, reconstrucción selectiva con `Consumer`/`Selector`
- **Persistencia Ligera:** `shared_preferences` o `hive` para preferencias de UI, último perro seleccionado, configuración offline
- **Manejo de Errores:** Centralización en notifiers, fallbacks de UI, reintentos automáticos en fallos transitorios de red

---

## 7. Dependencias (`pubspec.yaml`)
*(Categorizadas por función. Versiones estables recomendadas según ecosistema 2025-2026)*

**Core & Firebase**
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_storage` (opcional, para fotos de progreso)

**Estado & Arquitectura**
- `provider`
- `go_router` (o `auto_route`)
- `freezed` + `json_annotation` (modelos inmutables y serialización)

**UI & UX**
- `flutter_svg`
- `cached_network_image`
- `intl`
- `flutter_animate` (microinteracciones sutiles)
- `responsive_framework`

**Utilidades & Datos**
- `shared_preferences`
- `uuid`
- `path` / `path_provider`
- `http` (si se integra API externa futura)
- `flutter_dotenv`

**Desarrollo & Pruebas**
- `flutter_test`
- `mockito`
- `build_runner`
- `lints` / `very_good_analysis`

*(Nota: Las versiones exactas se fijarán mediante `flutter pub add` y se mantendrán actualizadas según releases estables del canal `stable`)*

---

## 8. Fases de Desarrollo (Milestones)
| Fase | Entregable Clave | Criterio de Finalización |
|------|------------------|--------------------------|
| **M1: Fundación** | Proyecto configurado, estructura de carpetas, dependencias base, emuladores locales | `flutter run` estable, emuladores activos, lint sin warnings críticos |
| **M2: UI/UX Base** | Navegación, temas, componentes reutilizables, pantallas estáticas validadas | Diseño responsive, accesibilidad básica, handoff completo |
| **M3: Autenticación** | Registro, login, recuperación, validación de sesión, manejo de errores | Flujo completo probado en emuladores, tokens persistentes, UI de estados |
| **M4: Firestore & Modelos** | Esquema de datos, repositorios, CRUD inicial, reglas de seguridad v1 | Operaciones síncronas/asíncronas validadas, offline básico, seguridad aplicada |
| **M5: Lógica & Estado** | Provider implementado, notifiers conectados, agregación de métricas | UI reactiva, reconstrucción mínima, gestión de errores centralizada |
| **M6: Pulido & Optimización** | Animaciones, caché, manejo de red, accesibilidad avanzada, internacionalización | Lighthouse/Flutter performance ok, sin leaks, UX fluida |
| **M7: Pruebas & Lanzamiento** | Tests unitarios/widget, integración CI/CD, builds firmados, store assets | Cobertura mínima 70%, pipelines verdes, aprobación en consolas |

---

## 9. Estrategia de Pruebas y Despliegue
- **Pruebas:** Unitarias para repositorios/notifiers, widget para componentes clave, integración para flujos auth+Firestore
- **Emulación:** Firebase Emulator Suite + `mocktail`/`mockito` para simular respuestas
- **CI/CD:** GitHub Actions o Codemagic para builds automáticos, lint, tests y distribución interna (Firebase App Distribution, TestFlight)
- **Publicación:** Versionado semántico, changelog estructurado, cumplimiento de guías de Apple/Google, políticas de privacidad y permisos claros

---

## 10. Seguridad y Buenas Prácticas
- **Firestore:** Reglas estrictas por `auth.uid`, validación de esquemas con reglas, índices compuestos optimizados
- **Auth:** Contraseñas con políticas básicas, rate limiting nativo de Firebase, manejo seguro de sesiones, logout completo
- **Datos:** No almacenar información sensible en cliente, sanitización de inputs, fallbacks en modo offline
- **Privacidad:** Consentimiento explícito, política de datos visible, cumplimiento GDPR/CCPA según región
- **Mantenimiento:** Dependencias actualizadas trimestralmente, monitoreo de crash reports (Firebase Crashlytics), logs estructurados para diagnóstico

---

📌 **Próximo paso recomendado:** Validar este plan con el equipo, definir prioridades de negocio (ej. ¿se prioriza registro de sesiones o dashboard analítico primero?) y preparar los wireframes en Figma antes de iniciar la fase M1. Cuando estés listo para la estructura de carpetas, arquitectura de repositorios o configuración inicial de Firebase, indícalo y se genera el siguiente documento de diseño técnico.
