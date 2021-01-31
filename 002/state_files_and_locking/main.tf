provider "aws" {
  region = "us-east-2"
}

#terraform {
#  backend "s3" {
#    bucket = "shpratee-terraform-state"
#    key = "global/s3/terraform.tfstate"
#    region = "us-east-2"
#
#    dynamodb_table  = "shpratee-terraform-locks"
#    encrypt         = true
#  }
#}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "shpratee-terraform-state"

  #Prevents accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  #Enable Versioning
  versioning {
    enabled = true
  }

  #Enable Server side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name          = "shpratee-terraform-locks"
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
  description = "The name of the DynamoDB Table"
}
