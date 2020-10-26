resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(var.common_tags,
    map("Name", "${upper(var.environment)}-${upper(var.common_tags["AccountType"])}-${upper(var.common_tags["Application"])}-DB")
    )
}
