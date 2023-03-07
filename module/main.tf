resource "aws_instance" "main_ec2" {
  count                  = length(var.subnet_cidr_private)
  instance_type          = "t2.micro"
  ami                    = "ami-006dcf34c09e50022"
  key_name               = aws_key_pair.kp.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = aws_subnet.private_subnet[count.index].id
  associate_public_ip_address = true
  tags = {
    Name = "my-ec2-${count.index + 1}"
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"      
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./myKey.pem"
  }
}


resource "aws_eip" "my_eip" {
	
  count    = var.settings.web_app.count

  instance = aws_instance.main_ec2[count.index].id

  vpc      = true
  tags = {
    Name = "my_eip_${count.index}"
  }
}

