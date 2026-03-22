# module/vpc/variable.tf

variable "project_name" {}
variable "cidr_block" {}
variable "public_subnets" {
    type = list(string)
}
variable "azs" {
    type = list(string)
}


# Defines what the VPC module requires as inputs. Makes the module reusable; caller decides CIDR, subnets, AZs.