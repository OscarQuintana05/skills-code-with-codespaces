FROM mcr.microsoft.com/devcontainers/universal:latest

# Instalar 'sl' (locomotora de vapor) en la imagen para evitar usar sudo en postCreate
RUN apt-get update \
    && apt-get install -y --no-install-recommends sl \
    && rm -rf /var/lib/apt/lists/*
