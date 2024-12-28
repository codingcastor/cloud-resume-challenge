terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.82"
    }
  }
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket = "cloud-resume-challenge-terraform"
    key    = "cloud-resume.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# S3 bucket for website hosting
resource "aws_s3_bucket" "website" {
  bucket = "${var.project_name}-${var.environment}-website"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
      },
    ]
  })
  depends_on = [aws_s3_bucket_public_access_block.website]
}

# DynamoDB table for visitor counter
resource "aws_dynamodb_table" "visitor_counter" {
  name         = "${var.project_name}-${var.environment}-visitors"
  billing_mode = "PAY_PER_REQUEST" # Free tier eligible
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# Lambda function for API
resource "aws_lambda_function" "api" {
  filename      = "../backend/function.zip"
  function_name = "${var.project_name}-${var.environment}-api"
  role          = aws_iam_role.lambda_role.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.12"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.visitor_counter.name
    }
  }
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for Lambda to access DynamoDB
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "${var.project_name}-${var.environment}-lambda-dynamodb-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        Resource = aws_dynamodb_table.visitor_counter.arn
      }
    ]
  })
}

# API Gateway
resource "aws_apigatewayv2_api" "api" {
  name          = "${var.project_name}-${var.environment}-api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_headers = ["content-type"]
  }
}

resource "aws_apigatewayv2_stage" "api" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_apigatewayv2_integration" "api" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"

  integration_uri    = aws_lambda_function.api.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "api" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /visitors"
  target    = "integrations/${aws_apigatewayv2_integration.api.id}"
}

resource "aws_lambda_permission" "api" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
