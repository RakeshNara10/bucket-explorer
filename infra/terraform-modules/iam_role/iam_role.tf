# provider "aws" {
#   region = var.aws_region
# }
locals {
  role_name        = var.role_name == "" ? null : var.role_name
  role_name_prefix = var.role_name_prefix == "" ? null : var.role_name_prefix
}
resource "aws_iam_role" "role" {
  assume_role_policy    = jsonencode(var.assume_role_policy)
  description           = var.role_description
  force_detach_policies = var.force_detach_policies
  name                  = local.role_name
  name_prefix           = local.role_name_prefix
  path                  = var.role_path
  permissions_boundary  = var.permissions_boundary
  max_session_duration  = var.max_session_duration
  tags                  = var.tags
}
resource "aws_iam_role_policy" "inline_policy" {
  count  = length(var.inline_policy)
  name   = lookup(var.inline_policy[count.index], "name", "")
  policy = var.inline_policy[count.index].policy
  role   = aws_iam_role.role.id
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.role.id
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_instance_profile" "iam_role_instance_profile" {
  count = var.instance_profile_arn_create == 0 ? 0 : 1
  name        = var.instance_profile_name == "" ? var.role_name : var.instance_profile_name
  role        = aws_iam_role.role.name
  name_prefix = var.instance_profile_name_prefix
  path        = var.instance_profile_path
  tags        = var.instance_profile_tags
}
