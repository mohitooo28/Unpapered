# 🤖 Unpapered Backend

A FastAPI server powered by Google Gemini AI for intelligent PDF processing and real-time chat functionality. Upload PDFs and engage in AI-powered conversations about their content.

## 🏗️ Folder Structure

```
unpapered_backend/
├── main.py             # 🔧 Main FastAPI application
├── requirements.txt    # 📦 Python dependencies
├── .env.example        # 📋 Environment variables template
├── .env                # 🔐 Environment variables (not in git)
├── .gitignore          # 🚫 Git ignore rules
├── faiss_index/        # 🗃️ Vector database storage (auto-generated)
└── README.md           # 📝 This file
```

## 🚀 Quick Start

### Prerequisites

-   **Python** 3.8+
-   **pip** package manager
-   **Google Gemini API Key** ([Get yours here](https://makersuite.google.com/app/apikey))

### Installation

```bash
# Navigate to backend directory
cd unpapered_backend

# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Set up environment variables
cp .env.example .env
# Edit .env and add your Google API key

# Start development server
python main.py
```

## 🔧 Environment Configuration

Create a `.env` file in the backend root directory:

```env
# Google Gemini API Configuration
GOOGLE_API_KEY=your_google_gemini_api_key_here

# Server Configuration
HOST=127.0.0.1
PORT=8000
```

## 📡 API Endpoints

| Method      | Endpoint              | Description                        |
| ----------- | --------------------- | ---------------------------------- |
| `POST`      | `/upload_and_process` | Upload and process PDF for AI chat |
| `WebSocket` | `/ws`                 | Real-time chat with processed PDF  |

## 🧠 AI Processing Pipeline

### 1. **PDF Text Extraction**

-   Uses PyPDF2 to extract text from uploaded PDFs
-   Handles multi-page documents efficiently
-   Error handling for corrupted or unsupported files

### 2. **Text Chunking**

-   Splits large documents into manageable chunks (10,000 chars)
-   Maintains context with 1,000 character overlap
-   Optimized for AI processing and retrieval

### 3. **Vector Embeddings**

-   Creates embeddings using Google's `models/embedding-001`
-   Stores in FAISS vector database for fast similarity search
-   Enables semantic search across document content

### 4. **AI Chat Integration**

-   Powered by Google's Gemini Pro model
-   Context-aware responses based on PDF content
-   Temperature setting (0.5) for balanced creativity/accuracy

## 🛠️ Built With

-   ⚡ **FastAPI 0.110.0** – Modern web framework
-   🔄 **Uvicorn** – ASGI server for deployment
-   🤖 **Google Generative AI (Gemini Pro)** – AI chat responses
-   🧠 **LangChain 0.1.13** – AI orchestration framework
-   📊 **FAISS CPU 1.8.0** – Vector similarity search
-   📄 **PyPDF2 3.0.1** – PDF text extraction
-   ✂️ **Text Splitter** – Smart document chunking
-   🌐 **Python Multipart** – File upload support
-   🔐 **Python Dotenv** – Environment configuration
-   📡 **WebSocket Support** – Real-time features

## 📊 API Usage Examples

### Upload PDF (cURL)

```bash
curl -X POST "http://127.0.0.1:8000/upload_and_process" \
     -H "Content-Type: multipart/form-data" \
     -F "pdf=@/path/to/your/document.pdf"
```

### WebSocket Chat (Python)

```python
import asyncio
import websockets

async def chat_with_pdf():
    uri = "ws://127.0.0.1:8000/ws"
    async with websockets.connect(uri) as websocket:
        # Send question
        await websocket.send("What are the key findings?")

        # Receive response
        response = await websocket.recv()
        print(f"AI: {response}")

        # Wait for completion signal
        fin = await websocket.recv()
        if fin == "<FIN>":
            print("Response complete")

asyncio.run(chat_with_pdf())
```

---
