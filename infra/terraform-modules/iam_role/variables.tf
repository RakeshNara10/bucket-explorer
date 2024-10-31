variable "aws_region" {
  type        = string
  description = "Name of the aws region"
  default     = "us-west-2"
}
########## iam_role_variables
variable "role_description" {
  type        = string
  description = "The description of the role."
  default     = ""
}
variable "force_detach_policies" {
  type        = bool
  description = "value"
  default     = false
}
variable "max_session_duration" {
  type        = number
  description = " The maximum session duration (in seconds) that you want to set for the specified role."
  default     = 3600
}
variable "role_name" {
  type        = string
  description = "The name of the IAM Role."
  default     = ""
  validation {
    condition     = length(var.role_name) <= 64
    error_message = "The role_name, when informed, cannot be longer than 64 characters."
  }
}
variable "role_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Ignored when role_name is informed."
  default     = ""
  type        = string

  validation {
    condition     = length(var.role_name_prefix) <= 32
    error_message = "The role_prefix cannot be longer than 32 characters."
  }
}
variable "role_path" {
  type        = string
  description = "IAM role path."
  default     = "/"
}
variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}
variable "tags" {
  description = "A map of tags to add into all resources."
  default     = {}
  type        = map(string)
}
variable "assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role."
  type        = any
  default     = {}
  validation {
    condition     = length(var.assume_role_policy) <= 2048
    error_message = "The assume_role_policy cannot be longer than 2048 characters."
  }
}

######## iam_role_policy variables
variable "inline_policy" {
  description = "Configuration block defining an exclusive set of IAM inline policies associated with the IAM role."
  type = list(object({
    name   = string
    policy = any
  }))
  default = []
}
########## aws_iam_instance_profile variables

variable "instance_profile_arn_create" {
  type = number
  description = "If you don't want to create instance profile arn set this to 0"
  default = 1
}
variable "instance_profile_name" {
  type        = string
  description = "iam instance profile name- the name should be unique"
  default     = ""
}
variable "instance_profile_name_prefix" {
  type        = string
  description = "Creates a unique name beginning with the specified prefix"
  default     = null
}
variable "instance_profile_path" {
  type        = string
  description = "Path to the instance profile."
  default     = "/"
}
variable "instance_profile_tags" {
  type        = map(any)
  description = "Map of tags"
  default     = {}
}

variable "policy_arns" {
  description = "List of policy ARNs to attach in the role."
  default     = []
  type        = list(string)
}
