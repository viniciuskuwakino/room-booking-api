# IAM role for Lambda execution
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = "${var.function_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Permite que a Lambda envie logs para o CloudWatch.
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "dynamodb_permissions" {
  count = length(var.dynamodb_permissions) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = var.dynamodb_permissions

    content {
      effect    = "Allow"
      actions   = statement.value.actions
      resources = statement.value.resources 
    }
  }
}

resource "aws_iam_policy" "dynamodb_permissions" {
  count   = length(var.dynamodb_permissions) > 0 ? 1 : 0
  name    = "${aws_iam_role.lambda_execution_role.name}-dynamodb-permissions"
  policy  = data.aws_iam_policy_document.dynamodb_permissions[0].json 
}

resource "aws_iam_role_policy_attachment" "lambda_dynamo_roles" {
  count       = length(var.dynamodb_permissions) > 0 ? 1 : 0
  role        = aws_iam_role.lambda_execution_role.name
  policy_arn  = aws_iam_policy.dynamodb_permissions[0].arn
}

resource "aws_lambda_function" "this" {
  filename              = var.filename
  function_name         = var.function_name
  role                  = aws_iam_role.lambda_execution_role.arn
  handler               = var.handler
  source_code_hash      = var.source_code_hash
  runtime               = var.runtime
  timeout               = 15

  environment {
    variables = var.environment_variables
  }
}
