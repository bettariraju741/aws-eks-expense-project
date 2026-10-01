import json
import os
import sys

import boto3

def main():
    secret_arn = os.environ["SECRET_ARN"]
    region = os.environ.get("AWS_REGION", "us-east-1")

    client = boto3.client("secretsmanager", region_name=region)
    response = client.get_secret_value(SecretId=secret_arn)

    secret = json.loads(response["SecretString"])
    username = secret.get("username")
    password = secret.get("password")

    if not username or not password:
        raise ValueError("Secret must contain non-empty username and password fields")

    for filename, value in (
        ("DB_USERNAME", username),
        ("DB_PASSWORD", password),
    ):
        path = os.path.join("/run/secrets", filename)
        with open(path, "w", encoding="utf-8") as file:
            file.write(value)
        os.chmod(path, 0o400)

    print("Database credentials retrieved and written successfully.")

if __name__ == "__main__":
    try:
        main()
    except Exception as error:
        print(
            f"Secret initialization failed: {type(error).__name__}: {error}",
            file=sys.stderr,
        )
        sys.exit(1)
