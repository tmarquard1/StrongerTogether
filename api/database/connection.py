from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Retrieve database connection details from environment variables
# DATABASE_URL = os.getenv("DATABASE_URL")
DATABASE_URL="postgresql+psycopg2://user:password@db:5432/stronger_together"

if not DATABASE_URL:
    raise RuntimeError("DATABASE_URL environment variable is not set.")

# Create the SQLAlchemy engine
engine = create_engine(DATABASE_URL)

# Create a configured "Session" class
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Dependency to get a database session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()