provider "aws" {
  region = "us-west-2"  # or your preferred region
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Make sure this key exists
}

resource "aws_security_group" "parking_sg" {
  name        = "parking-sg"
  description = "Allow SSH and app traffic"

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
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.parking_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git python3 pip

              cd /home/ec2-user
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