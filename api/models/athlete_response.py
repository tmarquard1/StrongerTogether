from pydantic import BaseModel


class AthleteResponse(BaseModel):
    id: int
    username: str
    firstname: str
    lastname: str
    city: str
    state: str
    country: str
    sex: str
    premium: bool
    summit: bool
    created_at: str
    updated_at: str