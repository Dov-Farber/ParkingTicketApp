provider "aws" {
  region = "us-east-1"  # or your preferred region
}

resource "aws_security_group" "parking_sg" {
  name        = "parking_sg"
  description = "Security group for ParkingTicketApp"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "parking_app" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.parking_sg.id]
  key_name               = "parking-key"  # 👈 Ensure this matches your AWS EC2 Key Pair

  user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install -y git python3 pip

  cd /home/bear
  git clone https://github.com/Dov-Farber/ParkingTicketApp.git
  cd parking_ticket_python
  pip install -r requirements.txt
  chmod +x start.sh
  ./start.sh
  EOF

  tags = {
    Name = "ParkingTicketApp"
  }
}