from fastapi import FastAPI, HTTPException, Query
from app.logic import create_ticket, close_ticket

app = FastAPI()

@app.post("/entry")
def entry(plate: str = Query(...), parkingLot: int = Query(...)):
    ticket_id = create_ticket(plate, parkingLot)
    return {"ticket_id": ticket_id}

@app.post("/exit")
def exit(ticketId: str = Query(...)):
    result = close_ticket(ticketId)
    if not result:
        raise HTTPException(status_code=404, detail="Ticket not found")
    return result