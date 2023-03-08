resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Security group for ec2 servers"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for databases"
  vpc_id      = aws_vpc.my_vpc.id

 
  ingress {
    description     = "Allow MySQL traffic from only the ec2 sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  tags = {
    Name = "db_sg"
  }
}