resource "aws_db_instance" "redmine_rds_db" {
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "10"
  instance_class         = "db.t3.micro"
  availability_zone      = var.zone
  name                   = var.db_name
  username               = var.db_user_name
  password               = var.db_password
  identifier             = "redmine-db"
  multi_az               = false
  port                   = 5432
  vpc_security_group_ids = [aws_security_group.main_firewall.id]
  skip_final_snapshot    = true
}