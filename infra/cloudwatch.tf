resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "scale_up_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Avgload"
  namespace           = "InstanceLoad"
  period              = 300  # 5 minutes
  statistic           = "Average"
  threshold           = 75
  alarm_actions       = [aws_autoscaling_policy.scale_up.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.jdoodle-asg
  }
}

resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "scale_down_alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "Avgload"
  namespace           = "InstanceLoad"
  period              = 300  # 5 minutes
  statistic           = "Average"
  threshold           = 50
  alarm_actions       = [aws_autoscaling_policy.scale_down.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.jdoodle-asg
  }
}


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