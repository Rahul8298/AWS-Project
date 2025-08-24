provider "aws" {
    region = "ap-south-1"
}   

terraform {
    backend "s3" {
        bucket = "terraform-backend-rahul0901"
        region = "ap-south-1"
        key = "terraform.tfstate"
        encrypt = true
        use_lockfile = true
    }
}
