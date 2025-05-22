from datetime import datetime, timezone
from sqlalchemy import Column, Integer, String, Boolean, DateTime
from sqlalchemy.ext.declarative import declarative_base
from pydantic import BaseModel, EmailStr

Base = declarative_base()

# SQLAlchemy model
class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, autoincrement=True)
    username = Column(String, nullable=False, unique=True)
    email = Column(String, nullable=False, unique=True)
    verified_email = Column(Boolean, default=False)
    creation_date = Column(DateTime, default=datetime.now(timezone.utc), nullable=False)

# Pydantic model
class UserSchema(BaseModel):
    id: int
    username: str
    email: EmailStr
    verified_email: bool
    creation_date: datetime

    class Config:
        from_attributes = True