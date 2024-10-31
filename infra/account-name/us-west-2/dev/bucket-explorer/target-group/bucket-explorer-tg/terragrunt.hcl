terraform {
  source = "../../../../../../terraform-modules/target_group_complete"
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


  vpc_id = local.environment_vars.locals.vpc_id
}

dependency "instance" {
  config_path                             = "../../ec2/bucket-explorer"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    id = "bucket-explorer-id"
  }
}
include {
  path = find_in_parent_folders()
}

inputs = {
  deregistration_delay          = "300"
  load_balancing_algorithm_type = "round_robin"
  name                          = "${local.service_name}-tg"
  port                          = 8080
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  target_type                   = "instance"
  vpc_id                        = "${local.vpc_id}"

  health_check = {
    enabled             = true
    healthy_threshold   = 5
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "8080"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  stickiness = {
    cookie_duration = 86400
    enabled         = false
    type            = "lb_cookie"
  }
  target_group_attachments = [{
    target_id = dependency.instance.outputs.id
    port      = 8080
  }]
  tags = merge(
    {
      "Name" = "${local.service_name}-tg"
    },
    local.common_tags
  )
}