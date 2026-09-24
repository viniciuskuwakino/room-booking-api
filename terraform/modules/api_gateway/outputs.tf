output "api_url" {
  description = "URL base da API"
  value       = aws_apigatewayv2_api.my_api.api_endpoint
}

output "api_id" {
  description = "ID da API Gateway"
  value       = aws_apigatewayv2_api.my_api.id
}
