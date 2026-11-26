import os
import logging

logging.basicConfig(level=logging.INFO, format='%(message)s')
LOG_PATH = "/var/log/nginx/access.log"

def analyze_logs():
    if not os.path.exists(LOG_PATH):
        logging.error(f"Log file not found at {LOG_PATH}")
        return

    errors = 0
    with open(LOG_PATH, 'r') as f:
        for line in f:
            if " 404 " in line or " 500 " in line:
                logging.warning(f"Error detected: {line.strip()}")
                errors += 1
                
    logging.info(f"Scan complete. {errors} errors found.")

if __name__ == "__main__":
    analyze_logs()