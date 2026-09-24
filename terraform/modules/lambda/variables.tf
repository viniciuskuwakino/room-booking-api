variable "function_name" {
  description = "Nome da função Lambda na AWS"
  type        = string
}

variable "handler" {
  description = "Handler executado pela Lambda"
  type        = string
}

variable "filename" {
  description = "Caminho do arquivo ZIP"
  type        = string
}

variable "source_code_hash" {
  description = "Hash do código da Lambda"
  type        = string
}

variable "runtime" {
  description = "Runtime utilizado pela Lambda"
  type        = string
  default     = "nodejs24.x"
}

variable "dynamodb_permissions" {
  description = "Permissões da Lambda no DynamoDB"
  type        = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  default     = []
}

variable "environment_variables" {
  description = "Variáveis de ambiente da função Lambda"
  type        = map(string)
  default     = {}
}
