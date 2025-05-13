#!/bin/bash
set -e

# Install Python and pip3
echo "Installing Python and pip3..."
yum update -y
yum install -y python3-pip


echo "Installing dependencies..."
pip3 install -r requirements.txt

cd /home/ec2-user/parking_ticket_python
# Start the FastAPI application
echo "Starting the application..."
uvicorn app.main:app --host 0.0.0.0 --port 3000