
#crear env python -m venv env
#activar env source env/bin/activate
# #instal openai " pip install openai"
# # import os "pip install python-dotenv"
import os
from dotenv import load_dotenv
from openai import OpenAI

# Cargar variables de entorno desde .env
load_dotenv()

client = OpenAI(
    base_url="https://router.huggingface.co/v1",
    api_key=os.environ.get("HF_TOKEN"),
)

completion = client.chat.completions.create(
    model="MiniMaxAI/MiniMax-M2.5:novita",
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "input_text",
                    "text": "¿Cuál es la capital de Francia?"
                
                }
            ]
        }
    ],
)

print(completion.choices[0].message)