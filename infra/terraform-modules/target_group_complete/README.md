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
| [aws_lb_target_group.tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.tg_attch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_termination"></a> [connection\_termination](#input\_connection\_termination) | Whether to terminate connections at the end of the deregistration timeout on Network Load Balancers. | `bool` | `false` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is `0-3600` seconds. | `string` | `"300"` | no |
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | (Optional, Maximum of 1) Health Check configuration block. | `map(any)` | `{}` | no |
| <a name="input_lambda_multi_value_headers_enabled"></a> [lambda\_multi\_value\_headers\_enabled](#input\_lambda\_multi\_value\_headers\_enabled) | Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when `target_type` is `lambda`. | `bool` | `false` | no |
| <a name="input_load_balancing_algorithm_type"></a> [load\_balancing\_algorithm\_type](#input\_load\_balancing\_algorithm\_type) | Whether the request and response headers exchanged between the load balancer and the Lambda function include arrays of values or strings. Only applies when `target_type` is lambda. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional, Forces new resource) Name of the target group. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | (May be required, Forces new resource) Port on which targets receive traffic, unless overridden when registering a specific target. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`. | `number` | `null` | no |
| <a name="input_preserve_client_ip"></a> [preserve\_client\_ip](#input\_preserve\_client\_ip) | Whether client IP preservation is enabled. | `string` | `null` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | (May be required, Forces new resource) Protocol to use for routing traffic to the targets. Should be one of `GENEVE`, `HTTP`, `HTTPS, TCP`, `TCP_UDP`, `TLS`, or `UDP`. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`. | `string` | `null` | no |
| <a name="input_protocol_version"></a> [protocol\_version](#input\_protocol\_version) | Only applicable when `protocol` is `HTTP` or `HTTPS`. The protocol version. Specify GRPC to send requests to targets using gRPC. Specify HTTP2 to send requests to targets using HTTP/2. | `string` | `null` | no |
| <a name="input_proxy_protocol_v2"></a> [proxy\_protocol\_v2](#input\_proxy\_protocol\_v2) | Whether to enable support for proxy protocol v2 on Network Load Balancers. | `bool` | `false` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | Amount time for targets to warm up before the load balancer sends them a full share of requests. The range is `30-900` seconds or 0 to disable. | `number` | `0` | no |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | (Optional, Maximum of 1) Stickiness configuration block. | `map(any)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_group_attachments"></a> [target\_group\_attachments](#input\_target\_group\_attachments) | List of maps of target group attachment values. | `list(any)` | `[]` | no |
| <a name="input_target_type"></a> [target\_type](#input\_target\_type) | (May be required, Forces new resource) Type of target that you must specify when registering targets with this target group. | `string` | `"instance"` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Set this to true to append unique identifier to the name. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional, Forces new resource) Identifier of the VPC in which to create the target group. Required when `target_type` is `instance` or `ip`. Does not apply when `target_type` is `lambda`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the Target Group (matches id). |
| <a name="output_arn_suffix"></a> [arn\_suffix](#output\_arn\_suffix) | ARN suffix for use with CloudWatch Metrics. |
| <a name="output_id"></a> [id](#output\_id) | ID of the Target Group (matches arn). |
| <a name="output_name"></a> [name](#output\_name) | Name of the Target Group. |
<!-- END_TF_DOCS -->