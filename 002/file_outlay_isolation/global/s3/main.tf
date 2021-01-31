provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "global/s3/terraform.tfstate"

    region = "us-east-2"
    bucket          = "shpratee-terraform-state-1"
    dynamodb_table  = "shpratee-terraform-locks-1"
    encrypt         = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

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
  name          = var.table_name
  billing_mode  = "PAY_PER_REQUEST"
  hash_key      = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
