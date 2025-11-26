import azure.functions as func
import logging
import os
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient


app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="health")
def health_check(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse("AlpineBot Backend is Healthy!", status_code=200)

@app.schedule(schedule="0 0 0 * * *", arg_name="myTimer", run_on_startup=False,
              use_monitor=False)
def ingestion_timer(myTimer: func.TimerRequest) -> None:
    logging.info('Ingestion timer trigger function started.')

    # Test Key Vault Connection
    try:
        kv_name = os.environ.get("KEY_VAULT_NAME")
        if kv_name:
            credential = DefaultAzureCredential()
            client = SecretClient(vault_url=f"https://{kv_name}.vault.azure.net", credential=credential)
            # Try to list secrets (we have List permission)
            secrets = client.list_properties_of_secrets()
            secret_count = sum(1 for _ in secrets)
            logging.info(f"Successfully connected to Key Vault. Found {secret_count} secrets.")
        else:
            logging.warning("KEY_VAULT_NAME environment variable not set.")
    except Exception as e:
        logging.error(f"Failed to connect to Key Vault: {str(e)}")

    # Test OpenAI Connection
    try:
        openai_endpoint = os.environ.get("AZURE_OPENAI_ENDPOINT")
        if openai_endpoint:
             # Just logging the endpoint availability for now, full client init requires more env vars
             logging.info(f"OpenAI Endpoint configured: {openai_endpoint}")
             # In a real scenario, we would init the AzureOpenAI client here with DefaultAzureCredential
        else:
             logging.warning("AZURE_OPENAI_ENDPOINT environment variable not set.")

    except Exception as e:
        logging.error(f"Failed to connect to OpenAI: {str(e)}")

    logging.info('Ingestion timer trigger function completed.')
