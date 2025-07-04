FROM python:3.10

WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application and tests
COPY . .

# Default command (can be your app or something else)
CMD ["python", "app.py"]