locals {
  service_name = "bucket-explorer"
  service_tags = {
    "service_name" = local.service_name
  }
}