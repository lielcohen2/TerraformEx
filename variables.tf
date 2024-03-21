
variable "key_name" {
  description = "The name of the EC2 key pair"
  type        = string
  default     = "liel-key"
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
  default     = "ami-080e1f13689e07408"
}

variable "in_ports" {
  description = "List of ingress ports"
  type        = list(number)
  default     = [80, 443, 22, 8080, 8881, 5000]
}
