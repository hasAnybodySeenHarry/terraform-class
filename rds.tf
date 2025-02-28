module "rds" {
  source = "./modules/rds"

  vpc_id   = data.aws_vpc.default.id
  vpc_cidr = data.aws_vpc.default.cidr_block

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
