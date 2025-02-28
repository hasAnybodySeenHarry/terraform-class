output "db_endpoint" {
  value       = aws_db_instance.postgres_db.address
  description = "The address of the created Postgres Database"
}
