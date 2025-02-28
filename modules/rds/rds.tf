resource "aws_db_instance" "postgres_db" {
  allocated_storage = 10
  storage_type      = "gp2"

  instance_class = "db.t3.micro"

  backup_retention_period = 0
  skip_final_snapshot     = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  deletion_protection = false

  engine         = "postgres"
  engine_version = "16.3"

  engine_lifecycle_support = "open-source-rds-extended-support-disabled"

  multi_az            = false
  publicly_accessible = false

  tags = {
    "Name" = "Terraform Class Postgres DB"
  }

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  apply_immediately = true
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allow postgres inbound and all outbound"
  vpc_id      = var.vpc_id

  tags = {
    Name = "db_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_postgres" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = var.vpc_cidr
  from_port         = local.postgres_port
  to_port           = local.postgres_port
  ip_protocol       = local.tcp_protocol
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_rds" {
  security_group_id = aws_security_group.db_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_ports
}
