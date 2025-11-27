FROM python:3.11-slim

# Install only what's needed for capabilities
RUN apt-get update && apt-get install -y --no-install-recommends libcap2-bin \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install dependencies
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ .

# Create non-root user and group, give ownership of /app
RUN groupadd -r appuser && useradd -r -u 1000 -g appuser appuser \
    && chown -R appuser:appuser /app

# Allow Python to bind to port 80 as non-root
RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/python3.11

# Switch to non-root user
USER appuser

# Expose port 80
EXPOSE 80

# Run the application
CMD ["python3", "main.py"]

