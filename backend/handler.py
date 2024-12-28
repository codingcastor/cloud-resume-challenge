import os
import json
import boto3
from typing import Dict, Any

# Initialize DynamoDB client
dynamodb = boto3.resource('dynamodb')
TABLE_NAME = os.environ.get('DYNAMODB_TABLE', 'visitor-counter')
table = dynamodb.Table(TABLE_NAME)

def update_counter() -> int:
    """
    Update the visitor counter in DynamoDB and return the new count
    """
    try:
        response = table.update_item(
            Key={'id': 'visitors'},
            UpdateExpression='ADD visits :inc',
            ExpressionAttributeValues={':inc': 1},
            ReturnValues='UPDATED_NEW'
        )
        return int(response['Attributes']['visits'])
    except Exception as e:
        print(f"Error updating counter: {str(e)}")
        return 0

def handler(event: Dict[str, Any], context: Any) -> Dict[str, Any]:
    """
    Lambda handler to process API Gateway requests
    """
    try:
        # Update the counter
        new_count = update_counter()
        
        # Prepare the response
        response = {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET',
                'Access-Control-Allow-Headers': 'Content-Type'
            },
            'body': json.dumps({
                'visits': new_count
            })
        }
        
        return response
        
    except Exception as e:
        print(f"Error in handler: {str(e)}")
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            'body': json.dumps({
                'error': 'Internal server error'
            })
        }
