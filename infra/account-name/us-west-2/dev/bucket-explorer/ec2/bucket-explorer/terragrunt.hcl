terraform {
  source = "../../../../../../terraform-modules/aws_instance"
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

  pvt_sub_id = local.environment_vars.locals.pvt_sub_id
  key_name   = local.environment_vars.locals.key_name
  ami_id     = local.environment_vars.locals.ami_id
}

include {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path                             = "../../security-group/bucket-explorer-ec2"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    id = "bucket-explorer-sg-id"
  }
}


dependency "iam" {
  config_path                             = "../../iam/bucket-explorer-role"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    instance_profile_id = "bucket-explorer-role"
  }
}

inputs = {
  name                                 = "bucket-explorer"
  ami                                  = local.ami_id
  user_data_replace_on_change          = true
  associate_public_ip_address          = false
  disable_api_termination              = false
  ebs_optimized                        = true
  get_password_data                    = false
  hibernation                          = false
  iam_instance_profile                 = dependency.iam.outputs.instance_profile_id
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.medium"
  key_name                             = local.key_name
  subnet_id                            = local.pvt_sub_id
  template_file_path                   = "${get_terragrunt_dir()}/user_data.sh"
  vpc_security_group_ids = [
    dependency.sg.outputs.id
  ]

  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  credit_specification = {
    cpu_credits = "unlimited"
  }

  metadata_options = {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }

  root_block_device = [{
    delete_on_termination = true
    encrypted             = true
    volume_size           = 16
    volume_type           = "gp2"
  }]

  tags = merge(
    {
      "Name" = "${local.service_name}"
    },
    local.common_tags
  )
}
