import {
  bucket = "my-terraform-state-bucket"
  to = aws_s3_bucket.this
}

import {
    table = "tfstatelockcomet"
    to = aws_dynamodb_table.this
}