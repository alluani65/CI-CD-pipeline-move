import psutil
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
THRESHOLD = 80.0

def check_disk():
    usage = psutil.disk_usage('/')
    if usage.percent > THRESHOLD:
        logging.warning(f"CRITICAL: Disk usage at {usage.percent}%. Clean up required.")
    else:
        logging.info(f"Disk health normal: {usage.percent}%.")

if __name__ == "__main__":
    check_disk()