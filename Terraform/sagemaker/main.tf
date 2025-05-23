resource "aws_sagemaker_notebook_instance" "qa_notebook" {
  name              = "qa-llm-notebook"
  instance_type     = "ml.t2.medium"
  role_arn = var.role_arn
}
