terraform { 
  backend "s3" { 
    encrypt = true 
    bucket = "teleport-labs-bucket"
    dynamodb_table = "teleport-labs-dynamo-table"
    key = "terraform.tfstate" 
    region = "us-east-1"
    
  } 
}