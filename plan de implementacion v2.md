🐕 Plan de Implementación Definitivo: "Canis Academia"
Versión Extendida y Detallada
1. Especificaciones del Ecosistema Técnico
Framework y Tecnologías Base
Componente	Especificación	Justificación
Framework	Flutter 3.x / Dart 3.x	Rendimiento nativo en múltiples plataformas con un solo código base
Plataformas objetivo	Android, iOS, Web, Windows (Desktop)	Cobertura completa del ecosistema de dispositivos que un entrenador canino puede utilizar
Backend	Firebase Console	Infraestructura serverless que elimina la necesidad de mantener servidores propios
Base de Datos	Cloud Firestore (NoSQL)	Sincronización en tiempo real y escalabilidad automática
Autenticación	Firebase Auth	Solo correo y contraseña, sin integración con proveedores externos
Gestión de Estado	Provider	Solución ligera, nativa de Flutter y con curva de aprendizaje accesible
Privacidad	0% Analíticas, 0% Rastreo	Cumplimiento estricto de normativas de protección de datos
Consideraciones de Rendimiento
Tamaño máximo de la aplicación: < 25 MB para móviles, < 50 MB para desktop
Tiempo de carga inicial: < 2 segundos en conexión 4G
Sincronización offline: Firestore permite operaciones offline sin configuración adicional
Consumo de batería: Optimizado mediante la desactivación de servicios de localización y analíticas
2. Diseño de UI/UX y Sistema de Color
Filosofía de Diseño
El diseño busca un equilibrio cuidadoso entre dos mundos aparentemente opuestos:

Lo académico → Seriedad, disciplina, profesionalismo, estructura
Lo canino → Calidez, confianza, cercanía, amabilidad
Paleta de Colores Extendida
Rol	Color	Código Hex	Uso específico
Primario (Base)	Azul Medianoche Profundo	#2C3E50	Barras de navegación, encabezados, textos principales, estados inactivos
Secundario (Acento)	Ámbar Canino	#F39C12	Botones CTA, indicadores de progreso, elementos interactivos, focos de atención
Fondo general	Gris Hueso Claro	#F4F7F6	Fondo de pantalla principal, reduce fatiga visual en sesiones largas
Superficies	Blanco Puro	#FFFFFF	Tarjetas (cards), modales, formularios, áreas de contenido
Éxito/Completado	Verde Menta	#27AE60	Confirmaciones, entrenamientos completados, estadísticas positivas
Error/Alerta	Rojo Suave	#E74C3C	Mensajes de error, validaciones fallidas, advertencias
Texto secundario	Gris Pizarra	#7F8C8D	Subtítulos, fechas, metadatos, información complementaria
Tipografía
Elemento	Fuente	Tamaño base	Peso
Títulos	Montserrat	24-32 sp	Bold/SemiBold
Subtítulos	Montserrat	18-20 sp	Medium
Texto cuerpo	Open Sans	14-16 sp	Regular
Texto pequeño	Open Sans	12 sp	Light
Botones	Montserrat	16 sp	SemiBold
Experiencia de Usuario (UX) Detallada
Navegación Adaptativa por Plataforma
Plataforma	Componente principal	Comportamiento
Móvil (Android/iOS)	Bottom Navigation Bar	4-5 íconos con etiquetas, accesible con una mano
Desktop (Windows/Web)	Navigation Drawer lateral	Expandible/contraíble, accesible mediante hamburger menu o atajo de teclado (Ctrl+D)
Micro-interacciones y Feedback
Todas las animaciones son 100% nativas, sin servicios externos de logging:

Acción	Animación	Duración
Completar entrenamiento	Confeti simulado + vibración suave (móvil)	300ms
Guardar progreso	Spinner de carga → checkmark	200ms
Cambiar de pestaña	Transición deslizante con curva easing	250ms
Error de formulario	Sacudida sutil del campo + borde rojo	150ms
Pull-to-refresh	Indicador circular con color ámbar	-
Accesibilidad
Escalado de fuentes: Soporta configuración de tamaño de texto del sistema (hasta 200%)
Contraste: Cumple nivel AA de WCAG 2.1 (relación de contraste mínima 4.5:1)
Navegación por teclado: Compatible con tabulación en Web/Desktop
Texto alternativo: Todas las imágenes requieren campo alt
Tamaño de objetivos táctiles: Mínimo 48x48 dp en móviles
3. Estructura de Directorios (Arquitectura Profesional Extendida)
canis_academia/
│
├── assets/                          # Recursos estáticos
│   ├── images/
│   │   ├── icons/                   # Iconos personalizados
│   │   ├── illustrations/           # Ilustraciones de onboarding/empty states
│   │   └── breeds/                  # Imágenes de razas caninas (placeholder)
│   ├── fonts/
│   │   ├── Montserrat/              # Fuente para títulos
│   │   └── OpenSans/                # Fuente para cuerpo
│   └── translations/                # Archivos ARB para internacionalización
│
├── lib/                             # Código fuente principal
│   │
│   ├── main.dart                    # Punto de entrada, inicialización de Firebase
│   │
│   ├── core/                        # Configuración global y utilidades
│   │   ├── constants/
│   │   │   ├── app_constants.dart   # Strings, rutas, configuraciones fijas
│   │   │   ├── exercise_catalog.dart # Catálogo de ejercicios predefinidos
│   │   │   └── validation_rules.dart # Reglas de validación comunes
│   │   ├── themes/
│   │   │   ├── app_theme.dart       # Tema claro/oscuro (solo claro inicial)
│   │   │   ├── color_palette.dart   # Definición centralizada de colores
│   │   │   └── text_styles.dart     # Estilos de texto reutilizables
│   │   └── utils/
│   │       ├── date_formatter.dart  # Formateo consistente de fechas
│   │       ├── error_handler.dart   # Manejo centralizado de errores
│   │       └── platform_check.dart  # Detección de plataforma actual
│   │
│   ├── models/                      # Entidades de datos (DTOs)
│   │   ├── user_model.dart          # Usuario entrenador/dueño
│   │   ├── dog_model.dart           # Perro registrado
│   │   ├── training_session_model.dart # Sesión de entrenamiento
│   │   ├── exercise_model.dart      # Ejercicio individual del catálogo
│   │   └── enums/
│   │       ├── dog_breed.dart       # Enum de razas soportadas
│   │       ├── difficulty_level.dart # Principiante, Intermedio, Avanzado
│   │       └── training_status.dart # Pendiente, Completado, Cancelado
│   │
│   ├── services/                    # Comunicación con Firebase
│   │   ├── firebase/
│   │   │   ├── firebase_init.dart   # Inicialización por plataforma
│   │   │   └── firebase_options.dart # Opciones generadas (FlutterFire CLI)
│   │   ├── auth_service.dart        # Login, registro, cierre de sesión
│   │   ├── dog_service.dart         # CRUD de perros
│   │   ├── training_service.dart    # CRUD de sesiones de entrenamiento
│   │   └── user_service.dart        # Gestión de perfil de usuario
│   │
│   ├── providers/                   # Gestión de estado (ChangeNotifier)
│   │   ├── auth_provider.dart       # Estado de autenticación
│   │   ├── dog_provider.dart        # Lista de perros del usuario
│   │   ├── training_provider.dart   # Sesiones y estadísticas
│   │   ├── ui_provider.dart         # Estado de la interfaz (sidebar, bottom nav)
│   │   └── mixins/
│   │       ├── loading_mixin.dart   # Estado de carga reutilizable
│   │       └── error_mixin.dart     # Manejo de errores en providers
│   │
│   ├── ui/                          # Capa de presentación
│   │   ├── screens/
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── register_screen.dart
│   │   │   │   └── forgot_password_screen.dart
│   │   │   ├── dashboard/
│   │   │   │   ├── dashboard_screen.dart      # Pantalla principal
│   │   │   │   ├── statistics_widget.dart     # Widget de estadísticas
│   │   │   │   └── recent_activity.dart       # Actividad reciente
│   │   │   ├── dogs/
│   │   │   │   ├── dog_list_screen.dart
│   │   │   │   ├── dog_detail_screen.dart
│   │   │   │   ├── add_dog_screen.dart
│   │   │   │   └── edit_dog_screen.dart
│   │   │   ├── training/
│   │   │   │   ├── training_history_screen.dart
│   │   │   │   ├── start_training_screen.dart
│   │   │   │   ├── training_detail_screen.dart
│   │   │   │   └── exercise_catalog_screen.dart
│   │   │   ├── profile/
│   │   │   │   ├── profile_screen.dart
│   │   │   │   └── edit_profile_screen.dart
│   │   │   └── settings/
│   │   │       ├── settings_screen.dart
│   │   │       └── about_screen.dart
│   │   │
│   │   ├── widgets/                 # Componentes reutilizables
│   │   │   ├── common/
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   ├── loading_indicator.dart
│   │   │   │   ├── empty_state_widget.dart
│   │   │   │   └── error_widget.dart
│   │   │   ├── navigation/
│   │   │   │   ├── adaptive_navigation.dart   # Decide entre Drawer y BottomNav
│   │   │   │   ├── mobile_bottom_nav.dart
│   │   │   │   └── desktop_drawer.dart
│   │   │   ├── dogs/
│   │   │   │   ├── dog_card.dart
│   │   │   │   ├── dog_selector.dart
│   │   │   │   └── dog_avatar.dart
│   │   │   └── training/
│   │   │       ├── score_selector.dart
│   │   │       ├── training_chart.dart
│   │   │       └── exercise_tile.dart
│   │   │
│   │   └── layouts/
│   │       ├── responsive_layout.dart          # Layout responsivo
│   │       └── scaffold_with_navigation.dart   # Scaffold adaptativo
│   │
│   └── bin/                         # Scripts de utilidad local
│       ├── firebase_config.dart     # Validación de Firebase por plataforma
│       ├── seed_data.dart           # Carga inicial de catálogo de ejercicios
│       ├── validators.dart          # Validaciones de negocio reutilizables
│       └── migration_scripts.dart   # Scripts para futuras migraciones
│
├── test/                            # Pruebas unitarias y de integración
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── web/                             # Configuración específica de Web
│   ├── index.html                   # Incluye Firebase Config (sin Analytics)
│   └── manifest.json
│
├── android/                         # Configuración nativa Android
│   ├── app/
│   │   ├── google-services.json     # (sin Analytics habilitado)
│   │   └── build.gradle
│   └── ...
│
├── ios/                             # Configuración nativa iOS
│   ├── Runner/
│   │   └── GoogleService-Info.plist # (sin Analytics)
│   └── ...
│
├── windows/                         # Configuración nativa Windows
│   ├── runner/
│   │   └── Runner.rc                # Capacidades de red habilitadas
│   └── ...
│
└── pubspec.yaml                     # Dependencias y assets declarados
4. Modelo de Datos Detallado (Firestore)
Colección: users
Atributo	Tipo	Restricciones	Descripción
uid	String	Required, Unique	ID único de Firebase Auth, usado como ID del documento
email	String	Required, Valid email	Correo electrónico del usuario (único por Auth)
name	String	Required, 2-50 caracteres	Nombre completo del entrenador/dueño
phone	String	Optional	Teléfono de contacto (para recordatorios futuros)
createdAt	Timestamp	Required	Fecha y hora de registro en la plataforma
lastLogin	Timestamp	Optional	Último acceso registrado
preferences	Map	Optional	Preferencias de UI (tema, notificaciones, etc.)
totalTrainings	int	Default: 0	Contador agregado de sesiones totales (optimización)
Colección: dogs
Atributo	Tipo	Restricciones	Descripción
id	String	Required, Auto-generado	ID único del documento en Firestore
ownerId	String	Required, Foreign key	Referencia al uid del usuario propietario
name	String	Required, 1-30 caracteres	Nombre del perro
breed	String	Required	Raza (seleccionada de catálogo predefinido)
age	int	Required, 0-30 años	Edad en años (permite decimales si se usa double)
weight	double	Optional	Peso en kg (para ejercicios personalizados)
photoUrl	String	Optional	URL de storage (foto subida por usuario)
registeredAt	Timestamp	Required	Fecha de registro del perro en la app
trainingLevel	Enum	Default: 'beginner'	Principiante, Intermedio, Avanzado
medicalNotes	String	Optional	Notas médicas relevantes (alergias, lesiones)
isActive	bool	Default: true	Permite archivar perros sin eliminarlos
Colección: training_sessions
Atributo	Tipo	Restricciones	Descripción
id	String	Required, Auto-generado	ID único del documento
dogId	String	Required, Foreign key	Referencia al perro entrenado
userId	String	Required, Foreign key	Referencia al usuario (para queries optimizadas)
date	Timestamp	Required	Fecha y hora de la sesión
exerciseId	String	Required	Referencia al catálogo de ejercicios
exerciseName	String	Required	Nombre del ejercicio (denormalizado para búsquedas)
score	int	Required, 1-5	Calificación del desempeño (1 = necesita mejora, 5 = excelente)
durationMinutes	int	Optional	Duración estimada de la sesión en minutos
observations	String	Optional	Notas del entrenador sobre el progreso
difficulty	Enum	Required	Nivel de dificultad del ejercicio realizado
completed	bool	Default: true	Estado de finalización
Colección: exercises_catalog (Solo lectura, datos maestros)
Atributo	Tipo	Descripción
id	String	ID único (sentado, quieto, junto, etc.)
name	String	Nombre del ejercicio
description	String	Instrucciones paso a paso
category	Enum	Obediencia básica, trucos, agilidad, socialización
difficulty	Enum	Principiante, Intermedio, Avanzado
estimatedTime	int	Minutos estimados por sesión
tips	List<String>	Consejos útiles para el entrenador
Índices Compuestos Requeridos en Firestore
// Para consultas eficientes:
1. sessions: [userId, date] (descendente)
2. sessions: [dogId, date] (descendente)
3. dogs: [ownerId, isActive]
4. sessions: [userId, exerciseName]
5. Configuración de Dependencias (pubspec.yaml Extendido)
name: canis_academia
description: Sistema profesional de gestión de entrenamiento canino.
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # ========== GESTIÓN DE ESTADO ==========
  provider: ^6.1.1
  flutter_riverpod: ^2.4.0           # Alternativa/Complemento para Provider

  # ========== FIREBASE (SIN ANALYTICS) ==========
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  # firebase_analytics: NO INCLUIR

  # ========== UI Y ESTILO ==========
  google_fonts: ^6.1.0
  font_awesome_flutter: ^10.6.0
  intl: ^0.19.0                       # Formateo de fechas
  flutter_svg: ^2.0.7                 # Íconos vectoriales
  shimmer: ^3.0.0                     # Efectos de carga esqueletales
  cached_network_image: ^3.3.0        # Caché de imágenes

  # ========== UTILIDADES GENERALES ==========
  uuid: ^4.2.2                        # Generación de IDs únicos
  image_picker: ^1.0.4                # Selección de fotos (perros)
  path_provider: ^2.1.0               # Almacenamiento local offline
  connectivity_plus: ^5.0.1           # Detección de estado de red
  shared_preferences: ^2.2.2          # Almacenamiento de preferencias locales
  device_info_plus: ^9.1.0            # Info de plataforma para debugging

  # ========== GRÁFICOS Y VISUALIZACIÓN ==========
  fl_chart: ^0.66.0                   # Gráficos de progreso

  # ========== VALIDACIÓN Y SEGURIDAD ==========
  validators: ^3.0.0                  # Validadores de email, URL, etc.

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  flutter_launcher_icons: ^0.13.1     # Generación de íconos de app

# ========== CONFIGURACIÓN DE ÍCONOS ==========
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/images/icon/app_icon.png"
  adaptive_icon_background: "#2C3E50"
  adaptive_icon_foreground: "assets/images/icon/foreground.png"

# ========== ASSETS DECLARADOS ==========
flutter:
  uses-material-design: true

  assets:
    - assets/images/icons/
    - assets/images/illustrations/
    - assets/images/breeds/
    - assets/translations/

  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat/Montserrat-Regular.ttf
          weight: 400
        - asset: assets/fonts/Montserrat/Montserrat-Medium.ttf
          weight: 500
        - asset: assets/fonts/Montserrat/Montserrat-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Montserrat/Montserrat-Bold.ttf
          weight: 700

    - family: OpenSans
      fonts:
        - asset: assets/fonts/OpenSans/OpenSans-Regular.ttf
          weight: 400
        - asset: assets/fonts/OpenSans/OpenSans-SemiBold.ttf
          weight: 600
6. Flujo de Implementación con Provider (Detallado)
6.1 Auth Provider (Autenticación)
// lib/providers/auth_provider.dart

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _checkAuthState();
  }

  void _checkAuthState() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapAuthError(e.code);
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = 'Error inesperado. Intente nuevamente.';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    _setLoading(true);
    _clearError();

    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Crear documento en Firestore
      await _createUserDocument(result.user!.uid, email.trim(), name);
      
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapAuthError(e.code);
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    await _auth.signOut();
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  String _mapAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con este correo.';
      case 'wrong-password':
        return 'Contraseña incorrecta.';
      case 'email-already-in-use':
        return 'Este correo ya está registrado.';
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres.';
      default:
        return 'Error de autenticación.';
    }
  }

  Future<void> _createUserDocument(String uid, String email, String name) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    await userRef.set({
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
      'totalTrainings': 0,
      'preferences': {
        'theme': 'light',
        'notifications': true,
      },
    });
  }
}
6.2 Dog Provider (Gestión de Perros)
// lib/providers/dog_provider.dart

class DogProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DogModel> _dogs = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _currentDogId;  // Perro seleccionado actualmente

  List<DogModel> get dogs => _dogs;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  DogModel? get currentDog => _dogs.firstWhere(
    (dog) => dog.id == _currentDogId,
    orElse: () => _dogs.isNotEmpty ? _dogs.first : DogModel.empty(),
  );

  void init(String userId) {
    _listenToDogsStream(userId);
  }

  void _listenToDogsStream(String userId) {
    _isLoading = true;
    notifyListeners();

    _firestore
        .collection('dogs')
        .where('ownerId', isEqualTo: userId)
        .where('isActive', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _dogs = snapshot.docs.map((doc) => DogModel.fromFirestore(doc)).toList();
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    }, onError: (error) {
      _isLoading = false;
      _errorMessage = 'Error al cargar perros: $error';
      notifyListeners();
    });
  }

  Future<bool> addDog(DogModel dog) async {
    _setLoading(true);

    try {
      final docRef = _firestore.collection('dogs').doc();
      final dogWithId = dog.copyWith(id: docRef.id);
      await docRef.set(dogWithId.toFirestore());
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Error al agregar perro: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> updateDog(DogModel dog) async {
    _setLoading(true);

    try {
      await _firestore.collection('dogs').doc(dog.id).update(dog.toFirestore());
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Error al actualizar perro: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteDog(String dogId) async {
    _setLoading(true);

    try {
      // Soft delete: solo marcar como inactivo
      await _firestore.collection('dogs').doc(dogId).update({
        'isActive': false,
      });
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Error al eliminar perro: $e';
      _setLoading(false);
      return false;
    }
  }

  void setCurrentDog(String dogId) {
    _currentDogId = dogId;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
6.3 Training Provider (Sesiones y Estadísticas)
// lib/providers/training_provider.dart

class TrainingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TrainingSessionModel> _sessions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TrainingSessionModel> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  double get averageScore {
    if (_sessions.isEmpty) return 0.0;
    final total = _sessions.fold<int>(0, (sum, session) => sum + session.score);
    return total / _sessions.length;
  }

  Map<String, int> get exercisesCount {
    final Map<String, int> count = {};
    for (var session in _sessions) {
      count[session.exerciseName] = (count[session.exerciseName] ?? 0) + 1;
    }
    return count;
  }

  void loadSessionsForDog(String dogId) {
    _isLoading = true;
    notifyListeners();

    _firestore
        .collection('sessions')
        .where('dogId', isEqualTo: dogId)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((snapshot) {
      _sessions = snapshot.docs
          .map((doc) => TrainingSessionModel.fromFirestore(doc))
          .toList();
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    }, onError: (error) {
      _isLoading = false;
      _errorMessage = 'Error al cargar sesiones: $error';
      notifyListeners();
    });
  }

  Future<bool> saveSession(TrainingSessionModel session) async {
    _setLoading(true);

    try {
      final docRef = _firestore.collection('sessions').doc();
      final sessionWithId = session.copyWith(id: docRef.id);
      await docRef.set(sessionWithId.toFirestore());
      
      // Actualizar contador en el usuario
      await _incrementUserTrainingCount(session.userId);
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Error al guardar sesión: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<void> _incrementUserTrainingCount(String userId) async {
    final userRef = _firestore.collection('users').doc(userId);
    await userRef.update({
      'totalTrainings': FieldValue.increment(1),
    });
  }

  List<TrainingSessionModel> getSessionsByDateRange(
    DateTime start,
    DateTime end,
  ) {
    return _sessions.where((session) {
      return session.date.isAfter(start) && session.date.isBefore(end);
    }).toList();
  }

  Map<int, double> getWeeklyProgress() {
    final Map<int, double> weekly = {};
    final now = DateTime.now();
    
    for (int i = 6; i >= 0; i--) {
      final day = now.subtract(Duration(days: i));
      final daySessions = _sessions.where((s) =>
        s.date.year == day.year &&
        s.date.month == day.month &&
        s.date.day == day.day
      ).toList();
      
      final avgScore = daySessions.isNotEmpty
          ? daySessions.fold<int>(0, (sum, s) => sum + s.score) / daySessions.length
          : 0.0;
      
      weekly[day.weekday] = avgScore;
    }
    
    return weekly;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
7. Pasos Críticos para Multiplataforma (Extendido)
7.1 Configuración General de Firebase
Paso 1: Crear proyecto en Firebase Console

Nombre: canis-academia
IMPORTANTE: Desactivar Google Analytics durante la creación del proyecto
Ubicación recomendada: europe-west1 (para cumplir GDPR)
Paso 2: Habilitar autenticación

Método: Solo "Email/Password"
Desactivar: "Account linking" y "Multi-factor authentication" inicial
Paso 3: Configurar Firestore

Modo: Producción (reglas de seguridad estrictas)
Ubicación: Misma que el proyecto
7.2 Configuración por Plataforma
Android
// android/app/build.gradle
defaultConfig {
    minSdkVersion 21
    targetSdkVersion 33
    multiDexEnabled true
}

dependencies {
    // No incluir: implementation 'com.google.firebase:firebase-analytics'
    implementation platform('com.google.firebase:firebase-bom:32.5.0')
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-firestore'
}
Archivo google-services.json:

Descargar desde Firebase Console
Colocar en android/app/
Verificar que NO contenga referencias a analytics
iOS
# ios/Podfile
platform :ios, '12.0'

# En post_install:
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'FIREBASE_ANALYTICS_SUPPRESS_WARNING=1',  # Suprimir warnings sin Analytics
      ]
    end
  end
end
Web
<!-- web/index.html -->
<!DOCTYPE html>
<html>
<head>
  <!-- Firebase Config (sin Analytics) -->
  <script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.0/firebase-app.js";
    import { getAuth } from "https://www.gstatic.com/firebasejs/10.7.0/firebase-auth.js";
    import { getFirestore } from "https://www.gstatic.com/firebasejs/10.7.0/firebase-firestore.js";
    
    // No importar getAnalytics
    
    const firebaseConfig = {
      apiKey: "TU_API_KEY",
      authDomain: "canis-academia.firebaseapp.com",
      projectId: "canis-academia",
      storageBucket: "canis-academia.appspot.com",
      messagingSenderId: "XXXXXXXXXX",
      appId: "1:XXXXXXXXXX:web:XXXXXXXXXX"
    };
    
    const app = initializeApp(firebaseConfig);
    window.firebaseAuth = getAuth(app);
    window.firebaseFirestore = getFirestore(app);
  </script>
  
  <!-- CanvasKit para gráficos de alta calidad -->
  <script src="https://unpkg.com/canvaskit-wasm@0.39.1/bin/canvaskit.js"></script>
</head>
<body>
  <script src="flutter.js" defer></script>
</body>
</html>
Windows
// windows/runner/Runner.rc
// Habilitar capacidades de red
#include <winres.h>

#define APP_VERSION 1,0,0,1
#define APP_VERSION_STRING "1.0.0.1"

CREATEPROCESS_MANIFEST_RESOURCE_ID RT_MANIFEST "runner.exe.manifest"

// En runner.exe.manifest:
// <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
//   <application>
//     <supportedOS Id="{8e0f7a12-bfb3-4fe8-b9a5-48fd50a15a9a}"/> <!-- Windows 10 -->
//     <supportedOS Id="{1f676c76-80e1-4239-95bb-83d0f6d0da78}"/> <!-- Windows 8.1 -->
//   </application>
// </compatibility>
7.3 Inicialización Multiplataforma
// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicialización multiplataforma de Firebase (sin Analytics)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // No llamar a FirebaseAnalytics.instance.enable()
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, DogProvider>(
          create: (_) => DogProvider(),
          update: (_, auth, dogProvider) {
            if (auth.user != null) {
              dogProvider?.init(auth.user!.uid);
            }
            return dogProvider;
          },
        ),
        ChangeNotifierProxyProvider<AuthProvider, TrainingProvider>(
          create: (_) => TrainingProvider(),
          update: (_, auth, trainingProvider) => trainingProvider,
        ),
        ChangeNotifierProvider(create: (_) => UiProvider()),
      ],
      child: MaterialApp(
        title: 'Canis Academia',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: ResponsiveLayout(
          child: AuthWrapper(),
        ),
      ),
    );
  }
}
8. Reglas de Seguridad de Firestore (Recomendadas)
// firestore.rules

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Verificar autenticación
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Verificar ownership
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // Colección: users
    match /users/{userId} {
      allow read: if isAuthenticated() && isOwner(userId);
      allow write: if isAuthenticated() && isOwner(userId);
    }
    
    // Colección: dogs
    match /dogs/{dogId} {
      allow read: if isAuthenticated() && resource.data.ownerId == request.auth.uid;
      allow create: if isAuthenticated() && request.resource.data.ownerId == request.auth.uid;
      allow update: if isAuthenticated() && resource.data.ownerId == request.auth.uid;
      allow delete: if false;  // Soft delete solamente
    }
    
    // Colección: sessions
    match /sessions/{sessionId} {
      allow read: if isAuthenticated() && resource.data.userId == request.auth.uid;
      allow create: if isAuthenticated() && request.resource.data.userId == request.auth.uid;
      allow update: if isAuthenticated() && resource.data.userId == request.auth.uid;
      allow delete: if false;
    }
    
    // Colección: exercises_catalog (solo lectura)
    match /exercises_catalog/{exerciseId} {
      allow read: if true;
      allow write: if false;
    }
  }
}
9. Consideraciones de Privacidad Adicionales
9.1 Política de Datos
CANIS ACADEMIA - DECLARACIÓN DE PRIVACIDAD

1. RECOPILACIÓN DE DATOS:
   - No se utilizan servicios de analíticas o rastreo.
   - Solo se almacenan: correo electrónico, nombre, datos de perros y registros de entrenamiento.
   - No se recopilan datos de localización, contactos, o archivos multimedia sin consentimiento explícito.

2. ALMACENAMIENTO:
   - Todos los datos residen en servidores de Firebase (Google Cloud Platform).
   - Los datos se transmiten cifrados mediante TLS 1.2+.

3. DERECHOS DEL USUARIO:
   - Exportación de datos: disponible desde el panel de configuración.
   - Eliminación de cuenta: elimina permanentemente todos los datos asociados.

4. CONTACTO DE PRIVACIDAD:
   - privacy@canisacademia.com
9.2 Verificación de Ausencia de Analytics
# Comando para verificar que no hay dependencias de analytics
cd canis_academia
grep -r "analytics" pubspec.yaml
grep -r "Analytics" lib/
grep -r "firebase_analytics" .

# Resultado esperado: 0 coincidencias
10. Próximos Pasos y Entregables
¿Deseas que genere el código base para?
✅ AuthProvider completo (ya incluido arriba)
Pantalla de Login/Registro con validaciones y animaciones
Dashboard principal con gráficos de progreso y selector de perros
Sistema de registro de entrenamientos con selector de ejercicios
Perfil de usuario y configuración (incluyendo exportación de datos)
Script de seeding (seed_data.dart) para cargar catálogo de ejercicios
Pruebas unitarias para providers y servicios
Por favor, indícame qué componente deseas que desarrolle completamente a continuación, y generaré el código completo, listo para copiar y pegar en tu proyecto. 🐕
