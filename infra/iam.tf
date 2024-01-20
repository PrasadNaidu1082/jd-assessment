resource "aws_iam_role" "cloudwatch_alarm_role" {
  name = "CloudWatchAlarmRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_alarm_policy" {
  name        = "CloudWatchAlarmPolicy"
  description = "IAM policy for CloudWatch Alarms to publish to SNS"

  policy = jsonencode({ 
    Version = "2012-10-17"  
    "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "SNS:Publish"
      ],
      "Resource": [
        "${aws_sns_topic.jdoodle_subscription.arn}"
      ]
    }
  ]
}
)
}

resource "aws_iam_role_policy_attachment" "cloudwatch_alarm_role_attachment" {
  policy_arn = aws_iam_policy.cloudwatch_alarm_policy.arn
  role       = aws_iam_role.cloudwatch_alarm_role.name
}