output "public_ip" {
  value       = aws_instance.example_server[0].public_ip
  description = "The public ip address of the created instance"
}
