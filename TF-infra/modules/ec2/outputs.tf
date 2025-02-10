
output "instance" {
  #value       = [ for i in aws_instance.instance[*] : trimprefix(i.tags["Name"], "Server-") +  i.public_ip ]
  value = { for i in aws_instance.instance[*] : i.tags["Name"] => i.public_ip }

  description = "Instances attributes"
}

