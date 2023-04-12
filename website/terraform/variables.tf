variable "aws_region" {
  type        = string
  description = "AWS region where the resources will be created"
  default     = "us-east-2"
}

variable "availability_zone" {
  type        = string
  description = "The default availibility zone"
  default     = "us-east-2a"
}

variable "ami_id" {
  type        = string
  description = "The Amazon Machine Image (AMI) ID for the EC2 instance"
  default     = "ami-0a695f0d95cefc163"
}

variable "instance_type" {
  type        = string
  description = "The instance type of the EC2 instance"
  default     = "t2.micro"
}

variable "ami_owner" {
  type        = string
  description = "Owner of the AWS AMI"
  default     = "099720109477"

}

variable "host_os" {
  type    = string
  default = "linux"
}

variable "wan_ip" {
  type = string
}
