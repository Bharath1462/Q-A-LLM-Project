resource "aws_lambda_function" "qa_api" {
  function_name    = "qa-api"
  role             = var.role_arn
  handler          = "main.lambda_handler"
  runtime          = "python3.8"
  filename         = "${path.module}/qa_api.zip"
  source_code_hash = filebase64sha256("${path.module}/qa_api.zip")
}
