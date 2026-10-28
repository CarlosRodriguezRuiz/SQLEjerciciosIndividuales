import sqlite3
from pathlib import Path

carpeta = Path(__file__).resolve().parent

conn = sqlite3.connect(carpeta / "sql-murder-mystery.db")

with open(carpeta / "sql-murder-mystery.sql", "w", encoding="utf-8") as archivo:
    for linea in conn.iterdump():
        archivo.write(linea + "\n")

conn.close()

print("Base de datos exportada correctamente")