
## EC2 variables

## Tags
variable "name" {
  description = "name to pass to Name tag"
  default     = "MyName"
}

variable "project" {
  description = "Owner of Application"
  default     = "MyProject"
}

# Regions and zones
variable "aws_region" {
  description = "AWS region"
  default     = "eu-south-2"
}

## ec2 attibutes 
variable "vpc_id" {
  default = null
}


variable "subnet_id" {
  default = null
}

variable "ami" {
  type    = string
  default = null
}

variable "eip" {
  description = "Enable EIP to a certain instance"
  type        = bool
  default     = false
}

variable "private_ip" {
  type    = string
  default = null

}

variable "instance_type" {
  type    = string
  default = null
}

variable "sg_id" {
  type        = string
  description = "SG id to attach to the EC2"
  default     = null
}

variable "custom_sg" {
  type    = string
  default = null
}

variable "key_name" {
  type    = string
  default = null
}