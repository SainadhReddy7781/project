#!/bin/bash

# Fitness Tracker Docker Startup Script
echo "Starting Fitness Tracker Application with Docker Compose..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker Desktop and try again."
    exit 1
fi

# Check if Docker Compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed or not in PATH."
    exit 1
fi

# Stop any existing containers
echo "Stopping any existing containers..."
docker-compose down

# Remove any existing images to force rebuild
echo "Removing existing images..."
docker-compose down --rmi all

# Build and start the services
echo "Building and starting services..."
docker-compose up --build -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 30

# Check service status
echo "Checking service status..."
docker-compose ps

# Display access information
echo ""
echo "=========================================="
echo "Fitness Tracker Application is running!"
echo "=========================================="
echo "Frontend: http://localhost:3000"
echo "Backend API: http://localhost:8081"
echo "MySQL: localhost:3306"
echo ""
echo "To view logs: docker-compose logs -f"
echo "To stop: docker-compose down"
echo "=========================================="
