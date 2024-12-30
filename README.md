# Cloud Resume Challenge [![CI/CD Pipeline](https://github.com/codingcastor/cloud-resume-challenge/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/codingcastor/cloud-resume-challenge/actions/workflows/main.yml)

This monorepo contains the implementation of the Cloud Resume Challenge, showcasing cloud architecture and DevOps practices.

## Project Structure

```
.
├── frontend/        # HTML/CSS resume website
├── backend/         # AWS Lambda function for visitor counter
└── infrastructure/ # Terraform IaC for AWS resources
```

## Components

### Frontend
- Static website built with HTML/CSS
- Hosted on AWS S3 with CloudFront distribution
- Includes visitor counter integration

### Backend
- AWS Lambda function written in Python
- DynamoDB integration for visitor count storage
- API Gateway endpoint

### Infrastructure
- Terraform configurations for AWS resources
- Infrastructure as Code (IaC) approach
- Includes S3, CloudFront, Lambda, API Gateway, and DynamoDB

## Getting Started

Each component has its own README with specific setup instructions.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

# TODO
- JS to call API Gateway
- Tests