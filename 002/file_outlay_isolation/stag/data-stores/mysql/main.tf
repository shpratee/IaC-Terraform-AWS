provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key             = "stag/data-stores/mysql/terraform.tfstate"

#    region          = "us-east-2"
#    bucket          = "shpratee-terraform-state"
#    dynamodb_table  = "shpratee-terraform-locks"
#    encrypt         = true
  }
}

#data "aws_secretsmanager_secret_version" "db_password" {
#  secret_id = "mysql-master-password-stage"
#}

resource "aws_db_instance" "example" {
  identifier_prefix   = "shpratee"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  name                = "example_database"
  username            = "admin"
  skip_final_snapshot = true

  # Master Password - you should not put the password directly in plain text.
  password            = var.db_password
  #data.aws_secretsmanager_secret_version.db_password.secret_string
}
