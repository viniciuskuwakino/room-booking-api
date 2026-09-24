output "function_name" {
  description = "Nome da função Lambda"
  value       = aws_lambda_function.this.function_name
}

output "invoke_arn" {
  description = "ARN utilizado para invocar a Lambda"
  value       = aws_lambda_function.this.invoke_arn
}

output "arn" {
  description = "ARN da função Lambda"
  value       = aws_lambda_function.this.arn
}
