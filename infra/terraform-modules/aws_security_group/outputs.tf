output "id" {
  description = "ID of the security group."
  value       = try(aws_security_group.sg.id, null)
}
output "arn" {
  description = "ARN of the security group."
  value       = try(aws_security_group.sg.arn, null)
}
output "owner_id" {
  description = "SG owner account id."
  value       = try(aws_security_group.sg.owner_id, null)
}