resource "aws_dynamodb_table" "rooms_table" {
  name           = "Rooms"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "gsiStaticPartitionKey"
    type = "S"
  }

  attribute {
    name = "createdAt"
    type = "S"
  }

  global_secondary_index {
    name            = "CreatedAtIndex"

    key_schema {
      attribute_name = "gsiStaticPartitionKey"
      key_type       = "HASH"
    }
    
    key_schema {
      attribute_name = "createdAt"
      key_type       = "RANGE"
    }

    projection_type = "ALL"
  }

}
