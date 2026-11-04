# Use Python 3.14 to match your local environment and support Django 6.1.2
FROM python:3.14-slim

# Prevent Python from writing .pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy and install requirements first to leverage Docker layer caching
COPY requirements.txt /app/
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your Django project files into the container
COPY . /app/

# Expose port 8000
EXPOSE 8000

# Bind runserver to 0.0.0.0 so it is accessible from your Windows browser
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]