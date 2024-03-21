terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# provider "docker" {
#   host = "tcp://your-docker-host:2376"
#   tls_verify = true
#   ca_material = file("~/.docker/ca.pem")
#   cert_material = file("~/.docker/cert.pem")
#   key_material = file("~/.docker/key.pem")
# }
