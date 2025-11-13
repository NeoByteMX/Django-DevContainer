FROM mcr.microsoft.com/devcontainers/python:3.12

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Instala dependencias del sistema necesarias para Django + psycopg2 + Pillow
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
       build-essential \
       libpq-dev \
       libjpeg-dev \
       zlib1g-dev \
       libpng-dev \
       curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar dependencias Python si hay archivo requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip \
    && pip install -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

# Crear directorio del proyecto
WORKDIR /workspace

# Exponer puerto de Django
EXPOSE 5000