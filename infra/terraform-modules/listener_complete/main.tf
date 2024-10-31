# provider "aws" {
#   region = var.aws_region
# }
resource "aws_lb_listener" "listener" {
  load_balancer_arn = var.load_balancer_arn
  alpn_policy       = var.alpn_policy
  certificate_arn   = var.certificate_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = var.ssl_policy
  tags              = var.tags

  dynamic "default_action" {
    for_each = var.default_action

    content {
      type             = default_action.value.type
      order            = lookup(default_action.value, "order", null)
      target_group_arn = lookup(default_action.value, "target_group_arn", null)

      dynamic "authenticate_cognito" {
        for_each = lookup(default_action.value, "authenticate_cognito", null) == null ? [] : [default_action.value.authenticate_cognito]

        content {
          user_pool_arn                       = authenticate_cognito.value.user_pool_arn
          user_pool_client_id                 = authenticate_cognito.value.user_pool_client_id
          user_pool_domain                    = authenticate_cognito.value.user_pool_domain
          authentication_request_extra_params = lookup(authenticate_cognito.value, "authentication_request_extra_params", {})
          on_unauthenticated_request          = lookup(authenticate_cognito.value, "on_authenticated_request", null)
          scope                               = lookup(authenticate_cognito.value, "scope", null)
          session_cookie_name                 = lookup(authenticate_cognito.value, "session_cookie_name", null)
          session_timeout                     = lookup(authenticate_cognito.value, "session_timeout", null)
        }

      }

      dynamic "authenticate_oidc" {
        for_each = lookup(default_action.value, "authenticate_oidc", null) == null ? [] : [default_action.value.authenticate_oidc]

        content {
          # Max 10 extra params
          authentication_request_extra_params = lookup(authenticate_oidc.value, "authentication_request_extra_params", null)
          authorization_endpoint              = authenticate_oidc.value.authorization_endpoint
          client_id                           = authenticate_oidc.value.client_id
          client_secret                       = authenticate_oidc.value.client_secret
          issuer                              = authenticate_oidc.value.issuer
          on_unauthenticated_request          = lookup(authenticate_oidc.value, "on_unauthenticated_request", null)
          scope                               = lookup(authenticate_oidc.value, "scope", null)
          session_cookie_name                 = lookup(authenticate_oidc.value, "session_cookie_name", null)
          session_timeout                     = lookup(authenticate_oidc.value, "session_timeout", null)
          token_endpoint                      = authenticate_oidc.value.token_endpoint
          user_info_endpoint                  = authenticate_oidc.value.user_info_endpoint
        }

      }

      dynamic "fixed_response" {
        for_each = lookup(default_action.value, "fixed_response", null) == null ? [] : [default_action.value.fixed_response]

        content {
          content_type = fixed_response.value.content_type
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }

      }

      dynamic "forward" {
        for_each = lookup(default_action.value, "forward", null) == null ? [] : [default_action.value.forward]

        content {
          dynamic "target_group" {
            for_each = forward.value.target_group

            content {
              arn    = target_group.value.arn
              weight = target_group.value.weight
            }

          }

          dynamic "stickiness" {
            for_each = lookup(default_action.value, "stickiness", null) == null ? [] : [default_action.value.stickiness]

            content {
              duration = stickiness.value.duration
              enabled  = lookup(stickiness.value, "enabled", null)
            }
          }

        }

      }

      dynamic "redirect" {
        for_each = lookup(default_action.value, "redirect", null) == null ? [] : [default_action.value.redirect]

        content {
          path        = lookup(redirect.value, "path", null)
          host        = lookup(redirect.value, "host", null)
          port        = lookup(redirect.value, "port", null)
          protocol    = lookup(redirect.value, "protocol", null)
          query       = lookup(redirect.value, "query", null)
          status_code = redirect.value.status_code
        }

      }

    }

  }

}

resource "aws_lb_listener_certificate" "certificate" {
  count = length(var.additional_certificates)

  listener_arn    = aws_lb_listener.listener.arn
  certificate_arn = var.additional_certificates[count.index]
}

resource "aws_lb_listener_rule" "rule" {
  count = length(var.rules)

  listener_arn = aws_lb_listener.listener.arn
  priority     = lookup(var.rules[count.index], "priority", null)
  tags         = var.tags
  # min= 1
  dynamic "condition" {
    for_each = var.rules[count.index]["condition"]
    content {
      dynamic "host_header" {
        for_each = length(keys(lookup(condition.value, "host_header", {}))) == 0 ? [] : [condition.value.host_header]
        content {
          values = host_header.value.values
        }
      }

      dynamic "http_header" {
        for_each = length(keys(lookup(condition.value, "http_header", {}))) == 0 ? [] : [condition.value.http_header]
        content {
          http_header_name = http_header.value.http_header_name
          values           = http_header.value.values
        }
      }

      dynamic "http_request_method" {
        for_each = length(keys(lookup(condition.value, "http_request_method", {}))) == 0 ? [] : [condition.value.http_request_method]
        content {
          values = http_request_method.value.values
        }
      }

      dynamic "path_pattern" {
        for_each = length(keys(lookup(condition.value, "path_pattern", {}))) == 0 ? [] : [condition.value.path_pattern]
        content {
          values = path_pattern.value.values
        }
      }

      dynamic "source_ip" {
        for_each = length(keys(lookup(condition.value, "source_ip", {}))) == 0 ? [] : [condition.value.source_ip]
        content {
          values = source_ip.value.values
        }
      }
      dynamic "query_string" {
        for_each = lookup(condition.value, "query_string", [])
        content {
          value = query_string.value.values
          key   = lookup(query_string.value, "key", null)
        }
      }

    }

  }

  dynamic "action" {
    for_each = var.rules[count.index]["action"]

    content {
      type             = action.value.type
      target_group_arn = lookup(action.value, "target_group_arn", null)

      dynamic "forward" {
        for_each = length(keys(lookup(action.value, "forward", {}))) == 0 ? [] : [action.value.forward]
        content {
          dynamic "target_group" {
            for_each = forward.value.target_group
            content {
              arn    = target_group.value.arn
              weight = lookup(target_group.value, "weight", null)
            }
          }
          dynamic "stickiness" {
            for_each = length(keys(lookup(forward.value, "stickiness", {}))) == 0 ? [] : [forward.value.stickiness]
            content {
              enabled  = lookup(stickiness.value, "enabled", null)
              duration = stickiness.value.duration
            }
          }
        }
      }

      dynamic "redirect" {
        for_each = length(keys(lookup(action.value, "redirect", {}))) == 0 ? [] : [action.value.redirect]
        content {
          host        = lookup(redirect.value, "host", null)
          path        = lookup(redirect.value, "path", null)
          port        = lookup(redirect.value, "port", null)
          query       = lookup(redirect.value, "query", null)
          status_code = redirect.value.status_code
        }
      }

      dynamic "fixed_response" {
        for_each = length(keys(lookup(action.value, "fixed_response", {}))) == 0 ? [] : [action.value.fixed_response]
        content {
          content_type = fixed_response.value.content_type
          message_body = lookup(fixed_response.value, "message_body", null)
          status_code  = lookup(fixed_response.value, "status_code", null)
        }

      }

      dynamic "authenticate_cognito" {
        for_each = length(keys(lookup(action.value, "authenticate_cognito", {}))) == 0 ? [] : [action.value.authenticate_cognito]
        content {
          user_pool_arn                       = authenticate_cognito.value.user_pool_arn
          user_pool_client_id                 = authenticate_cognito.value.user_pool_client_id
          user_pool_domain                    = authenticate_cognito.value.user_pool_domain
          authentication_request_extra_params = lookup(authenticate_cognito.value, "authentication_request_extra_params", null)
          on_unauthenticated_request          = lookup(authenticate_cognito.value, "on_unauthenticated_request", null)
          scope                               = lookup(authenticate_cognito.value, "scope", null)
          session_cookie_name                 = lookup(authenticate_cognito.value, "session_cookie_name", null)
          session_timeout                     = lookup(authenticate_cognito.value, "session_timeout", null)

        }
      }

      dynamic "authenticate_oidc" {
        for_each = length(keys(lookup(action.value, "authenticate_oidc", {}))) == 0 ? [] : [action.value.authenticate_oidc]
        content {
          authorization_endpoint              = authenticate_oidc.value
          client_secret                       = authenticate_oidc.value.client_secret
          client_id                           = authenticate_oidc.value.client_id
          issuer                              = authenticate_oidc.value.issuer
          token_endpoint                      = authenticate_oidc.value.token_endpoint
          user_info_endpoint                  = authenticate_oidc.value.user_info_endpoint
          authentication_request_extra_params = lookup(authenticate_oidc.value, "authentication_request_extra_params", null)
          on_unauthenticated_request          = lookup(authenticate_oidc.value, "on_unauthenticated_request", null)
          scope                               = lookup(authenticate_oidc.value, "scope", null)
          session_cookie_name                 = lookup(authenticate_oidc.value, "session_cookie_name", null)
          session_timeout                     = lookup(authenticate_oidc.value, "session_timeout", null)

        }
      }

    }
  }

}