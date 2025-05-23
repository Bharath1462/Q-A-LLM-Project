from fastapi import FastAPI, Query
from app.utils import ask_bedrock

app = FastAPI()

@app.get("/ask")
def ask(question: str = Query(...)):
    return {"answer": ask_bedrock(question)}
