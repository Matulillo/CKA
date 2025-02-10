
locals {
  environment = basename(path.cwd)
  common_tags = {
    Project = var.project
    Env     = local.environment
  }
}
################################################################################
# Security Group
################################################################################
resource "aws_security_group" "this" {
  name        = "SG-${var.name}-${local.environment}"
  vpc_id      = var.vpc_id
  description = "Security group for ${var.name}"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.desc
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = merge(
    local.common_tags,
    {
      "Name" = "SG-${var.name}-${local.environment}"
    }
  )
}
