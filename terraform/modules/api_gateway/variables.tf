variable "name" {
  description = "Nome da API Gateway"
  type        = string
}

variable "routes" {
  description = "Rotas e Lambdas conectadas à API"

  type = map(object({
    route_key            = string
    lambda_invoke_arn    = string
    lambda_function_name = string
  }))
}
