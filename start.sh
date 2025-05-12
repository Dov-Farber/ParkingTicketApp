#!/bin/bash
set -e

cd /home/bear/parking_ticket_python
pip install -r requirements.txt

uvicorn app.main:app --host 0.0.0.0 --port 3000