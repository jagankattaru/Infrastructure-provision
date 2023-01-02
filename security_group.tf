#Security Group
resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.dev_vpc.id

  #inbound rules
  ingress {
    description = "Allow All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }
  ingress {
    description = "Allow traffic to application port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    self        = true
  }

  #outbound rules
  egress {
    description = "Allow All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev_sg"
  }
}

#Attach security group to ec2instance
#resource "aws_network_interface_sg_attachment" "dev_sg_attachment" {
#  security_group_id          = aws_security_group.dev_sg.id
#  network_interface_id = aws_instance.ec2instance.primary_network_interface_id
#}
