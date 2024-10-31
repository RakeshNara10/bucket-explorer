output "role_arn" {
  description = "IAM role ARN."
  value       = aws_iam_role.role.arn
}
output "role_id" {
  description = "IAM role ID."
  value       = aws_iam_role.role.id
}
output "role_name" {
  description = "IAM role name."
  value       = aws_iam_role.role.name
}
output "create_date" {
  description = "Creation date of the IAM role."
  value       = aws_iam_role.role.create_date
}
output "unique_id" {
  description = "Stable and unique string identifying the role."
  value       = aws_iam_role.role.unique_id
}
output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provide"
  value       = aws_iam_role.role.tags_all
}
##### iam_role_policy outputs
output "policy_name" {
  description = "Name of the inline policies attached"
  value       = aws_iam_role_policy.inline_policy[*].name
}
output "policy_id" {
  description = "The role policy ID, in the form of role_name:role_policy_name"
  value       = aws_iam_role_policy.inline_policy[*].id
}
########## instance profile arn
output "instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile."
  value       = var.instance_profile_arn_create == 1?aws_iam_instance_profile.iam_role_instance_profile[0].arn:null
}
output "instance_profile_id" {
  description = "Instance profile's ID."
  value       = var.instance_profile_arn_create == 1?aws_iam_instance_profile.iam_role_instance_profile[0].id:null
}
output "instance_profile_unique_id" {
  description = "Unique ID assigned by AWS."
  value       = var.instance_profile_arn_create == 1?aws_iam_instance_profile.iam_role_instance_profile[0].unique_id:null
}