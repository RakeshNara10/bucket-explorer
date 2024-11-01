output "id" {
  description = "The ID of the instance"
  value       = try(aws_instance.instance.id, null)
}
output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.instance.arn, null)
}
output "capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance"
  value       = try(aws_instance.instance.capacity_reservation_specification, null)
}
output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.instance.instance_state, null)
}
output "outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value       = try(aws_instance.instance.outpost_arn, null)
}
output "password_data" {
  description = "Base-64 encoded encrypted password data for the instance. Useful for getting the administrator password for instances running Microsoft Windows. This attribute is only exported if `get_password_data` is true"
  value       = try(aws_instance.instance.password_data, null)
}
output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = try(aws_instance.instance.primary_network_interface_id, null)
}
output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.instance.private_dns, null)
}
output "public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.instance.public_dns, null)
}
output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.instance.public_ip, null)
}
output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.instance.private_ip, null)
}