terraform {
  required_version = "~>1.3.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = var.region
  access_key = "AKIAXDYMZDXYE5KZ5UK4"
  secret_key = "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"
}
