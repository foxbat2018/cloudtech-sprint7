# TODO: ALB, NAT用
resource "aws_security_group" "sprint7_public_sg" {
  name        = "${local.name_prefix}public-sg"
  description = "Security group for public HTTP access"
  vpc_id      = aws_vpc.sprint7_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# プライベートサブネット上のEC2インスタンスに対して、HTTPアクセスを許可するセキュリティグループ
resource "aws_security_group" "sprint7_ec2_sg" {
  name        = "${local.name_prefix}ec2-sg"
  description = "Security group for only EC2 HTTP access"
  vpc_id      = aws_vpc.sprint7_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_security_group_ingress_rule" "sprint7_ec2_from_alb" {
  security_group_id            = aws_security_group.sprint7_ec2_sg.id
  referenced_security_group_id = aws_security_group.sprint7_public_sg.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}