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
| [aws_iam_instance_profile.iam_role_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.managed_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | The policy that grants an entity permission to assume the role. | `any` | `{}` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Name of the aws region | `string` | `"us-west-2"` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | value | `bool` | `false` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Configuration block defining an exclusive set of IAM inline policies associated with the IAM role. | <pre>list(object({<br>    name   = string<br>    policy = any<br>  }))</pre> | `[]` | no |
| <a name="input_instance_profile_arn_create"></a> [instance\_profile\_arn\_create](#input\_instance\_profile\_arn\_create) | If you don't want to create instance profile arn set this to 0 | `number` | `1` | no |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | iam instance profile name- the name should be unique | `string` | `""` | no |
| <a name="input_instance_profile_name_prefix"></a> [instance\_profile\_name\_prefix](#input\_instance\_profile\_name\_prefix) | Creates a unique name beginning with the specified prefix | `string` | `null` | no |
| <a name="input_instance_profile_path"></a> [instance\_profile\_path](#input\_instance\_profile\_path) | Path to the instance profile. | `string` | `"/"` | no |
| <a name="input_instance_profile_tags"></a> [instance\_profile\_tags](#input\_instance\_profile\_tags) | Map of tags | `map(any)` | `{}` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. | `number` | `3600` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs to attach in the role. | `list(string)` | `[]` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | The description of the role. | `string` | `""` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the IAM Role. | `string` | `""` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | Creates a unique name beginning with the specified prefix. Ignored when role\_name is informed. | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | IAM role path. | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add into all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_create_date"></a> [create\_date](#output\_create\_date) | Creation date of the IAM role. |
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile. |
| <a name="output_instance_profile_id"></a> [instance\_profile\_id](#output\_instance\_profile\_id) | Instance profile's ID. |
| <a name="output_instance_profile_unique_id"></a> [instance\_profile\_unique\_id](#output\_instance\_profile\_unique\_id) | Unique ID assigned by AWS. |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | The role policy ID, in the form of role\_name:role\_policy\_name |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Name of the inline policies attached |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN. |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM role ID. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | IAM role name. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provide |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Stable and unique string identifying the role. |
<!-- END_TF_DOCS -->