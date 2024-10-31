terraform {
  source = "../../../../../../terraform-modules/aws_security_group"
}

locals {
  ##### these below things will be common for all the resources
  common_vars      = read_terragrunt_config(find_in_parent_folders("commons.hcl"))
  account_vars     = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  service_vars     = read_terragrunt_config(find_in_parent_folders("service.hcl"))

  region       = local.region_vars.locals.region
  service_name = local.service_vars.locals.service_name

  common_tags = merge(
    local.common_vars.locals.common_tags,
    local.account_vars.locals.account_tags,
    local.region_vars.locals.region_tags,
    local.environment_vars.locals.environment_tags,
    local.service_vars.locals.service_tags
  )
  ###### these are specific to resource
  vpc_id   = local.environment_vars.locals.vpc_id
  vpc_cidr = local.environment_vars.locals.vpc_cidr

}

include {
  path = find_in_parent_folders()
}
inputs = {
  description = "${local.service_name} service sg"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "" // your ip/internet
      ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    }
  ]
  name   = "${local.service_name}-lb-sg"
  vpc_id = "${local.vpc_id}"
  tags = merge(
    {
      "Name" = "${local.service_name}-lb-sg"
    },
    local.common_tags
  )
}
