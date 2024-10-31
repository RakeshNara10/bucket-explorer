# variable "aws_region" {
#   description = "Region in which to deploy the aws resources."
#   type        = string
#   default     = "us-west-2"
# }
variable "connection_termination" {
  description = "Whether to terminate connections at the end of the deregistration timeout on Network Load Balancers."
  type        = bool
  default     = false
}
variable "deregistration_delay" {
  description = "Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is `0-3600` seconds."
  type        = string
  default     = "300"
}
variable "lambda_multi_value_headers_enabled" {
  description = "Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when `target_type` is `lambda`."
  type        = bool
  default     = false
}
variable "load_balancing_algorithm_type" {
  description = "Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when `target_type` is lambda."
  type        = string
  default     = null
}
variable "name" {
  description = "(Optional, Forces new resource) Name of the target group. If omitted, Terraform will assign a random, unique name."
  type        = string
  default     = null
}
variable "use_name_prefix" {
  description = "Set this to true to append unique identifier to the name."
  type        = bool
  default     = false
}
variable "port" {
  description = " (May be required, Forces new resource) Port on which targets receive traffic, unless overridden when registering a specific target. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`."
  type        = number
  default     = null
}
variable "preserve_client_ip" {
  description = "Whether client IP preservation is enabled."
  type        = string
  default     = null
}
variable "protocol_version" {
  description = "Only applicable when `protocol` is `HTTP` or `HTTPS`. The protocol version. Specify GRPC to send requests to targets using gRPC. Specify HTTP2 to send requests to targets using HTTP/2."
  type        = string
  default     = null
}
variable "protocol" {
  description = "(May be required, Forces new resource) Protocol to use for routing traffic to the targets. Should be one of `GENEVE`, `HTTP`, `HTTPS, TCP`, `TCP_UDP`, `TLS`, or `UDP`. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`."
  type        = string
  default     = null
}
variable "proxy_protocol_v2" {
  description = "Whether to enable support for proxy protocol v2 on Network Load Balancers."
  type        = bool
  default     = false
}
variable "slow_start" {
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests. The range is `30-900` seconds or 0 to disable."
  type        = number
  default     = 0
}
variable "tags" {
  description = "Map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "target_type" {
  description = "(May be required, Forces new resource) Type of target that you must specify when registering targets with this target group."
  type        = string
  default     = "instance"
}
variable "vpc_id" {
  description = " (Optional, Forces new resource) Identifier of the VPC in which to create the target group. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`."
  type        = string
  default     = null
}
variable "health_check" {
  description = " (Optional, Maximum of 1) Health Check configuration block. "
  type        = map(any)
  default     = {}
}
variable "stickiness" {
  description = " (Optional, Maximum of 1) Stickiness configuration block."
  type        = map(any)
  default     = {}
}
variable "target_group_attachments" {
  description = "List of maps of target group attachment values."
  type        = list(any)
  default     = []
}
