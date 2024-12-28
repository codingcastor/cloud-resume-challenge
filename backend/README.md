# Backend - Visitor Counter Lambda

This directory contains the AWS Lambda function that powers the visitor counter feature.

## Structure
```
.
├── handler.py      # Lambda function code
├── requirements.txt # Python dependencies
└── tests/          # Unit tests
```

## Setup

1. Create a Python virtual environment:
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

2. Run tests:
```bash
python -m pytest tests/
```

## Development

The Lambda function:
- Reads/writes to DynamoDB
- Returns current visitor count
- Handles API Gateway events

## Requirements
- Python 3.8+
- AWS Lambda (configured in infrastructure)
- DynamoDB table (configured in infrastructure)
