terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Package the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../dist/index.js"
  output_path = "${path.module}/dist.zip"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "create_room_lambda" {
  source = "./modules/lambda"

  function_name    = "createRoomHandler"
  handler          = "index.createRoomHandler"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment_variables = {
    ROOMS_TABLE_NAME = "Rooms"
  }

  dynamodb_permissions = [
    {
      actions = [
        "dynamodb:PutItem"
      ]

      resources = [
        "${module.dynamodb.rooms_table_arn}*"
      ]
    }
  ]
}

# module "get_pix_transaction_lambda" {
#   source = "./modules/lambda"

#   function_name    = "getPixTransactionHandler"
#   handler          = "index.getPixTransactionHandler"
#   filename         = data.archive_file.lambda_zip.output_path
#   source_code_hash = data.archive_file.lambda_zip.output_base64sha256

#   environment_variables = {
#     PIX_TRANSACTIONS_TABLE_NAME = "PixTransactions"
#   }

#   dynamodb_permissions = [
#     {
#       actions = [
#         "dynamodb:GetItem"
#       ]

#       resources = [
#         "${module.dynamodb.pix_transactions_table_arn}*"
#       ]
#     }
#   ]
# }

# module "list_pix_transactions_lambda" {
#   source = "./modules/lambda"

#   function_name    = "listPixTransactionsHandler"
#   handler          = "index.listPixTransactionsHandler"
#   filename         = data.archive_file.lambda_zip.output_path
#   source_code_hash = data.archive_file.lambda_zip.output_base64sha256

#   environment_variables = {
#     PIX_TRANSACTIONS_TABLE_NAME = "PixTransactions"
#   }

#   dynamodb_permissions = [
#     {
#       actions = [
#         "dynamodb:Query"
#       ]

#       resources = [
#         "${module.dynamodb.pix_transactions_table_arn}*"
#       ]
#     }
#   ]
# }

module "api_gateway" {
  source = "./modules/api_gateway"

  name = "pix-api"

  routes = {
    create_pix_transaction = {
      route_key            = "POST /room"
      lambda_invoke_arn    = module.create_room_lambda.invoke_arn
      lambda_function_name = module.create_room_lambda.function_name
    }
    # get_pix_transaction = {
    #   route_key            = "GET /pix/{id}"
    #   lambda_invoke_arn    = module.get_pix_transaction_lambda.invoke_arn
    #   lambda_function_name = module.get_pix_transaction_lambda.function_name
    # },
    # list_pix_transactions = {
    #   route_key            = "GET /pix"
    #   lambda_invoke_arn    = module.list_pix_transactions_lambda.invoke_arn
    #   lambda_function_name = module.list_pix_transactions_lambda.function_name
    # }
  }
}
