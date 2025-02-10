
output "vpc_id" {
  value       = var.vpc_create ? aws_vpc.this[0].id : null
  description = "VPC Id"
}

output "vpc_cidr_block" {
  value       = aws_vpc.this[*].cidr_block
  description = "VPC CIDR block"
}

output "subnet_ids" {
  value       = { for s in aws_subnet.this : trimprefix(s.tags["Name"], "Subnet-") => s.id }
  description = "Subnet ids"
}


