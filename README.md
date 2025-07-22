# 📚 Unpapered - AI-Powered PDF Chat Application

<div align="center">
  <img src="unpapered_frontend/assets/logos/logo.svg" alt="Unpapered Logo" width="220"> <br/>  <br/>  
  
  **A modern Flutter mobile application for intelligent PDF interaction powered by Google Gemini AI**
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.2.3+-blue.svg)](https://flutter.dev/)
  [![FastAPI](https://img.shields.io/badge/FastAPI-0.110.0-green.svg)](https://fastapi.tiangolo.com/)
  [![Python](https://img.shields.io/badge/Python-3.8+-yellow.svg)](https://python.org/)
  [![Firebase](https://img.shields.io/badge/Firebase-✓-orange.svg)](https://firebase.google.com/)
  [![Google AI](https://img.shields.io/badge/Google_Gemini-AI-red.svg)](https://ai.google.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

---

## ✨ Key Features

-   **🤖 AI-Powered Chat** - Intelligent conversations with your PDFs using Google Gemini AI
-   **📄 PDF Processing** - Advanced text extraction and semantic analysis of document content
-   **💬 Real-time Chat** - WebSocket-based instant messaging with AI responses
-   **🔥 Firebase Integration** - Secure user authentication and data management
-   **📱 Cross-Platform** - Native Flutter app for both iOS and Android devices
-   **🎨 Modern UI** - Clean, intuitive interface with Lottie animations
-   **🔍 Semantic Search** - Vector-based similarity search across document content
-   **⚡ Fast Processing** - Optimized text chunking and embedding generation
-   **🔒 Secure Storage** - Environment-based API key management and secure configuration
-   **📊 Smart Chunking** - Context-aware document splitting for better AI responses

## 🏗️ Architecture

```
Unpapered/
├── 📁 unpapered_backend/
│   ├── 🔧 main.py             #  FastAPI server & AI logic
│   ├── 📦 requirements.txt    #  Python dependencies
│   ├── 📋 .env.example        #  Environment template
│   └── 🚫 .gitignore          #  Git ignore rules
│
├── 📁 unpapered_frontend/
│   ├── lib/
│   │   ├── 📱 screens/        # App screens & UI
│   │   ├── 🛠️ utils/          # Utilities & API config
│   │   ├── 🎨 widget/         # Reusable components
│   │   └── 🔗 bindings/       # GetX bindings
│   ├── 🎭 assets/             #  Images & animations
│   ├── 📦 pubspec.yaml        #  Flutter dependencies
│   └── 🚫 .gitignore          #  Git ignore rules
│
└── 📝 README.md
```

## 🚀 Quick Start

### Prerequisites

-   **Flutter SDK** 3.2.3+
-   **Python** 3.8+
-   **Firebase Project** ([Create one here](https://console.firebase.google.com/))
-   **Google Gemini API Key** ([Get yours here](https://makersuite.google.com/app/apikey))
-   **Android Studio**

### 1. Clone & Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/Unpapered
cd Unpapered
```

### 2. Backend Setup

```bash
# Navigate to backend directory
cd unpapered_backend

# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install Python dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env and add your Google Gemini API key
```

**Backend Environment Configuration (.env):**

```env
# Google Gemini API Configuration
GOOGLE_API_KEY=your_google_gemini_api_key_here

# Server Configuration
HOST=127.0.0.1
PORT=8000
```

### 3. Frontend Setup

```bash
# Navigate to frontend directory
cd unpapered_frontend

# Install Flutter dependencies
flutter pub get

# Configure Firebase (follow FIREBASE_SETUP.md for detailed steps)
# Install Firebase CLI & FlutterFire CLI
npm install -g firebase-tools
dart pub global activate flutterfire_cli

# Login and configure Firebase
firebase login
flutterfire configure
```

### 4. Start Development Servers

```bash
# Terminal 1 - Start backend server
cd unpapered_backend
python main.py

# Terminal 2 - Start Flutter app
cd unpapered_frontend
flutter run
```

🎉 **Access the application:**

-   **Backend API**: [http://127.0.0.1:8000](http://127.0.0.1:8000)
-   **Flutter App**: Running on connected device/emulator

## 📖 How to Use

### 📚 For PDF Chat

1. **Launch the App** - Open Unpapered on your mobile device
2. **Sign In** - Authenticate using Firebase (Email/Google/etc.)
3. **Upload PDF** - Select a PDF document from your device
4. **Wait for Processing** - AI will analyze and index your document
5. **Start Chatting** - Ask questions about your PDF content
6. **Get AI Responses** - Receive intelligent answers powered by Gemini AI
7. **Continue Conversation** - Have natural conversations about the document

### 💡 Pro Tips

-   **Document Quality**: Clear, text-based PDFs work best for accurate responses
-   **Specific Questions**: Ask detailed questions for more precise AI answers
-   **Context**: The AI remembers previous questions in your chat session
-   **File Size**: Larger documents may take longer to process initially
-   **Network**: Stable internet connection required for AI processing

## 🔌 API Flow

| Step | Action                   | Description                              |
| ---- | ------------------------ | ---------------------------------------- |
| `1`  | **PDF Upload**           | Mobile app uploads PDF to backend        |
| `2`  | **Text Extraction**      | PyPDF2 extracts text from document       |
| `3`  | **Text Chunking**        | LangChain splits text into segments      |
| `4`  | **Vector Embedding**     | Google AI creates semantic embeddings    |
| `5`  | **FAISS Indexing**       | Vector database stores embeddings        |
| `6`  | **WebSocket Connection** | Real-time chat channel established       |
| `7`  | **AI Chat Processing**   | Gemini AI generates contextual responses |

## 🛠️ Tech Stack

**🖥️ Backend**

-   ⚡ **FastAPI** - Modern Python web framework
-   🤖 **Google Gemini AI** - AI chat responses
-   🧠 **LangChain** - AI application framework
-   📊 **FAISS** - Vector similarity search
-   📄 **PyPDF2** - PDF text extraction
-   🔄 **Uvicorn** - ASGI server
-   📡 **WebSocket** - Real-time communication

**📱 Frontend**

-   📱 **Flutter** - Cross-platform mobile framework
-   🎯 **Dart** - Programming language
-   🔄 **GetX** - State management & navigation
-   🔥 **Firebase** - Authentication & backend services
-   🌐 **HTTP** - API communication
-   🔌 **WebSocket** - Real-time chat
-   🎨 **Google Fonts** - Typography
-   🎬 **Lottie** - Animations

**🔗 Core Technology**

-   🧠 **Google Gemini Pro** - AI language model
-   📊 **Vector Embeddings** - Semantic search
-   🔥 **Firebase Auth** - User management
-   📡 **WebSocket** - Real-time communication

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Built with ❤️ for intelligent document interaction**

[🌟 Star this repo](../../stargazers) • [🐛 Report Bug](../../issues) • [💡 Request Feature](../../issues)

</div>
