locals {
  in_ports = [80, 443, 22, 8080, 8881]
}

resource "aws_instance" "webserver" {
  count         = 3
  ami           = "ami-080e1f13689e07408"
  instance_type = var.ins_type
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "webserver${count.index + 1}"
  }
  user_data = <<-EOF
#!/bin/bash
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
echo "Pulling and running Docker container..."
sudo docker pull lielcohen2/myapp:latest
sudo docker run -d -p 5000:5000 lielcohen2/myapp:latest
EOF
}


resource "aws_vpc" "testvpc" {
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "test-sg" {
  name        = "test-sg"
  description = "security group fo testing"
  vpc_id      = aws_vpc.testvpc.id
  dynamic "ingress" {
    for_each = local.in_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

