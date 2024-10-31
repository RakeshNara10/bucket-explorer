locals {
  app_name       = "bucket-explorer"
  criticality    = "Mission Critical"
  contact        = "some-email@testing.com"
  account_number = get_aws_account_id()

  common_tags = {
    Owner = "Rakesh"
  }
}