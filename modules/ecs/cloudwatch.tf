resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "/ecs/${aws_ecs_cluster.main.name}"
}

resource "aws_sns_topic" "notification" {
  name = "${var.project_name}-notification"
}

resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "cpu_high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = var.scale_up_cpu_threshold
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "cpu_low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = var.scale_down_cpu_threshold
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
    ServiceName = aws_ecs_service.this.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_down.arn]
}

resource "aws_cloudwatch_log_metric_filter" "error_logs" {
  name           = "container_error_logs"
  pattern        = "[ERROR]"
  log_group_name = aws_cloudwatch_log_group.ecs_logs.name
  metric_transformation {
    name      = "ErrorCount"
    namespace = "ContainerInsights/Prometheus"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "container_errors" {
  alarm_name          = "container_errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ErrorCount"
  namespace           = "ContainerInsights/Prometheus"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  dimensions = {
    ClusterName = aws_ecs_cluster.main.name
  }
  alarm_actions = [aws_sns_topic.notification.arn]
}
