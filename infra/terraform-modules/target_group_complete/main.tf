# provider "aws" {
#   region = var.aws_region
# }
locals {
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
}

resource "aws_lb_target_group" "tg" {
  connection_termination             = var.connection_termination
  deregistration_delay               = var.deregistration_delay
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  name                               = local.name
  name_prefix                        = local.name_prefix
  port                               = var.port
  preserve_client_ip                 = var.preserve_client_ip
  protocol_version                   = var.protocol_version
  protocol                           = var.protocol
  proxy_protocol_v2                  = var.proxy_protocol_v2
  slow_start                         = var.slow_start
  tags                               = var.tags
  target_type                        = var.target_type
  vpc_id                             = var.vpc_id

  dynamic "health_check" {
    for_each = length(keys(var.health_check)) == 0 ? [] : [var.health_check]

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)

    }

  }

  dynamic "stickiness" {
    for_each = length(keys(var.stickiness)) == 0 ? [] : [var.stickiness]

    content {
      enabled         = lookup(stickiness.value, "enabled", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      type            = lookup(stickiness.value, "type", null)
    }

  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_lb_target_group_attachment" "tg_attch" {
  count = length(var.target_group_attachments)

  target_group_arn  = aws_lb_target_group.tg.arn
  target_id         = var.target_group_attachments[count.index].target_id
  port              = lookup(var.target_group_attachments[count.index], "port", null)
  availability_zone = lookup(var.target_group_attachments[count.index], "availability_zone", null)
}