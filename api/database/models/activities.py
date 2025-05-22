from pydantic import BaseModel
from sqlalchemy import Column, Integer, String, Text, DateTime, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime, timezone

Base = declarative_base()

# SQLAlchemy Model
class Activity(Base):
    __tablename__ = 'activities'

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255), nullable=False)
    description = Column(Text, nullable=True)
    timestamp = Column(DateTime, default=datetime.now(timezone.utc), nullable=False)
    user_username = Column(String, ForeignKey('users.username'), nullable=False)

# Pydantic Model
class ActivityCreate(BaseModel):
    name: str
    description: str | None = None
    timestamp: datetime | None = None

class ActivityResponse(BaseModel):
    id: int
    name: str
    description: str | None
    timestamp: datetime

    class Config:
        from_attributes = True