variable "aws_region"{
description= "aws region"
type= string
default= "us-east-1"
}
variable "enironment"{
description= "environment name"
type= string
default= "dev"
}
variable "cluster_name" {
description = "Kubernetes version for EKS"
  type        = string
  default     = "eks"
}
variable "cluster_version" {
description = "Kubernetes version for EKS"
  type        = string
  default     = "1.32"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

