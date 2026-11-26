import psutil
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
THRESHOLD = 85.0

def check_cpu():
    cpu_percent = psutil.cpu_percent(interval=1)
    if cpu_percent > THRESHOLD:
        logging.warning(f"HIGH CPU LOAD: {cpu_percent}%")
    else:
        logging.info(f"CPU load normal: {cpu_percent}%")

if __name__ == "__main__":
    check_cpu()