import docker
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
EXPECTED_CONTAINERS = ['movie-app', 'mysql-db', 'nginx-proxy']

def verify_containers():
    client = docker.from_env()
    running = [container.name for container in client.containers.list()]
    
    for expected in EXPECTED_CONTAINERS:
        if expected not in running:
            logging.error(f"ALERT: {expected} is DOWN or missing!")
        else:
            logging.info(f"OK: {expected} is running.")

if __name__ == "__main__":
    verify_containers()