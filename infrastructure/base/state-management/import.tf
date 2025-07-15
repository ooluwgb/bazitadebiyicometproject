# import {
#   bucket = "my-terraform-state-bucket"
#   to = aws_s3_bucket.this
# }

# import {
#     table = "tfstatelockcomet"
#     to = aws_dynamodb_table.this
# }

## ask chatgpt if it is smart to import the s3 bucket and dynamodb table handling state management into the same tf state
#if it says no you can remove this whiole folder