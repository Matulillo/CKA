
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

# Network variables 
variable "vpc_create" {
  default     = false
  description = "Enable VPC creation"

}

variable "cidr_block" {
  description = "CIDR IP block VPC"
  default     = "10.0.0.0/16"
}

## subnet attributes 
variable "subnet_map" {
  type = map(object({
    sub_cidr = string
    zone     = string
  }))
  default = {}
}

