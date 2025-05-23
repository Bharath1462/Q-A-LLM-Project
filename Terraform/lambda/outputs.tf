output "lambda_invoke_arn" {
  value = aws_lambda_function.qa_api.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.qa_api.function_name
}