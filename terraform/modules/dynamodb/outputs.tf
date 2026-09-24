output "rooms_table_arn" {
  description = "ARN da tabela Rooms"
  value       = aws_dynamodb_table.rooms_table.arn
}
