#!/bin/bash

# n8n Cloudflare Tunnel Setup Helper
echo "🚀 n8n Cloudflare Tunnel Setup Helper"
echo "======================================"
echo

# Check if .env already exists
if [ -f ".env" ]; then
    echo "⚠️  .env file already exists. Backing up to .env.backup"
    cp .env .env.backup
fi

# Get tunnel domain
echo "Enter your Cloudflare Tunnel domain (e.g., n8n.yourdomain.com):"
read -r TUNNEL_DOMAIN

# Get tunnel token
echo "Enter your Cloudflare Tunnel token:"
read -r TUNNEL_TOKEN

# Get basic auth credentials
echo "Enter n8n admin username (default: admin):"
read -r ADMIN_USER
ADMIN_USER=${ADMIN_USER:-admin}

echo "Enter n8n admin password (default: admin):"
read -r ADMIN_PASSWORD
ADMIN_PASSWORD=${ADMIN_PASSWORD:-admin}

# Get timezone
echo "Enter your timezone (default: UTC):"
read -r TIMEZONE
TIMEZONE=${TIMEZONE:-UTC}

# Create .env file
cat > .env << EOF
# PostgreSQL Configuration
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=n8n_password

# n8n Configuration
N8N_BASIC_AUTH_USER=${ADMIN_USER}
N8N_BASIC_AUTH_PASSWORD=${ADMIN_PASSWORD}
N8N_BASIC_AUTH_ACTIVE=true

# Cloudflare Tunnel Configuration
CLOUDFLARE_TUNNEL_DOMAIN=${TUNNEL_DOMAIN}
CLOUDFLARE_TUNNEL_TOKEN=${TUNNEL_TOKEN}
N8N_PROTOCOL=https
WEBHOOK_URL=https://${TUNNEL_DOMAIN}/
GENERIC_TIMEZONE=${TIMEZONE}
EOF

echo
echo "✅ .env file created successfully!"
echo
echo "You can now start n8n with Cloudflare Tunnel:"
echo "  docker-compose --profile cloudflare up -d"
echo
echo "Your n8n instance will be available at:"
echo "  https://${TUNNEL_DOMAIN}"
echo
echo "Login credentials:"
echo "  Username: ${ADMIN_USER}"
echo "  Password: ${ADMIN_PASSWORD}"
echo 