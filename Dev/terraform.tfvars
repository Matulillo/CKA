#################
# Input variables
#################

#######################
# tags 
#######################
name    = "K8s"
project = "CKA"

#######################
# vpc
####################### 
vpc_create     = true
vpc_cidr_block = "10.10.0.0/16"

########################
# subnets inputs example
########################

subnet_map = {
  "private" = {
    sub_cidr = "10.10.10.0/24"
    zone     = "eu-south-2a"
  }
   "public" = {
    sub_cidr = "10.10.20.0/24"
    zone     = "eu-south-2b"
  }
}

#########################
# ec2-instances inputs example
#########################

instance_map = {
  "control-plane" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "private"
    private_ip    = "10.10.10.10"
    eip           = true
    key_name      = "carlos"
  }
  "worker-1" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "private"
    private_ip    = "10.10.10.11"
    eip           = true
    key_name      = "carlos"
  }
}

#########################
# Security group inputs example
#########################

sg_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Remote access SG rule1"
  }
]










