#!/bin/bash
set -e

cd /home/ec2-user/ParkingTicketApp

# Install Python and pip3
echo "Installing Python and pip3..."
yum update -y
yum install -y python3-pip


echo "Installing dependencies..."
pip3 install -r requirements.txt

# Start the FastAPI application
echo "Starting the application..."
uvicorn app.main:app --host 0.0.0.0 --port 3000