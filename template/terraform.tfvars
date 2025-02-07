#################
# Input variables
#################

#######################
# tags 
#######################
name    = "Demo"
project = "TF"

#######################
# vpc
####################### 
vpc_create     = true
vpc_cidr_block = "10.10.0.0/16"

########################
# subnets inputs example
########################

subnet_map = {
  "main" = {
    sub_cidr = "10.10.10.0/24"
    zone     = "eu-south-2a"
  }
}

#########################
# ec2-instances inputs example
#########################

instance_map = {
  "instance1" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "main"
    private_ip    = "10.10.10.10"
    eip           = true
    key_name      = null
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
    desc        = "Test SG rule1"
  },
  {
    from_port   = 9001
    to_port     = 9001
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Test SG rule1"
  },
  {
    from_port   = 9002
    to_port     = 9002
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Test SG rule2"
  }
]










