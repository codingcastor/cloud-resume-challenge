output "website_url" {
  description = "S3 website URL"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = aws_apigatewayv2_stage.api.invoke_url
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.visitor_counter.name
}
