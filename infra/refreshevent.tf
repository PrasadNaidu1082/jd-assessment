resource "aws_cloudwatch_event_rule" "daily_refresh" {
  name = "daily-refresh"
  description = "Daily refresh of Auto Scaling Group"
  schedule_expression = "cron(0 0 * * ? *)"
}

resource "aws_cloudwatch_event_target" "refresh_target" {
  rule = aws_cloudwatch_event_rule.daily_refresh.name
  target_id = "RefreshTarget"
  arn = aws_lambda_function.refresh_lambda_function.arn
}

resource "aws_lambda_function" "refresh_lambda_function" {
  function_name = "refreshlamdafunction"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = "refreshlambda_function.zip"  
}

resource "aws_iam_role" "lambda_role" {
  name = "LambdaRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
   name       = "lamda-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda_role.name]
}
