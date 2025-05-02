from fastapi import FastAPI
from fastapi.responses import JSONResponse, RedirectResponse
from swagger_client.rest import ApiException
from swagger_client import AthletesApi, Configuration, ApiClient, ActivitiesApi
from models import AthleteResponse
from pprint import pprint
from fastapi import Depends, HTTPException
from dotenv import load_dotenv
import os
from fastapi.security import OAuth2, OAuth2AuthorizationCodeBearer
from fastapi.openapi.models import OAuthFlows as OAuthFlowsModel
from fastapi.openapi.models import OAuthFlowAuthorizationCode
from typing import Annotated
from datetime import datetime, timedelta, timezone
from fastapi.encoders import jsonable_encoder
from sqlalchemy.orm import Session
from database.connection import engine, get_db
from database.models.activities import Base
from database.models.activities import Activity, ActivityCreate, ActivityResponse
from fastapi.middleware.cors import CORSMiddleware

# Load environment variables from .env file
load_dotenv()
app = FastAPI()
# Add this after initializing the FastAPI app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://127.0.0.1:3000"],  # Allow localhost origins
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],  # Allow all headers
)

# Create all tables if they do not exist
Base.metadata.create_all(bind=engine)

# Retrieve Strava client ID and secret from environment variables
strava_client_id = os.getenv("strava_client_id")
strava_client_secret = os.getenv("strava_client_secret")

if not strava_client_id or not strava_client_secret:
    raise RuntimeError("Missing Strava client ID or secret in environment variables.")

# Configure OAuth2 access token for authorization: strava_oauth
configuration = Configuration()
configuration.access_token = ""
configuration.logger_file = "strava.log"
configuration.debug = True

oauth2_scheme = OAuth2AuthorizationCodeBearer(authorizationUrl="token", tokenUrl="token")

strava_authorization_url="https://www.strava.com/oauth/authorize"
strava_token_url="https://www.strava.com/oauth/token"
strava_redirect_uri="http://localhost:8000/callback"
strava_api_url="https://www.strava.com/api/v3"

# Define OAuth2 flow for Strava
strava_oauth_flow = OAuthFlowAuthorizationCode(
    authorizationUrl=f"{strava_authorization_url}?client_id={strava_client_id}&redirect_uri={strava_redirect_uri}&response_type=code&scope=read,activity:read_all",
    tokenUrl=strava_token_url
)

strava_oauth2_scheme = OAuth2(flows=OAuthFlowsModel(authorizationCode=strava_oauth_flow))


@app.get("/")
def read_root():
    return {"message": "Hello, World!"}

@app.get("/athlete", response_model=AthleteResponse)
def get_authenticated_athlete():
    api_client = ApiClient(configuration) 
    print("Access token:", configuration.access_token)
    api_instance = AthletesApi(api_client) 
    # api_instance.api_client.configuration.access_token = configuration.access_token
    try:
        # Get Authenticated Athlete
        api_response = api_instance.get_logged_in_athlete()
        pprint(api_response)
        # Serialize the response to handle datetime objects
        serialized_response = jsonable_encoder(api_response.to_dict())
        return JSONResponse(content=serialized_response)
    except ApiException as e:
        return JSONResponse(content={"error": f"Exception when calling AthletesApi->getLoggedInAthlete: {e}"}, status_code=500)

@app.post("/futute_activity")
def create_future_activity():
    """Create a future activity."""

    api_client = ApiClient(configuration)
    api_instance = ActivitiesApi(api_client)
    
    api_instance.create_activity(
        name="Morning Swim",
        type="Swim",
        sport_type="Swim",
        start_date_local=(datetime.now() + timedelta(hours=12)).isoformat(),
        elapsed_time=3600,
        description="TBD",
        distance=1000,
        trainer=False,
        commute=False,
    )

    return {"activity": "Future activity created successfully"}

@app.get("/callback")
def strava_callback(code: str, state: str, scope: str):
    """Handle the OAuth2 callback from Strava."""
    import requests

    print(f"Received code: {code}")
    print(f"Received state: {state}")
    print(f"Received scope: {scope}")

    # Exchange the authorization code for an access token
    response = requests.post(
        strava_token_url,
        data={
            "client_id": strava_client_id,
            "client_secret": strava_client_secret,
            "code": code,
            "grant_type": "authorization_code",
        },
    )

    if response.status_code != 200:
        raise HTTPException(
            status_code=response.status_code,
            detail=f"Failed to fetch access token: {response.json()}"
        )

    token_data = response.json()
    configuration.access_token = token_data.get("access_token")
    print(f"Access token: {configuration.access_token}")

    return {"message": "Authentication successful", "token_data": token_data}

@app.get("/authorize")
def authorize():
    """Redirect to Strava for OAuth2 authentication."""
    # https://www.strava.com/api/v3/oauth/authorize?response_type=code&client_id=asdf&redirect_uri=https%3A%2F%2Fdevelopers.strava.com%2Foauth2-redirect%2F&scope=read%20read_all%20profile%3Aread_all%20activity%3Aread%20activity%3Aread_all&state=asdfasdf%3D%3D

    return RedirectResponse(
        url=f"{strava_authorization_url}?client_id={strava_client_id}&redirect_uri={strava_redirect_uri}&response_type=code&scope=read"
    )


####################### Supporting the Web Client before fully implementing Strava API #######################
@app.post("/activity")
def create_activity(activity: ActivityCreate, db: Session = Depends(get_db)) -> ActivityResponse:
    """Create a new activity."""
    new_activity = Activity(
        name=activity.name,
        description=activity.description,
        timestamp=activity.timestamp or datetime.now(timezone.utc),
    )
    db.add(new_activity)
    db.commit()
    db.refresh(new_activity)
    return ActivityResponse.model_validate(new_activity)