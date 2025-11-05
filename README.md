# n8n Pterodactyl Egg

This is a Pterodactyl egg for running n8n (workflow automation platform) with SQLite database and SSL certificate support.

## Features

- ✅ SQLite database (no external database required)
- ✅ SSL certificate support (optional)
- ✅ Configurable port (uses Pterodactyl's assigned port)
- ✅ Basic authentication support (optional)
- ✅ Webhook support
- ✅ Based on Debian Bookworm with Node.js 20.x

## Installation

1. Import the `egg.json` file into your Pterodactyl panel
2. Create a new server using this egg
3. Configure the required environment variables
4. Start the server

## Configuration

### Required Variables

- **SERVER_PORT**: The port n8n will listen on (automatically assigned by Pterodactyl)
- **N8N_HOST**: Host to bind to (default: `0.0.0.0`)
- **N8N_PROTOCOL**: Protocol to use - `http` or `https` (default: `http`)

### SQLite Configuration

- **DB_SQLITE_DATABASE**: Path to SQLite database file (default: `/home/container/.n8n/database.sqlite`)

### SSL Configuration (Optional)

To enable SSL, set both of the following variables:

- **N8N_SSL_KEY**: Path to SSL private key file
- **N8N_SSL_CERT**: Path to SSL certificate file

When both are set, n8n will automatically switch to HTTPS protocol.

### Basic Authentication (Optional)

- **N8N_BASIC_AUTH_USER**: Username for basic authentication
- **N8N_BASIC_AUTH_PASSWORD**: Password for basic authentication

### Webhook Configuration

- **WEBHOOK_URL**: The URL n8n will use for webhooks (should match your external URL)

## Usage

After starting the server:

1. Access n8n through your browser at `http://YOUR_SERVER_IP:PORT` (or `https://` if SSL is enabled)
2. On first startup, n8n will be installed automatically
3. Create your workflows and automations

## Docker Image

The Docker image is based on Debian Bookworm Slim and includes:

- Node.js 20.x
- npm
- SQLite3
- OpenSSL for SSL support
- Build tools for native Node.js modules

## Notes

- n8n is installed on first startup to ensure the latest version
- Data is persisted in the `/home/container/.n8n` directory
- The SQLite database is stored in the container and should be backed up regularly
- For production use, consider using a reverse proxy (like Nginx or Traefik) for SSL termination

## Support

For issues with the egg configuration, please open an issue on the repository.
For n8n-specific issues, refer to the [n8n documentation](https://docs.n8n.io/).
