"""Waits for SQL Server to start, then runs the training database script."""

import re
import sys
import time
from pathlib import Path

import pyodbc

CONNECTION_STRING = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=localhost,1433;"
    "UID=sa;PWD=Training!Pass2026;"
    "Encrypt=yes;TrustServerCertificate=yes;"
)
SCRIPT = Path(__file__).resolve().parent.parent / "sql" / "01_create_training_database.sql"


def connect_when_ready(attempts: int = 60, wait_seconds: int = 3) -> pyodbc.Connection:
    for attempt in range(1, attempts + 1):
        try:
            return pyodbc.connect(CONNECTION_STRING, autocommit=True, timeout=5)
        except pyodbc.Error:
            print(f"   SQL Server is still starting (attempt {attempt} of {attempts})...")
            time.sleep(wait_seconds)
    sys.exit("SQL Server did not start in time. Rebuild the codespace or ask the trainer.")


def main() -> None:
    connection = connect_when_ready()
    cursor = connection.cursor()
    # Split the script into batches on lines containing only "GO", as SQL Server Management Studio does.
    batches = re.split(r"^\s*GO\s*$", SCRIPT.read_text(encoding="utf-8"), flags=re.MULTILINE | re.IGNORECASE)
    for batch in batches:
        if batch.strip():
            cursor.execute(batch)
            while cursor.nextset():
                pass
    print("   TrainingShop database is ready.")


if __name__ == "__main__":
    main()
