# variable "aws_region" {
#     description = "Region in which to deploy the aws resources."
#     type = string
#     default = "us-west-2"  
# }
variable "name" {
  description = "The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with `tf-lb`."
  type        = string
  default     = null
}
variable "use_name_prefix" {
  description = "Set this to true to create unique name begining with `name`."
  type        = bool
  default     = false
}
variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
  default     = false
}
variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are `application`, `gateway`, or `network`."
  type        = string
  default     = "application"
}
variable "security_groups" {
  description = "A list of security group IDs to assign to the LB. Only valid for Load Balancers of type `application`."
  type        = list(string)
  default     = null
}
variable "drop_invalid_header_fields" {
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false).Only valid for Load Balancers of type `application`."
  type        = bool
  default     = false
}
variable "subnets" {
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type `network`. Changing this value for load balancers of type `network` will force a recreation of the resource."
  type        = list(string)
  default     = null
}
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type `application`."
  type        = number
  default     = null
}
variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  type        = bool
  default     = false
}
variable "enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a `network` load balancer feature."
  type        = bool
  default     = false
}
variable "enable_http2" {
  description = " Indicates whether HTTP/2 is enabled in `application` load balancers."
  type        = bool
  default     = true
}
variable "enable_waf_fail_open" {
  description = " Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF."
  type        = bool
  default     = false
}
variable "customer_owned_ipv4_pool" {
  description = "The ID of the customer owned ipv4 pool to use for this load balancer."
  type        = string
  default     = null
}
variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are `ipv4` and `dualstack`."
  type        = string
  default     = null
}
variable "desync_mitigation_mode" {
  description = "Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are `monitor`, `defensive`, `strictest`."
  type        = string
  default     = null
}
variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
variable "access_logs" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}
variable "subnet_mapping" {
  description = "A list of subnet mapping blocks describing subnets to attach to network load balancer."
  type        = list(map(string))
  default     = []
}
variable "timeouts" {
  description = "Timeouts block for the lb."
  type        = map(string)
  default     = {}
}
