terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      version = "~> 3.0"
      source = "hashicorp/aws"
    }
	time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
  }
}
