resource "aws_cloudwatch_log_group" "cloud_resume_challenge_log_group" {
  name              = "${local.name_prefix}-log-group"
  retention_in_days = 1
  tags              = local.tags
}
