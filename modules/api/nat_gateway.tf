# NATゲートウェイ用のElastic IP
resource "aws_eip" "sprint7_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}nat-eip"
  }
}

# プライベートサブネットのEC2にアクセスする為のNATゲートウェイ
resource "aws_nat_gateway" "sprint7_nat" {
  subnet_id     = aws_subnet.sprint7_public_subnet01.id
  allocation_id = aws_eip.sprint7_nat_eip.id
  tags = {
    Name = "${local.name_prefix}nat"
  }
}

