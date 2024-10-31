# variable "aws_region" {
#   description = "Region in which to deploy the resources."
#   type        = string
#   default     = "us-west-2"
# }
variable "load_balancer_arn" {
  description = "(Required, Forces New Resource) ARN of the load balancer."
  type        = string
}
variable "alpn_policy" {
  description = "Name of the Application-Layer Protocol Negotiation (ALPN) policy. Can be set if protocol is `TLS`. Valid values are `HTTP1Only`, `HTTP2Only`, `HTTP2Optional`, `HTTP2Preferred`, and `None`."
  type        = string
  default     = null
}
variable "certificate_arn" {
  description = "ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS."
  type        = string
  default     = null
}
variable "port" {
  description = "Port on which the load balancer is listening. Not valid for `Gateway Load Balancers`."
  type        = number
  default     = null
}
variable "protocol" {
  description = "Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are `HTTP` and `HTTPS`, with a default of `HTTP`. For Network Load Balancers, valid values are `TCP`, `TLS`, `UDP`, and `TCP_UDP`. Not valid to use `UDP` or `TCP_UDP` if dual-stack mode is enabled. Not valid for Gateway Load Balancers."
  type        = string
  default     = null
}
variable "ssl_policy" {
  description = "Name of the SSL Policy for the listener. Required if protocol is `HTTPS` or `TLS`."
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "default_action" {
  description = "List of default_action maps."
  type        = list(any)
}
############### aws_lb_certificate variables
variable "additional_certificates" {
  description = "List of additional certificate arn's to attach to the lister."
  type        = list(string)
  default     = []
}
############### aws_lb_listener_rule variables
# variable "priority" {
#   description = " (Optional) The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority."
#   type        = list(number)
#   default     = null
# }
# variable "action" {
#   description = "(Required) An Action block.This will be list of lists"
#   type        = any
#   default     = []
# }
# variable "condition" {
#   description = "One or more condition blocks can be set per rule. Most condition types can only be specified once per rule except for http-header and query-string which can be specified multiple times. This is list of lists"
#   type        = any
#   default     = []
# }
variable "rules" {
  description = "List of rules to attach to the listener. This is a list of map containing `priority`(number, optional), `action`() and `condition`."
  type        = list(any)
  default     = []
}