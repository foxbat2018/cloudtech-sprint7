# パブリックサブネットに配置してリクエストを受け付けるロードバランサー
resource "aws_lb" "sprint7_alb" {
  name               = "${local.name_prefix}alb"
  internal           = false
  load_balancer_type = "application"
  subnets = [
    aws_subnet.sprint7_public_subnet01.id,
    aws_subnet.sprint7_public_subnet02.id,
  ]
  security_groups = [aws_security_group.sprint7_public_sg.id]

  tags = {
    Name = "${local.name_prefix}alb"
  }

}

# ターゲットグループ
resource "aws_lb_target_group" "sprint7_alb_tg" {
  name     = "${local.name_prefix}alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.sprint7_vpc.id
  target_type = "instance"

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${local.name_prefix}alb-tg"
  }
}
# HTTPリクエストを受け付けるリスナー
resource "aws_lb_listener" "sprint7_listener" {
  load_balancer_arn = aws_lb.sprint7_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sprint7_alb_tg.arn
  }
}