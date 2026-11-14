import sys
import os
import uvicorn

# Asegurar que el directorio BACKEND esté en el path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

from main import app

if __name__ == "__main__":
    print("Iniciando servidor AgendaX en http://127.0.0.1:8001")
    uvicorn.run(app, host="127.0.0.1", port=8001)
