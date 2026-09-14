# EC2 Auto Scaling Group
resource "aws_autoscaling_group" "sprint7_ec2_asg" {
  name             = "${local.name_prefix}ec2-asg"
  max_size         = 4 # 最大起動可能なインスタンス数
  min_size         = 2 # 最小起動可能なインスタンス数
  desired_capacity = 2 # 起動するインスタンス数

  vpc_zone_identifier = [
    aws_subnet.sprint7_private_subnet01.id,
    aws_subnet.sprint7_private_subnet02.id
  ]

  target_group_arns = [aws_lb_target_group.sprint7_alb_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.sprint7_ec2_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${local.name_prefix}ec2"
    propagate_at_launch = true
  }

}

# CPU使用率が70%を超えた場合にスケールアウトするポリシー
resource "aws_autoscaling_policy" "sprint7_cpu_scaling" {
  name                   = "${local.name_prefix}cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.sprint7_ec2_asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    target_value = 70.0
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}