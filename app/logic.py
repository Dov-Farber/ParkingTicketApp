import time
from uuid import uuid4

# In-memory ticket store
tickets = {}

def create_ticket(plate, parking_lot):
    ticket_id = str(uuid4())
    tickets[ticket_id] = {
        "plate": plate,
        "parking_lot": parking_lot,
        "entry_time": time.time()
    }
    return ticket_id

def close_ticket(ticket_id):
    ticket = tickets.pop(ticket_id, None)
    if not ticket:
        return None

    exit_time = time.time()
    duration = exit_time - ticket["entry_time"]
    minutes = duration / 60
    rounded_quarters = int((minutes + 14) // 15)
    total_charge = rounded_quarters * (10 / 4)

    return {
        "plate": ticket["plate"],
        "parking_lot": ticket["parking_lot"],
        "duration_minutes": round(minutes, 2),
        "charge": round(total_charge, 2)
    }