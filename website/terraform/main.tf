provider "aws" {
  region = "us-east-2"
}

locals {
  webserver_port = 8080
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow inbound web traffic"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0c94855ba95b798c7" # Amazon Linux 2 LTS AMI - make sure this is the latest for your region
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_web.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user

              # Download your project's files to the instance
              sudo yum install -y git
              git clone https://github.com/melovagabond/Daevon_Challenge.git
              cd Daevon_Challenge

              # Build and run the Docker container
              sudo docker build -t webpage .
              sudo docker run -d -p 8080:80 --name webpage-container webpage
              mkdir /certs
              openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /certs/server.key -out /certs/server.crt -subj "/C=US/ST=Pennsylvania/L=Philadelphia/O=Daevonlab/OU=R&D/CN=localhost"
              EOF

  tags = {
    Name = "webpage-instance"
  }
}
