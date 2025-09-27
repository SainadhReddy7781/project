# Fitness Tracker - Docker Deployment Guide

This guide explains how to deploy the Fitness Tracker application using Docker Desktop.

## Prerequisites

- Docker Desktop installed and running
- Docker Compose (usually included with Docker Desktop)
- At least 4GB of available RAM
- Ports 3000, 8081, and 3306 available on your system

## Quick Start

### Windows
```bash
# Run the startup script
start-docker.bat
```

### Linux/macOS
```bash
# Make the script executable and run
chmod +x start-docker.sh
./start-docker.sh
```

### Manual Deployment
```bash
# Build and start all services
docker-compose up --build -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f
```

## Services

The application consists of three services:

### 1. MySQL Database (`fitness-mysql`)
- **Port**: 3306
- **Database**: fitnessdb
- **Username**: root
- **Password**: rootpass
- **Health Check**: MySQL ping

### 2. Backend API (`fitness-backend`)
- **Port**: 8081
- **Framework**: Spring Boot
- **Health Check**: http://localhost:8081/actuator/health
- **Dependencies**: MySQL database

### 3. Frontend (`fitness-frontend`)
- **Port**: 3000
- **Framework**: React with Vite
- **Web Server**: Nginx
- **Dependencies**: Backend API

## Access Points

- **Frontend Application**: http://localhost:3000
- **Backend API**: http://localhost:8081
- **API Health Check**: http://localhost:8081/actuator/health
- **MySQL Database**: localhost:3306

## Docker Compose Features

- **Health Checks**: All services have health checks to ensure proper startup order
- **Networking**: Services communicate through a dedicated Docker network
- **Volumes**: MySQL data is persisted in a Docker volume
- **Restart Policy**: Services restart automatically unless stopped manually

## Environment Variables

The backend service uses the following environment variables:

```yaml
SPRING_DATASOURCE_URL: jdbc:mysql://mysql:3306/fitnessdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
SPRING_DATASOURCE_USERNAME: root
SPRING_DATASOURCE_PASSWORD: rootpass
SPRING_JPA_HIBERNATE_DDL_AUTO: update
SPRING_JPA_SHOW_SQL: "true"
SPRING_JPA_PROPERTIES_HIBERNATE_DIALECT: org.hibernate.dialect.MySQL8Dialect
SERVER_PORT: 8081
```

## Troubleshooting

### Services Not Starting
1. Check if Docker Desktop is running
2. Ensure ports 3000, 8081, and 3306 are not in use
3. Check logs: `docker-compose logs [service-name]`

### Database Connection Issues
1. Wait for MySQL to fully start (health check passes)
2. Check if the backend service is waiting for MySQL
3. Verify database credentials in environment variables

### Frontend Not Loading
1. Ensure the backend service is healthy
2. Check if the frontend can reach the backend API
3. Verify the build process completed successfully

### Common Commands

```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: This will delete all data)
docker-compose down -v

# Rebuild specific service
docker-compose up --build -d [service-name]

# View logs for specific service
docker-compose logs -f [service-name]

# Execute commands in running container
docker-compose exec [service-name] [command]

# Check resource usage
docker stats
```

## Development

### Rebuilding After Code Changes
```bash
# Rebuild and restart all services
docker-compose up --build -d

# Rebuild specific service
docker-compose up --build -d [service-name]
```

### Database Access
```bash
# Connect to MySQL container
docker-compose exec mysql mysql -u root -p

# Or use external MySQL client
# Host: localhost
# Port: 3306
# Username: root
# Password: rootpass
# Database: fitnessdb
```

## Production Considerations

For production deployment, consider:

1. **Security**: Change default passwords and use secrets management
2. **SSL/TLS**: Configure HTTPS for the frontend and backend
3. **Database**: Use external managed database service
4. **Monitoring**: Add logging and monitoring solutions
5. **Scaling**: Configure load balancing and horizontal scaling
6. **Backup**: Implement database backup strategies

## Support

If you encounter issues:

1. Check the logs: `docker-compose logs -f`
2. Verify all services are healthy: `docker-compose ps`
3. Ensure Docker Desktop has sufficient resources allocated
4. Check if all required ports are available
