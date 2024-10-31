terraform {
  source = "../../../../../../terraform-modules/listener_complete"
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

  certificate_arn = local.environment_vars.locals.certificate_arn
}

include {
  path = find_in_parent_folders()
}

dependency "lb" {
  config_path = "../../lb/bucket-explorer-lb"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    arn = "arn:aws:elasticloadbalancing:${local.region}:123456789:loadbalancer/app/bucket-explorer-lb-alb/ed5f1c693085de9c"
  }
}
dependency "tg" {
  config_path = "../../target-group/bucket-explorer-tg"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    arn = "arn:aws:elasticloadbalancing:${local.region}:123456789:targetgroup/bucket-explorer-tg/c4acbf6ac950680a"
  }
}

inputs = {
  certificate_arn   = local.certificate_arn
  load_balancer_arn = dependency.lb.outputs.arn
  port              = 443
  protocol          = "HTTPS"
  default_action = [{
    order            = 1
    target_group_arn = dependency.tg.outputs.arn
    type             = "forward"
  }]
  tags = merge(
    {
      "Name" = "${local.service_name}-listener"
    },
    local.common_tags
  )
}