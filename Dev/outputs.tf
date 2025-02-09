output "ec2_instances" {
  value       = [for i in module.demo-instance : i["instance"]]
  description = "Name and public IPs of the instances deployed"
}

