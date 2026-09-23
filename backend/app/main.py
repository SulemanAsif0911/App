"""FastAPI skeleton for Cyber Hayat PK. Not required for the offline APK."""
from fastapi import FastAPI

app = FastAPI(title="Cyber Hayat PK API", version="1.0.0")


@app.get("/api/v1/health")
def health():
    return {"ok": True}


@app.post("/api/v1/auth")
def auth():
    return {"accepted": False, "reason": "Configure identity before issuing tokens"}


@app.get("/api/v1/users")
def users():
    return {"items": []}


@app.get("/api/v1/cases")
def cases():
    return {"items": []}


@app.get("/api/v1/cases/{case_id}")
def case_one(case_id: str):
    return {"id": case_id, "status": "unknown"}


@app.get("/api/v1/evidence")
def evidence():
    return {"items": []}


@app.get("/api/v1/resources")
def resources():
    return {"version": "2026.09.01", "items": []}


@app.get("/api/v1/helplines")
def helplines():
    return {"version": "2026.09.01", "items": []}


@app.get("/api/v1/legal")
def legal():
    return {"version": "2026.09.01", "items": []}


@app.get("/api/v1/knowledge")
def knowledge():
    return {"version": "2026.09.01"}


@app.post("/api/v1/chat")
def chat():
    return {"accepted": False, "reason": "Cloud chat is opt-in and not enabled"}


@app.get("/api/v1/complaints")
def complaints():
    return {"items": []}


@app.get("/api/v1/stories")
def stories():
    return {"items": []}


@app.get("/api/v1/ambassadors")
def ambassadors():
    return {"items": []}


@app.post("/api/v1/sync")
def sync():
    return {"accepted": False, "reason": "Configure storage before accepting sync"}
