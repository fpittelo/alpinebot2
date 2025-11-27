import azure.functions as func
import logging
import os
import json
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
from openai import AzureOpenAI

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="health")
def health_check(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse("AlpineBot Backend is Healthy!", status_code=200)

@app.route(route="chat", methods=["POST"])
def chat(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Chat trigger function processed a request.')

    try:
        req_body = req.get_json()
        messages = req_body.get('messages')
        
        if not messages:
             return func.HttpResponse("Please pass messages in the request body", status_code=400)

        endpoint = os.environ.get("AZURE_OPENAI_ENDPOINT")
        api_key = os.environ.get("AZURE_OPENAI_API_KEY")
        deployment = os.environ.get("AZURE_OPENAI_DEPLOYMENT_NAME")

        if not endpoint or not deployment:
             return func.HttpResponse("Azure OpenAI not configured", status_code=500)

        # Initialize Azure OpenAI Client
        # Prefer API Key for local dev simplicity if provided, else Managed Identity
        if api_key:
            client = AzureOpenAI(
                azure_endpoint=endpoint,
                api_key=api_key,
                api_version="2024-02-01"
            )
        else:
            credential = DefaultAzureCredential()
            token = credential.get_token("https://cognitiveservices.azure.com/.default")
            client = AzureOpenAI(
                azure_endpoint=endpoint,
                azure_ad_token=token.token,
                api_version="2024-02-01"
            )

        completion = client.chat.completions.create(
            model=deployment,
            messages=messages,
            max_tokens=800,
            temperature=0.7,
            top_p=0.95,
            frequency_penalty=0,
            presence_penalty=0,
            stop=None,
            stream=False
        )

        response_content = completion.choices[0].message.content
        return func.HttpResponse(
            json.dumps({"content": response_content}),
            mimetype="application/json",
            status_code=200
        )

    except ValueError:
        return func.HttpResponse("Invalid JSON", status_code=400)
    except Exception as e:
        logging.error(f"Error in chat function: {str(e)}")
        return func.HttpResponse(f"Internal Server Error: {str(e)}", status_code=500)

# @app.schedule(schedule="0 0 0 * * *", arg_name="myTimer", run_on_startup=False,
#               use_monitor=False)
# def ingestion_timer(myTimer: func.TimerRequest) -> None:
#     logging.info('Ingestion timer trigger function started.')
#
#     # Test Key Vault Connection
#     try:
#         kv_name = os.environ.get("KEY_VAULT_NAME")
#         if kv_name:
#             credential = DefaultAzureCredential()
#             client = SecretClient(vault_url=f"https://{kv_name}.vault.azure.net", credential=credential)
#             # Try to list secrets (we have List permission)
#             secrets = client.list_properties_of_secrets()
#             secret_count = sum(1 for _ in secrets)
#             logging.info(f"Successfully connected to Key Vault. Found {secret_count} secrets.")
#         else:
#             logging.warning("KEY_VAULT_NAME environment variable not set.")
#     except Exception as e:
#         logging.error(f"Failed to connect to Key Vault: {str(e)}")
#
#     # Test OpenAI Connection
#     try:
#         openai_endpoint = os.environ.get("AZURE_OPENAI_ENDPOINT")
#         if openai_endpoint:
#              # Just logging the endpoint availability for now, full client init requires more env vars
#              logging.info(f"OpenAI Endpoint configured: {openai_endpoint}")
#              # In a real scenario, we would init the AzureOpenAI client here with DefaultAzureCredential
#         else:
#              logging.warning("AZURE_OPENAI_ENDPOINT environment variable not set.")
#
#     except Exception as e:
#         logging.error(f"Failed to connect to OpenAI: {str(e)}")
#
#     logging.info('Ingestion timer trigger function completed.')
