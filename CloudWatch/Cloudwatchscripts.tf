provider "aws" {
  region = "us-east-1"
}

resource "aws_cloudwatch_log_group" "example" {
  name = "/example/log-group"
}

resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "example-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "This metric monitors EC2 instance CPU utilization."
  alarm_actions       = ["arn:aws:sns:us-east-1:123456789012:example-topic"]
}

resource "aws_cloudwatch_dashboard" "example" {
  dashboard_name = "example-dashboard"

  widgets {
    type = "text"
    x    = 10
    y    = 10
    width = 12
    height = 3
    properties = <<EOF
{
  "markdown": "# Example Dashboard\\nThis is a sample CloudWatch dashboard."
}
EOF
  }
}


resource "aws_cloudwatch_event_rule" "example" {
  name        = "example-rule"
  description = "Example CloudWatch Events Rule"
  schedule_expression = "cron(0 20 * * ? *)"

  event_pattern = <<EOF
{
  "source": ["aws.ec2"],
  "detail": {
    "eventSource": ["autoscaling.amazonaws.com"]
  }
}
EOF

  targets {
    arn = "arn:aws:lambda:us-east-1:123456789012:function:example-lambda-function"
    id  = "example-target"
  }
}


resource "aws_sns_topic" "example" {
  name = "example-topic"
}

resource "aws_cloudwatch_metric_alarm" "example" {
  # ... (alarm configuration)

  alarm_actions = [aws_sns_topic.example.arn]
}


resource "aws_cloudwatch_insights_query" "example" {
  query = "fields @timestamp, @message | sort @timestamp desc | limit 20"
  log_group_names = [aws_cloudwatch_log_group.example.name]
}
