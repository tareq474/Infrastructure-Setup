resource "aws_instance" "frontend_instance" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.allow_web.id]

  tags = {
    Name = "frontend_instance"
  }
}

resource "aws_instance" "backend_instance" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private_subnet.id

  tags = {
    Name = "backend_instance"
  }
}
