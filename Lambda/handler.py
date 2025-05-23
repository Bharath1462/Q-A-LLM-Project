import json
import boto3
import os

def lambda_handler(event, context):
    question = json.loads(event['body'])["question"]
    client = boto3.client("bedrock-runtime")
    response = client.invoke_model(
        modelId=os.environ["MODEL_ID"],
        contentType="application/json",
        body=json.dumps({"prompt": question, "max_tokens_to_sample": 100})
    )
    answer = response["body"].read().decode("utf-8")
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"answer": answer})
    }