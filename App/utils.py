import boto3

def ask_bedrock(question):
    client = boto3.client("bedrock-runtime")
    response = client.invoke_model(
        modelId="anthropic.claude-v2",
        contentType="application/json",
        body=f'{{"prompt":"{question}", "max_tokens_to_sample":100}}'
    )
    return response["body"].read().decode("utf-8")
