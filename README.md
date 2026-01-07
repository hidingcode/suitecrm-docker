# SuiteCRM 8 Docker Setup

Docker Compose setup for SuiteCRM with PHP-FPM and MySQL.

## Architecture

- **PHP-FPM**: PHP FastCGI Process Manager (port 9000) - processes PHP requests
- **MySQL 8.0**: Database server

## Prerequisites

- Docker + Docker Compose

## Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd suitecrm-docker
   ```

2. **Run setup script to download SuiteCRM**:
   The `setup.sh` script will download the SuiteCRM zip file and extract it to the `./suitecrm/` directory.
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   
   Or specify a version:
   ```bash
   SUITEVERSION=8.9.1 ./setup.sh
   ```

3. **Set permissions** (Linux only):
   ```bash
   sudo chown -R www-data:www-data ./suitecrm
   ```

4. **Start all services**:
   ```bash
   docker-compose up -d
   ```
   
   This will start PHP-FPM and MySQL containers.

5. **Configure Nginx** (if using Nginx):
   - The repository includes an example `nginx.conf` file
   - Update the `server_name` in `nginx.conf` to match your server IP address or domain name
   - The root path is configured according to your `suitecrm-docker` repository location
   - Update the `root` path in `nginx.conf` to match your actual repository location if different
   - Configure Nginx to use this configuration file

6. **Access SuiteCRM**:
   - Access SuiteCRM through your configured web server (Nginx/Apache) or use PHP's built-in server
   - Follow the SuiteCRM installation wizard

7. **Database Configuration** (during installation):
   - Database Type: `MySQL`
   - Host Name: `suitecrm-db`
   - Database Name: `suitecrm`
   - Database User: `suitecrm`
   - Database Password: `suitecrmpass`

## Quick Start (Windows)

On Windows, use **WSL** or **Git Bash** and follow the **Installation** steps above.

## Docker Commands

- **Start services**: `docker-compose up -d`
- **Stop services**: `docker-compose down`
- **View logs**: `docker-compose logs -f`
- **View specific service logs**: `docker-compose logs -f suitecrm-php`
- **Restart services**: `docker-compose restart`
- **Rebuild PHP container**: `docker-compose build suitecrm-php`

## Default Credentials

- **MySQL Root Password**: `suitecrmrootpass`
- **MySQL Database**: `suitecrm`
- **MySQL User**: `suitecrm`
- **MySQL Password**: `suitecrmpass`

## Nginx Configuration

The repository includes an example `nginx.conf` file for configuring Nginx to work with SuiteCRM. The configuration is set up with:

- **Server name**: Update `server_name` to match your server IP address or domain name (e.g., `192.168.1.100`, `suitecrm.example.com`)
- **Root path**: `/var/www/html/suitecrm-docker/suitecrm/public` (configured for the `suitecrm-docker` repository location)
- **PHP-FPM**: Configured to connect to PHP-FPM on `127.0.0.1:9000`
- **Upload limit**: 100M

**Important**: Update the `server_name` directive in `nginx.conf` to match your server's IP address or domain name. If your repository is located in a different path, update the `root` directive accordingly.

## File Structure

```
suitecrm-docker/
├── docker-compose.yml    # Docker services configuration
├── Dockerfile            # PHP-FPM container configuration
├── nginx.conf           # Example Nginx configuration (update server_name to your server IP or domain name)
├── uploads.ini          # PHP upload settings
├── setup.sh             # Setup script - downloads SuiteCRM zip and extracts it
└── suitecrm/            # SuiteCRM files (created after running setup.sh)
    └── db/              # MySQL data (created automatically)
```

## Troubleshooting

### Port Already in Use
PHP-FPM is exposed on port 9000. To change the host port, update `docker-compose.yml`:
```yaml
ports:
  - "9001:9000"  # Map host port 9001 to container port 9000
```

### Permission Issues (Linux)
If you encounter permission issues:
```bash
sudo chown -R www-data:www-data ./suitecrm
sudo chmod -R 755 ./suitecrm
```

### Database Connection Issues
Ensure the database container is running:
```bash
docker-compose ps
docker-compose logs suitecrm-db
```

### Clear Everything and Start Fresh
```bash
docker-compose down -v
Remove-Item -Recurse -Force suitecrm  # PowerShell
# or
rm -rf suitecrm  # Bash
./setup.sh
docker-compose up -d
```

## Notes

- After cloning, run `setup.sh` to download the SuiteCRM zip file and extract it
- SuiteCRM files are stored in `./suitecrm/` directory
- Database data is persisted in `./suitecrm/db/` directory
- PHP-FPM is exposed on port 9000 and can be used with a web server (Apache/Nginx) or PHP's built-in server
- The repository includes an example `nginx.conf` - update the `server_name` to match your server IP address or domain name, and adjust the `root` path if your repository location differs
