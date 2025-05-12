#!/bin/bash
set -e

# Install dependencies globally
pip3 install -r requirements.txt

cd /home/bear/parking_ticket_python
uvicorn app.main:app --host 0.0.0.0 --port 3000