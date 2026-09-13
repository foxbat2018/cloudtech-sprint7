# EC2インスタンスのベースとなるAMI
# AWS Systems Manager Parameter Store の公開パラメータから取得
data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# EC2インスタンスの起動テンプレート
resource "aws_launch_template" "sprint7_ec2_launch_template" {
  name_prefix   = "${local.name_prefix}template-"
  image_id      = data.aws_ssm_parameter.al2023_ami.value
  instance_type = "t3.micro"

  # プライベートサブネット上のEC2インスタンスに、HTTPアクセスを許可する
  vpc_security_group_ids = [
    aws_security_group.sprint7_ec2_sg.id,
  ]
  # EC2インスタンスの起動時に実行されるユーザーデータスクリプトを指定
  user_data = base64encode(file("${path.module}/api_userdata.sh"))

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${local.name_prefix}ec2"
    }
  }
}
