<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.73.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.73.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_certificate.certificate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_lb_listener_rule.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_certificates"></a> [additional\_certificates](#input\_additional\_certificates) | List of additional certificate arn's to attach to the lister. | `list(string)` | `[]` | no |
| <a name="input_alpn_policy"></a> [alpn\_policy](#input\_alpn\_policy) | Name of the Application-Layer Protocol Negotiation (ALPN) policy. Can be set if protocol is `TLS`. Valid values are `HTTP1Only`, `HTTP2Only`, `HTTP2Optional`, `HTTP2Preferred`, and `None`. | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. | `string` | `null` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | List of default\_action maps. | `list(any)` | n/a | yes |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | (Required, Forces New Resource) ARN of the load balancer. | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | Port on which the load balancer is listening. Not valid for `Gateway Load Balancers`. | `number` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are `HTTP` and `HTTPS`, with a default of `HTTP`. For Network Load Balancers, valid values are `TCP`, `TLS`, `UDP`, and `TCP_UDP`. Not valid to use `UDP` or `TCP_UDP` if dual-stack mode is enabled. Not valid for Gateway Load Balancers. | `string` | `null` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | List of rules to attach to the listener. This is a list of map containing `priority`(number, optional), `action`() and `condition`. | `list(any)` | `[]` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | Name of the SSL Policy for the listener. Required if protocol is `HTTPS` or `TLS`. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the listener (matches id) |
| <a name="output_id"></a> [id](#output\_id) | ARN of the listener (matches arn). |
| <a name="output_rule_arn"></a> [rule\_arn](#output\_rule\_arn) | The ARN of the rule (matches id) |
| <a name="output_rule_id"></a> [rule\_id](#output\_rule\_id) | The ARN of the rule (matches arn) |
<!-- END_TF_DOCS -->