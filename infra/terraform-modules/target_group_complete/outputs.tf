output "arn_suffix" {
  description = "ARN suffix for use with CloudWatch Metrics."
  value       = try(aws_lb_target_group.tg.arn_suffix, null)
}
output "arn" {
  description = "ARN of the Target Group (matches id)."
  value       = try(aws_lb_target_group.tg.arn, null)
}
output "id" {
  description = "ID of the Target Group (matches arn)."
  value       = try(aws_lb_target_group.tg.id, null)
}
output "name" {
  description = "Name of the Target Group."
  value       = try(aws_lb_target_group.tg.name, null)
}