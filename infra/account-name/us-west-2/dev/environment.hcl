locals {
  environment     = "dev"
  vpc_id          = ""
  vpc_cidr        = "10.151.0.0/16"
  pub_sub_a_id    = ""
  pub_sub_b_id    = ""
  pvt_sub_id      = ""
  certificate_arn = ""
  key_name        = ""
  ami_id          = ""
  environment_tags = {
    "Environment" = local.environment
  }
}


