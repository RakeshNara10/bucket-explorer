output "arn" {
  description = "ARN of the listener (matches id)"
  value       = try(aws_lb_listener.listener.arn, null)
}
output "id" {
  description = "ARN of the listener (matches arn)."
  value       = try(aws_lb_listener.listener.id, null)
}
############# rule outputs
output "rule_id" {
  description = "The ARN of the rule (matches arn)"
  value       = try(aws_lb_listener_rule.rule[*].id, null)
}
output "rule_arn" {
  description = "The ARN of the rule (matches id)"
  value       = try(aws_lb_listener_rule.rule[*].arn, null)
}