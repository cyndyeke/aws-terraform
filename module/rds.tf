
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_subnet_group"
  description = "DB subnet group"
  
  subnet_ids  = [for subnet in aws_subnet.private_subnet : subnet.id]
}

resource "aws_db_instance" "my_database" {
  allocated_storage      = var.settings.database.allocated_storage
  
  engine                 = var.settings.database.engine
  
  engine_version         = var.settings.database.engine_version
  
  instance_class         = var.settings.database.instance_class
  
  
  username               = var.db_username
  
  password               = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  
  skip_final_snapshot    = var.settings.database.skip_final_snapshot
}