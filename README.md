# n8n Local Development Setup

A Docker-based setup for running [n8n](https://n8n.io/) locally with PostgreSQL database and optional Cloudflare Tunnel support for public access.

## 📋 Prerequisites

- Docker and Docker Compose installed
- (Optional) Cloudflare account with a tunnel configured for public access

## 🚀 Quick Start

### Local Development (No Public Access)

1. **Clone and start the services:**
   ```bash
   docker-compose up -d
   ```

2. **Access n8n:**
   - URL: http://localhost:5678
   - Username: `admin`
   - Password: `admin`

### Public Access with Cloudflare Tunnel

1. **Run the setup script:**
   ```bash
   ./setup-tunnel.sh
   ```

2. **Follow the prompts to configure:**
   - Cloudflare Tunnel domain
   - Cloudflare Tunnel token
   - Admin credentials
   - Timezone

3. **Start with Cloudflare profile:**
   ```bash
   docker-compose --profile cloudflare up -d
   ```

## 🛠️ Configuration

### Environment Variables

The setup supports the following environment variables (automatically configured by `setup-tunnel.sh`):

| Variable | Default | Description |
|----------|---------|-------------|
| `CLOUDFLARE_TUNNEL_DOMAIN` | `localhost` | Your tunnel domain |
| `CLOUDFLARE_TUNNEL_TOKEN` | - | Cloudflare tunnel token |
| `N8N_BASIC_AUTH_USER` | `admin` | n8n admin username |
| `N8N_BASIC_AUTH_PASSWORD` | `admin` | n8n admin password |
| `N8N_PROTOCOL` | `http` | Protocol (http/https) |
| `WEBHOOK_URL` | `http://localhost:5678/` | Webhook base URL |
| `GENERIC_TIMEZONE` | `UTC` | Timezone setting |

### Manual Configuration

You can also manually create a `.env` file with your preferred settings:

```env
# PostgreSQL Configuration
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=n8n_password

# n8n Configuration
N8N_BASIC_AUTH_USER=your_username
N8N_BASIC_AUTH_PASSWORD=your_password
N8N_BASIC_AUTH_ACTIVE=true

# Cloudflare Tunnel Configuration (optional)
CLOUDFLARE_TUNNEL_DOMAIN=your-domain.com
CLOUDFLARE_TUNNEL_TOKEN=your_tunnel_token
N8N_PROTOCOL=https
WEBHOOK_URL=https://your-domain.com/
GENERIC_TIMEZONE=America/New_York
```

## 🎯 Usage

### Starting Services

```bash
# Local development only
docker-compose up -d

# With Cloudflare tunnel
docker-compose --profile cloudflare up -d
```

### Stopping Services

```bash
docker-compose down
```

### Viewing Logs

```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f n8n
docker-compose logs -f postgres
docker-compose logs -f cloudflared
```

### Updating n8n

```bash
docker-compose pull
docker-compose up -d
```

## 📊 Services Overview

### n8n
- **Port:** 5678
- **Database:** PostgreSQL
- **Auth:** Basic authentication enabled
- **Data:** Persisted in Docker volume `n8n_data`

### PostgreSQL
- **Port:** 5432 (internal)
- **Database:** n8n
- **User:** n8n
- **Data:** Persisted in Docker volume `postgres_data`

### Cloudflare Tunnel (Optional)
- **Profile:** cloudflare
- **Purpose:** Provides secure public access to your n8n instance
- **Network:** Host mode for optimal performance

## 🔧 Troubleshooting

### Common Issues

1. **Port 5678 already in use:**
   ```bash
   # Check what's using the port
   lsof -i :5678
   
   # Stop the conflicting service or change the port in docker-compose.yml
   ```

2. **Database connection issues:**
   ```bash
   # Check if PostgreSQL is healthy
   docker-compose ps postgres
   
   # View database logs
   docker-compose logs postgres
   ```

3. **Cloudflare tunnel not working:**
   - Verify your tunnel token is correct
   - Check that your domain is properly configured in Cloudflare
   - View cloudflared logs: `docker-compose logs cloudflared`

### Resetting the Setup

To completely reset your n8n instance:

```bash
# Stop services
docker-compose down

# Remove volumes (⚠️ This will delete all data)
docker-compose down -v

# Remove .env file
rm .env

# Start fresh
./setup-tunnel.sh
```

## 📝 Notes

- The setup uses basic authentication by default for security
- All data is persisted in Docker volumes
- The PostgreSQL database is configured with health checks
- Cloudflare tunnel runs in host network mode for better performance

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this setup!

## 📄 License

This project is provided as-is for educational and development purposes. 