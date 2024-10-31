# variable "aws_region" {
#   description = "Region in which you want to deploy resources."
#   type        = string
#   default     = "us-west-2"
# }
variable "name" {
  description = "Name of security group - not required if create_group is false"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = false
}
variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}
variable "revoke_rules_on_delete" {
  description = "Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. Enable for EMR."
  type        = bool
  default     = false
}
variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}
variable "ingress" {
  description = "List of ingress rule blocks."
  type        = list(any)
  default     = null
}
variable "egress" {
  description = "List of egress rule blocks"
  type        = list(any)
  default     = null
}
variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}
variable "create_timeout" {
  description = "Time to wait for a security group to be created"
  type        = string
  default     = null
}
variable "delete_timeout" {
  description = "Time to wait for a security group to be deleted"
  type        = string
  default     = null
}