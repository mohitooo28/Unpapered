from fastapi import FastAPI, WebSocket, UploadFile, File, HTTPException, WebSocketDisconnect
from PyPDF2 import PdfReader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.chains.question_answering import load_qa_chain
from langchain.prompts import PromptTemplate
import google.generativeai as genai
import uvicorn
import logging
import os
from dotenv import load_dotenv

load_dotenv()
genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))

app = FastAPI()
logging.basicConfig(level=logging.DEBUG)

def get_pdf_text(pdf_file):
    text = ""
    try:
        pdf_reader = PdfReader(pdf_file)
        num_pages = len(pdf_reader.pages)
        for page_num in range(num_pages):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
        return text
    except Exception as e:
        logging.error("Error occurred while extracting text from PDF: %s", e)
        raise ValueError("Error occurred while extracting text from PDF: " + str(e))

def get_text_chunks(text):
    splitter = RecursiveCharacterTextSplitter(
        chunk_size=10000, chunk_overlap=1000)
    chunks = splitter.split_text(text)
    return chunks  

def get_vector_store(chunks):
    embeddings = GoogleGenerativeAIEmbeddings(
        model="models/embedding-001")
    vector_store = FAISS.from_texts(chunks, embedding=embeddings)
    try:
        vector_store.save_local("faiss_index")
        logging.info("FAISS index created and saved successfully.")
    except Exception as e:
        logging.error("Error occurred while saving FAISS index: %s", e)

def load_faiss_index(embeddings):
    try:
        return FAISS.load_local("faiss_index", embeddings, allow_dangerous_deserialization=True)
    except Exception as e:
        logging.error("Error occurred while loading FAISS index: %s", e)
        return None

def get_conversational_chain():
    prompt_template = """
    Answer the question as detailed as possible from the provided context only. Format them well\n\n
    Context:\n {context}?\n
    Question: \n{question}\n

    Answer:
    """

    model = ChatGoogleGenerativeAI(model="gemini-pro",
                                   client=genai,
                                   temperature=0.5,
                                   )
    prompt = PromptTemplate(template=prompt_template,
                            input_variables=["context", "question"])
    chain = load_qa_chain(llm=model, chain_type="stuff", prompt=prompt)
    return chain

def user_input(user_question):
    embeddings = GoogleGenerativeAIEmbeddings(
        model="models/embedding-001")

    new_db = load_faiss_index(embeddings)
    docs = new_db.similarity_search(user_question)

    chain = get_conversational_chain()

    response = chain.invoke(
        {"input_documents": docs, "question": user_question}, return_only_outputs=True)
    
    return response

@app.post("/upload_and_process")
async def upload_and_process(pdf: UploadFile = File(...)):
    try:
        text = get_pdf_text(pdf.file)
        text_chunks = get_text_chunks(text)
        get_vector_store(text_chunks)
        return {"message": "File Uploaded Successfully"}
    except Exception as e:
        logging.error("Error occurred while processing the uploaded file: %s", e)
        return {"error": str(e)}

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    try:
        while True:
            message = await websocket.receive_text()
            if message == "!<FIN>!":
                await websocket.close()
                break
            
            response = user_input(message)
            await websocket.send_text(response['output_text'])
            await websocket.send_text("<FIN>")
    except WebSocketDisconnect as e:
        logging.info(f"WebSocket disconnected: {e.code} - {e.reason}")
    except Exception as e:
        logging.error(f"Error in WebSocket connection: {e}")
        await websocket.close()
        
if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)
