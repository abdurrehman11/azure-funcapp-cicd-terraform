import logging

import azure.functions as func
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

LOG = logging.getLogger(__name__)

fastapi_app = FastAPI()

@fastapi_app.get("/health", description="Function to check if the service is up.")
def health():
    return {"status": "ok"}


fastapi_app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app = func.AsgiFunctionApp(
    app=fastapi_app,
    http_auth_level=func.AuthLevel.ANONYMOUS
)
