locals {
  server_name = var.server_config.name
  server_type = var.server_config.type

  anywhere     = "0.0.0.0/0"
  all_ports    = "-1"
  ssh_port     = 22
  tcp_protocol = "tcp"

  postgres_port = 5432

  app_port = 8080
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "example_server" {
  count = var.create_instance ? var.server_count : 0

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.server_type

  tags = {
    "hello" = "terraform"
    "Name"  = "${local.server_name}-${count.index + 1}"
  }

  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
  ]

  user_data = templatefile("./config/run.sh.tmpl", {
    db_username = var.db_username,
    db_password = var.db_password,
    db_name     = var.db_name,
    db_host     = module.rds.db_endpoint
  })

  user_data_replace_on_change = true
}
