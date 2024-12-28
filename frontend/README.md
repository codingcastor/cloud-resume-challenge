# Frontend - Cloud Resume

This directory contains the static website implementation of the Cloud Resume Challenge.

## Structure
```
.
├── index.html      # Main resume page
├── styles/         # CSS stylesheets
└── scripts/        # JavaScript for visitor counter
```

## Setup

1. Edit `index.html` with your resume content
2. Test locally by opening in a browser
3. Deploy to S3 bucket (configured via infrastructure)

## Development

To test locally:
```bash
# Open index.html in your default browser
open index.html
```

## Requirements
- Basic HTML/CSS knowledge
- AWS S3 bucket (configured in infrastructure)
- CloudFront distribution (configured in infrastructure)
