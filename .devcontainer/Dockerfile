FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir dbt-core dbt-bigquery

# Create a non-root user called "user" — matches your real repo's
# terminal identity (user@... instead of root@...). python:3.11-slim
# runs as root by default; without this, every command inside the
# container (including your terminal) would run as root instead.
RUN useradd --create-home --shell /bin/bash user

# WORKDIR runs as root here (before USER switches below) so it can
# actually create /workspace — a non-root user typically can't create
# new folders directly under / on its own.
WORKDIR /workspace
RUN chown user:user /workspace

USER user