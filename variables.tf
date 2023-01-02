variable "azs" {
  description = "List of AZs in the VPC"
  default = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "image" {
  description = "AMI image"
  default     = "ami-05f7491af5eef733a"
}
variable "region" {
  description = "default to spin up ec2instance"
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Range"
  default     = "10.0.0.0/16"
}

variable "subnets_cidr" {
  description = "CIDR ranges for subnets"
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
