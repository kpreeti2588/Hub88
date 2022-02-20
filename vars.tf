variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "instance_type"{
   default = "t2.micro"
}

variable "AMIS" {
  type = map(string)
  default= {
  us-east-1= "ami-09e67e426f25ce0d7"
  us-east-2= "ami-074cce78125f09d61"  
  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykeypair"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykeypair.pub"
}

variable "instance_tenancy" {
  description = "it defines the tenancy of VPC. Whether it's default or dedicated"
  type        = string
  default     = "default"
}

variable "log_group_name" {
  default = "docker_logs"
}

variable "log_retention_days" {
  default = "7"
}

variable "in_count" {
  default = "3"
}




