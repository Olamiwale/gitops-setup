provider "aws" {
    region = var.region
}

# Tells Terraform to use AWS and which region (pulled from a variable, not hardcoded).