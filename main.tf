resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name
vpc_security_group_ids = [aws_security_group.main.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo docker pull lielcohen2/myapp:latest
              sudo docker run -d -p 5000:5000 lielcohen2/myapp:latest
              EOF

  tags = {
    Name = "webserver"
  }
}

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

resource "aws_security_group" "main" {
  name        = "main-sg"
  description = "Security group for main"
  dynamic "ingress" {
    for_each = var.in_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 signifies all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}



 
