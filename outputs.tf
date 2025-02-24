output "vpc_id" {
  value       = data.aws_vpc.default.id
  description = "The id of the default VPC"
}

output "vpc_cidr" {
  value       = data.aws_vpc.default.cidr_block
  description = "The IPv4 CIDR of the default VPC"
}

output "db_endpoint" {
  value       = aws_db_instance.postgres_db.endpoint
  description = "The endpoint of the created Postgres DB"
}
