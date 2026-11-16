import os
import sys

import uvicorn

# Asegurar que el directorio BACKEND esté en el path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

from main import app

if __name__ == "__main__":
    # 0.0.0.0 = acepta conexiones de otros dispositivos (celular en la misma red).
    # En un servidor (Render, Railway...) el puerto llega en la variable PORT.
    port = int(os.environ.get("PORT", "8001"))
    print(f"Iniciando servidor AgendaX en http://0.0.0.0:{port}")
    uvicorn.run(app, host="0.0.0.0", port=port)
