import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Obtener la ruta absoluta del directorio BACKEND
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SQLALCHEMY_DATABASE_URL = f"sqlite:///{os.path.join(BASE_DIR, 'barberia.db')}"

# Engine es el punto de entrada a la base de datos
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

# SessionLocal es lo que usaremos para hacer consultas (leer/escribir)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base es de donde heredaremos todos nuestros modelos
Base = declarative_base()
