# 📚 Unpapered Frontend

A modern Flutter mobile application for intelligent PDF interaction powered by AI. Chat with your PDFs using Google Gemini AI through an intuitive mobile interface.

## 🏗️ Project Structure

```
unpapered_frontend/
├── 📁 android/                             # Android-specific configuration
│   ├── app/
│   │   ├── build.gradle                    # Android build configuration
│   │   └── google-services.json            # Firebase Android config (not in git)
│   └── gradle/                             # Gradle wrapper files
│
├── 📁 ios/                                 # iOS-specific configuration
│   ├── Runner/
│   │   ├── GoogleService-Info.plist        # Firebase iOS config (not in git)
│   │   └── Info.plist                      # iOS app configuration
│   └── firebase_app_id_file.json           # Firebase iOS app ID (not in git)
│
├── 📁 lib/                                 # Main application source code
│   ├── 🔗 bindings/                        # GetX dependency bindings
│   │   └── general_bindings.dart           # General app bindings
│   │
│   ├── 📱 screens/                         # Application screens
│   │   ├── authentication/                 # User authentication
│   │   │   ├── controllers/                # Auth controllers
│   │   │   ├── repository/                 # Auth data layer
│   │   │   ├── screens/                    # Auth UI screens
│   │   │   └── widgets/                    # Auth UI components
│   │   │
│   │   ├── home/                           # Home screen
│   │   │   ├── home_screen.dart            # Main home interface
│   │   │   └── widgets/                    # Home UI components
│   │   │       └── file_picker.dart        # PDF file selection
│   │   │
│   │   ├── on_boarding/                    # App introduction
│   │   │   └── ...                         # Onboarding screens
│   │   │
│   │   └── pdf_chat/                       # PDF chat functionality
│   │       ├── chat_page.dart              # Chat interface
│   │       └── chat_manager.dart           # WebSocket chat logic
│   │
│   ├── 🛠️ utils/                           # Utilities and helpers
│   │   ├── api_config.dart                 # API configuration
│   │   ├── network_manager.dart            # Network utilities
│   │   └── exceptions/                     # Custom exceptions
│   │
│   ├── 🎨 widget/                          # Reusable UI components
│   │   ├── error_box.dart                  # Error display widget
│   │   ├── full_loader.dart                # Loading screens
│   │   ├── loaders.dart                    # Loading indicators
│   │   └── processing.dart                 # Processing animations
│   │
│   ├── firebase_options.dart               # Firebase configuration (not in git)
│   └── main.dart                           # App entry point
│
├── 📁 assets/                              # Static assets
│   ├── email/                              # Email-related animations
│   ├── home/                               # Home screen assets
│   ├── load/                               # Loading animations
│   ├── logos/                              # App logos and branding
│   ├── onboard/                            # Onboarding animations
│   ├── popup/                              # UI popup assets
│   └── sadie/                              # Chat assistant assets
│
├── 📁 test/                                # Test files
│   └── widget_test.dart                    # Widget tests
│
├── .gitignore                              # Git ignore rules
├── analysis_options.yaml                   # Dart analysis config
├── pubspec.yaml                            # Flutter dependencies
├── pubspec.lock                            # Dependency lock file
├── splash.yaml                             # Splash screen config
└── FIREBASE_SETUP.md                       # Firebase setup guide
```

## 🚀 Quick Start

### Prerequisites

-   **Flutter SDK** 3.2.3+
-   **Dart SDK** 3.2.3+
-   **Android Studio**
-   **Firebase Project**
-   **Google Gemini API Key**

### Installation

```bash
# Navigate to frontend directory
cd unpapered_frontend

# Install Flutter dependencies
flutter pub get

# Generate necessary files
flutter packages pub run build_runner build

# Run on connected device/emulator
flutter run
```

## 🔧 Configuration

### 1. Firebase Setup

Before running the app, you need to configure Firebase:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure Firebase for your project
flutterfire configure
```

This will generate the required Firebase configuration files:

-   `lib/firebase_options.dart`
-   `android/app/google-services.json`
-   `ios/Runner/GoogleService-Info.plist`
-   `ios/firebase_app_id_file.json`

> 📖 For detailed Firebase setup instructions, see [Firebase Setup](docs/FIREBASE_SETUP.md)

### 2. Backend API Configuration

Update the API endpoints in `lib/utils/api_config.dart`:

```dart
class ApiConfig {
  // For local development
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const String wsUrl = 'ws://127.0.0.1:8000/ws';

  // For production deployment
  // static const String baseUrl = 'https://your-api-domain.com';
  // static const String wsUrl = 'wss://your-api-domain.com/ws';

  // API Endpoints
  static const String uploadAndProcess = '\$baseUrl/upload_and_process';
}
```

## 🔑 Required Services

### Backend Dependencies

Ensure your FastAPI backend is running with the following endpoints:

-   `POST /upload_and_process` - PDF file upload and processing
-   `WebSocket /ws` - Real-time chat communication

### External Services

-   **Firebase Authentication** - User management
-   **Firebase Firestore** - Data storage
-   **Google Gemini API** - AI-powered PDF analysis

## 🛠️ Built With

-   ⚙️ **Flutter 3.2.3+ / Dart 3.2.3+** – Core framework & language
-   🧭 **GetX 4.6.6** – State management & navigation
-   🔥 **Firebase (Core, Auth, Firestore)** – Backend & authentication
-   🌐 **HTTP 1.2.0** – API communication
-   🔌 **Web Socket Channel 2.4.4** - Real-time communication
-   💾 **GetStorage 2.1.1** – Local storage
-   🎨 **Google Fonts 6.1.0** – Custom typography
-   🎬 **Lottie 3.1.0** – Animations
-   📁 **File Picker 6.1.1** – File selection
-   💬 **Dash Chat 2** – Chat interface

---
