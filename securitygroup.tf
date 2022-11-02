resource "aws_security_group" "canada_ec2_linux" {
  vpc_id        = aws_vpc.main.id
  name          = "canada_ec2_linux_sagie"
  description   = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port     = 22
  to_port       = 22
  protocol      = "tcp"
  cidr_blocks   = ["${aws_instance.ec2_windows.private_ip}/32"] # < concatenate in terraform (For Valid Cidr_blocks)
}
  tags = {
    Name = "sagie-allow-ssh"
  }
}


resource "aws_security_group" "canada_ec2_win" {
  vpc_id        = aws_vpc.main.id
  name          = "canada_ec2_windows_sagie"
  description   = "security group that allows rdp and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
  from_port     = 3389
  to_port       = 3389
  protocol      = "tcp"
  cidr_blocks   = ["0.0.0.0/0"]
}
  tags = {
    Name = "sagie-allow-rdp"
  }
}