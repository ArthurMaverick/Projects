provider "aws" { 
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "arthur-santos"
  region                  = var.aws_region 
} 

provider "google" {
  region      = var.gcp_region
  credentials = "${path.module}/keys/stately-magpie-353323-81bb9a855aa5.json"
}