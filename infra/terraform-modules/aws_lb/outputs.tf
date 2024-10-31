output "id" {
  description = "The ARN of the load balancer."
  value       = try(aws_lb.lb.id, null)
}
output "arn" {
  description = "The ARN of the load balancer."
  value       = try(aws_lb.lb.arn, null)
}
output "arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value       = try(aws_lb.lb.arn_suffix, null)
}
output "dns_name" {
  description = "The DNS name of the load balancer."
  value       = try(aws_lb.lb.dns_name, null)
}
output "zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = try(aws_lb.lb.zone_id, null)
}
output "subnet_mapping_outpost_id" {
  description = "ID of the Outpost containing the load balancer."
  value       = aws_lb.lb.subnet_mapping.*.outpost_id
}