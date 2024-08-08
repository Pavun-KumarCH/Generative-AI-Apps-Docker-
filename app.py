from fastapi import FastAPI
from transformers import pipeline

## creta a new FASTAPI app instances
app = FastAPI()


# Initializing the text Generation Pipeline
pipe = pipeline("text2text-generation", model = "google/flan-t5-small")

@app.get("/")
def home():
    return {"message" : "Hello World..!"}

# Define a Function to handle the GET Request at '/generate'

@app.get("/generate")
def generate(text : str):
    ### use the pipeline to generate text from given input text
    output = pipe(text)

    ## return the generate text in Json response
    return {"output" : output[0]['generated_text']}
