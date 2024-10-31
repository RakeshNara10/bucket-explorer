terraform {
  source = "../../../../../../terraform-modules/aws_lb"
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
  ######### resource specific dependencies
  pub_sub_a_id = local.environment_vars.locals.pub_sub_a_id
  pub_sub_b_id = local.environment_vars.locals.pub_sub_b_id

}

dependency "sg" {
  config_path                             = "../../security-group/bucket-explorer-lb"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    id = "bucket-explorer-sg-id"
  }
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name                             = "${local.service_name}-lb"
  desync_mitigation_mode           = "defensive"
  drop_invalid_header_fields       = false
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  enable_http2                     = true
  enable_waf_fail_open             = false
  idle_timeout                     = 60
  internal                         = false
  ip_address_type                  = "ipv4"
  load_balancer_type               = "application"

  security_groups = [
    dependency.sg.outputs.id,
  ]

  subnet_mapping = [{
    subnet_id = "${local.pub_sub_a_id}"
    },
    {
      subnet_id = "${local.pub_sub_b_id}"
  }]

  access_logs = {
    bucket  = ""
    enabled = false
  }

  tags = merge(
    {
      "Name" = "${local.service_name}-lb"
    },
    local.common_tags
  )
}