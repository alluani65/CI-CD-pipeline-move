import requests
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
URL = "http://localhost:80"

def check_endpoint():
    try:
        response = requests.get(URL, timeout=5)
        if response.status_code == 200:
            logging.info(f"Endpoint {URL} is UP.")
        else:
            logging.warning(f"Endpoint returned status code: {response.status_code}")
    except requests.exceptions.RequestException as e:
        logging.error(f"Endpoint {URL} is DOWN. Error: {e}")

if __name__ == "__main__":
    check_endpoint()