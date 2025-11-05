#!/bin/bash
set -e

cd /home/container

# Set default environment variables for n8n
export N8N_PORT=${SERVER_PORT:-5678}
export N8N_PROTOCOL=${N8N_PROTOCOL:-http}
export N8N_HOST=${N8N_HOST:-0.0.0.0}

# Use SQLite as the database
export DB_TYPE=sqlite
export DB_SQLITE_DATABASE=${DB_SQLITE_DATABASE:-/home/container/.n8n/database.sqlite}

# SSL Certificate configuration
if [ ! -z "${N8N_SSL_KEY}" ] && [ ! -z "${N8N_SSL_CERT}" ]; then
    export N8N_PROTOCOL=https
    export N8N_SSL_KEY=${N8N_SSL_KEY}
    export N8N_SSL_CERT=${N8N_SSL_CERT}
fi

# Basic auth configuration (optional)
if [ ! -z "${N8N_BASIC_AUTH_USER}" ] && [ ! -z "${N8N_BASIC_AUTH_PASSWORD}" ]; then
    export N8N_BASIC_AUTH_ACTIVE=true
    export N8N_BASIC_AUTH_USER=${N8N_BASIC_AUTH_USER}
    export N8N_BASIC_AUTH_PASSWORD=${N8N_BASIC_AUTH_PASSWORD}
fi

# Webhook URL configuration
export WEBHOOK_URL=${WEBHOOK_URL:-${N8N_PROTOCOL}://${N8N_HOST}:${N8N_PORT}/}

# Create .n8n directory if it doesn't exist
mkdir -p /home/container/.n8n

# Install n8n if not already installed
if [ ! -d "/home/container/node_modules/n8n" ]; then
    echo "Installing n8n..."
    npm install n8n
fi

# Start n8n
echo "Starting n8n on ${N8N_PROTOCOL}://${N8N_HOST}:${N8N_PORT}"
exec npx n8n
