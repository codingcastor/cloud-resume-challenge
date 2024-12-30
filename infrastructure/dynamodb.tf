resource "aws_dynamodb_table" "visitor_counter" {
  name         = "${local.name_prefix}-visitors"
  billing_mode = "PAY_PER_REQUEST" # Free tier eligible
  hash_key     = "id"
  tags         = local.tags

  attribute {
    name = "id"
    type = "S"
  }
}
