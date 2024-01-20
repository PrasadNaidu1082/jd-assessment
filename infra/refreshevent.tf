resource "aws_cloudwatch_event_rule" "daily_refresh" {
  name                = "daily_refresh"
  schedule_expression = "cron(0 12 * * ? *)"  # Run every day at 12 am UTC
}

resource "aws_cloudwatch_event_target" "terminate_action" {
  rule = aws_cloudwatch_event_rule.daily_refresh.name
  arn  = aws_autoscaling_group.jdoodle-asg.id
  role_arn = aws_iam_role.autoscaling_refresh_role.arn

  input_transformer {
    input_template = "{\"Action\":\"terminate\"}"
  }
}

resource "aws_cloudwatch_event_target" "recreate_action" {
  rule = aws_cloudwatch_event_rule.daily_refresh.name
  arn  = aws_autoscaling_group.jdoodle-asg.id
  role_arn = aws_iam_role.autoscaling_refresh_role.arn

  input_transformer {
    input_template = "{\"Action\":\"recreate\"}"
  }
}
