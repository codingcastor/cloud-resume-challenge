# Infrastructure - Terraform AWS Resources

This directory contains the Terraform configurations for all AWS resources needed by the Cloud Resume Challenge.

## Structure
```
.
├── main.tf         # Main Terraform configuration
├── variables.tf    # Input variables
├── outputs.tf      # Output values
└── terraform.tfvars.example # Example variables file
```

## Resources Created

- S3 bucket for static website hosting
- CloudFront distribution
- Lambda function
- API Gateway
- DynamoDB table
- IAM roles and policies

## Setup

1. Install Terraform
2. Configure AWS credentials
3. Initialize Terraform:
```bash
terraform init
```

4. Create `terraform.tfvars` from example
5. Apply infrastructure:
```bash
terraform plan
terraform apply
```

## Requirements
- Terraform 1.0+
- AWS CLI configured
- AWS account with appropriate permissions
