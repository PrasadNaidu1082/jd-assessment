resource "aws_sns_topic" "jdoodle_topic" {
  name = "JoodleTopic"
}

resource "aws_sns_topic_subscription" "jdoodle_subscription" {
  topic_arn = aws_sns_topic.jdoodle_topic.arn
  protocol  = "email"
  endpoint  = "prasadnaidu1082@gmail.com"
}

resource "aws_sns_topic" "notification_topic" {
  name = "instance_recreation_notifications"
}

resource "aws_cloudwatch_event_target" "notification_action" {
  rule = aws_cloudwatch_event_rule.daily_refresh.name
  arn  = aws_sns_topic.notification_topic.arn

  input_transformer {
    input_template = "{\"Message\":\"Instance deletion and recreation in progress.\"}"
  }
}
