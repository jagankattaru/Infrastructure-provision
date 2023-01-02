resource "aws_instance" "ec2instance" {
  ami               = "var.image.id"
  instance_type     = "var.instance_type.id"
  subnet_id         = aws_subnet.dev_private.id
  availability_zone = var.azs[2]
  #security_groups   = aws_security_group.dev_sg.id
  vpc_security_group_ids = [aws_security_group.dev_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.searchs-api-instance-profile.name

  tags = {
    Name = "demo for terraform"
    Env  = "development"
  }
}
