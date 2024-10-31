# provider "aws" {
#   region = var.aws_region
# }
locals {
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
}
resource "aws_security_group" "sg" {
  name                   = local.name
  name_prefix            = local.name_prefix
  description            = var.description
  revoke_rules_on_delete = var.revoke_rules_on_delete
  vpc_id                 = var.vpc_id
  ingress                = var.ingress
  egress                 = var.egress
  tags                   = var.tags

  timeouts {
    create = var.create_timeout
    delete = var.delete_timeout
  }
}