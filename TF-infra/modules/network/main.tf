
locals {
  environment = basename(path.cwd)
  common_tags = {
    Project = var.project
    Env     = local.environment
  }
}
################################################################################
# VPC
################################################################################
resource "aws_vpc" "this" {
  count      = var.vpc_create ? 1 : 0
  cidr_block = var.cidr_block
  tags = {
    Name    = "VPC-${var.name}-${local.environment}"
    Env     = local.environment
    Project = var.project
  }
}

################################################################################
# Subnets
################################################################################
resource "aws_subnet" "this" {
  for_each          = var.subnet_map
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = each.value.sub_cidr
  availability_zone = each.value.zone
  #map_public_ip_on_launch = true
  tags = merge(
    local.common_tags,
    {
      "Name" = "Subnet-${each.key}-${local.environment}"
    }
  )
}

#################################################################################
# Routing resources
##################################################################################
resource "aws_internet_gateway" "gw" {
  count  = var.vpc_create ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = {
    Name    = "IGW-${var.name}-${local.environment}"
    Env     = local.environment
    Project = var.project
  }
}

# route table
resource "aws_route_table" "public" {
  count  = var.vpc_create ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    local.common_tags,
    {
      "Name" = "Route-${local.environment}"
    }
  )
}

# route entry
resource "aws_route" "public_internet_gateway" {
  count                  = var.vpc_create ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[0].id
}

# route table associations 
resource "aws_route_table_association" "public" {
  for_each       = var.subnet_map
  subnet_id      = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.public[0].id
}
