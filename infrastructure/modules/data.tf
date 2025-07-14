data "aws_s3_bucket" "statebucket" {
    bucket = terraformstatemanagementcomet
  
}

data "aws_dynamodb_table" "tf_lock" {
  name = tfstatelockcomet
}