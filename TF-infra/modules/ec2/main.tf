
locals {
  environment = basename(path.cwd)
  common_tags = {
    Project = var.project
    Env     = local.environment
  }
}

###############################################
# EC2
###############################################
resource "aws_instance" "instance" {
  ami             = var.ami == "amazon" ? data.aws_ami.latest_amazon.id : var.ami == "ubuntu" ? "ami-0e872aee57663ae2d" : "ami-0b510559869f69c67"
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  private_ip      = var.private_ip != null ? var.private_ip : null
  security_groups = [aws_security_group.this_default.id, var.custom_sg]
  user_data       = var.role !=null ? file("${path.module}/user_data_${var.role}.sh") : null
  key_name        = var.key_name
  tags = merge(
    local.common_tags,
    {
      "Name" = "Server-${var.name}-${local.environment}"
    }
  )
  depends_on = [aws_security_group.this_default]
  lifecycle {
    ignore_changes = all
  }
}

###############################################
# EIP
###############################################

resource "aws_eip" "this" {
  count      = var.eip ? 1 : 0
  instance   = aws_instance.instance.id
  domain     = "vpc"
  depends_on = [aws_instance.instance]
  lifecycle {
    ignore_changes = all
  }

}

###############################################
# Default security group 
###############################################
resource "aws_security_group" "this_default" {
  name = "SG-${var.name}-${local.environment}"
  #description = "SG test"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    local.common_tags,
    {
      "Name" = "SG-${var.name}-${local.environment}"
    }
  )
}

###############################################
# Data sources 
###############################################
# Data sources to fetch latest AMIs
data "aws_ami" "latest_amazon" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
/*
data "aws_ami" "latest_ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
*/

