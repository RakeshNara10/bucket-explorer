terraform {
  source = "../../../../../../terraform-modules/iam_role"
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
}

include {
  path = find_in_parent_folders()
}

inputs = {
  role_description      = "${local.service_name} service role"
  force_detach_policies = false
  max_session_duration  = 3600
  role_name             = "${local.service_name}-role"
  role_path             = "/"
  tags = merge(
    {
      "Name" = "${local.service_name}-role"
    },
    local.common_tags
  )
  assume_role_policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  }

  inline_policy = [{
    name = "${local.service_name}-role-policy"
    policy = jsonencode(
      {
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Effect" : "Allow",
            "Action" : [
              "s3:ListBucket",
              "s3:GetObject"
            ],
            "Resource" : [
              "arn:aws:s3:::test-bucket-rakesh11",
              "arn:aws:s3:::test-bucket-rakesh11/*"
            ]
          }
        ]
      }
    )
  }]

  policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"]

  instance_profile_name = "${local.service_name}-role"
  instance_profile_path = "/"
  instance_profile_tags = merge(
    {
      "Name" = "${local.service_name}-role"
    },
    local.common_tags
  )
}