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