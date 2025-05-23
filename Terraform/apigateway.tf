resource "aws_apigatewayv2_api" "qa_api" {
  name          = "qa-llm-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "qa_integration" {
  api_id                 = aws_apigatewayv2_api.qa_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = module.lambda.lambda_invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "qa_route" {
  api_id    = aws_apigatewayv2_api.qa_api.id
  route_key = "POST /ask"
  target    = "integrations/${aws_apigatewayv2_integration.qa_integration.id}"
}

resource "aws_apigatewayv2_stage" "qa_stage" {
  api_id      = aws_apigatewayv2_api.qa_api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "qa_api_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.qa_api.execution_arn}/*/*"
}
