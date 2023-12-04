FROM python:3.11-slim

ENV PIP_DEFAULT_TIMEOUT=100 \
    # Allow statements and log messages to immediately appear
    PYTHONUNBUFFERED=1 \
    # disable a pip version check to reduce run-time & log-spam
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    # cache is useless in docker image, so disable to reduce image size
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY app.py  requirements.txt ./
COPY static  templates ./static/
COPY templates ./templates/

RUN set -ex \
    # Create a non-root user
    && addgroup --system --gid 1001 appgroup \
    && adduser --system --uid 1001 --gid 1001 --no-create-home appuser \
    # Upgrade the package index and install security upgrades
    && apt-get update \
    && apt-get upgrade -y \
    #Upgrade PIP
    && pip3 install --upgrade pip \
    # Install dependencies
    && pip3 install -r requirements.txt \
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers=2", "app:app"]

# Set the user to run the application
USER appuser
