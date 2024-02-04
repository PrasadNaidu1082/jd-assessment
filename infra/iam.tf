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

resource "aws_iam_role" "autoscaling_refresh_role" {
  name = "autoscaling-refresh"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "autoscaling.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "autoscaling_refresh_policy" {
  name = "refresh-policy"
  description = "Policy for refreshing Auto Scaling Group"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "autoscaling:UpdateAutoScalingGroup",
        ],
        Resource = aws_autoscaling_group.jdoodle-asg.arn
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
        "${aws_sns_topic.jdoodle_topic.arn}"
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

resource "aws_iam_role_policy_attachment" "autoscaling_policy_attachment" {
  policy_arn = aws_iam_policy.autoscaling_refresh_policy.arn
  role = aws_iam_role.autoscaling_refresh_role.name
}
