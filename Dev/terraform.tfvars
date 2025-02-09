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
  "master-1" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "private"
    private_ip    = "10.10.10.10"
    eip           = true
    key_name      = "carlos"
    role          = "master"
  }
  /*
  "worker-1" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "private"
    private_ip    = "10.10.10.11"
    eip           = true
    key_name      = "carlos"
    role          = "worker"
  }
   "worker-2" = {
    ami           = "amazon"
    instance_type = "t3.micro"
    subnet        = "private"
    private_ip    = "10.10.10.12"
    eip           = true
    key_name      = "carlos"
    role          = "worker"
  }
  */
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
  },
  {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Kubernetes API server"
  },
  {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Kubelet API"
  },
  {
    from_port   = 10255
    to_port     = 10255
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Kubelet read-only API"
  },
  {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Kubelet API"
  },
  {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "etcd server client AP"
  },
  {
    from_port   = 6783
    to_port     = 6784
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    desc        = "Flannel VXLAN"
  }
]










