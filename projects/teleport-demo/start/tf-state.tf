## CREATE INFRA TO SAFE TERRAFORM STATE
module "s3_terraform_state" {
  source = "../../../modules/cloud/aws/s3"
  bucket_name = "${var.project_name}-bucket"
}

module "dynamo_table_terraform_state" {
  source = "../../../modules/cloud/aws/dynamodb"
  dynamodb_table_name = "${var.project_name}-dynamo-table"
}

## SAFE INIT STATE 
module "s3_terraform_state_start" {
  source = "../../../modules/cloud/aws/s3"
  bucket_name = "${var.project_name}-bucket-start"
}

module "s3_safe_object_state" {
  source = "../../../modules/cloud/aws/s3/createObjects"
  bucket_name = "${var.project_name}-bucket-start" 
  key_object  = "terraform.tfstate"
  object_path = "./terraform.tfstate"
  
  depends_on = [
    module.s3_terraform_state_start
  ]
}


