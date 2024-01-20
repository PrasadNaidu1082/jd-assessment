resource "aws_sns_topic" "jdoodle_topic" {
  name = "JoodleTopic"
}

resource "aws_sns_topic_subscription" "jdoodle_subscription" {
  topic_arn = aws_sns_topic.jdoodle_topic.arn
  protocol  = "email"
  endpoint  = "prasadnaidu1082@gmail.com"
}