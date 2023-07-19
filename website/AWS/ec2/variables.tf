# AWS
variable "aws_region" {
  type        = string
  description = "AWS region where the resources will be created"
  default     = "us-east-2"
}

variable "ami_id" {
  type        = string
  description = "The Amazon Machine Image (AMI) ID for the EC2 instance"
  default     = "ami-0a695f0d95cefc163"
}

variable "ami_owner" {
  type        = string
  description = "Owner of the AWS AMI"
  default     = "099720109477"

}

variable "availability_zone" {
  type        = string
  description = "The default availibility zone"
  default     = "us-east-2a"
}

variable "instance_type" {
  type        = string
  description = "The instance type of the EC2 instance"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair for the EC2 instance"
  default     = "web-server"
}

variable "instance_name" {
  type        = string
  description = "The name for the EC2 instance"
  default     = "nginx-web-server"
}

# SSL Cert
variable "ssl_cert_path" {
  type        = string
  description = "Path to the SSL certificate"
  default     = "./certs/server.crt"
}

variable "ssl_key_path" {
  type        = string
  description = "Path to the SSL private key"
  default     = "./certs/server.key"
}
