provider "aws" {
  region = "us-east-1"
}

module "iam" {
  source = "./iam"
}

module "sagemaker" {
  source   = "./sagemaker"
  role_arn = module.iam.sagemaker_execution_role_arn
}

module "lambda" {
  source   = "./lambda"
  role_arn = module.iam.lambda_execution_role_arn
}