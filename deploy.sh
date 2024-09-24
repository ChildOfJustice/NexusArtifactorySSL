#!/bin/sh
set -e

echo "Generating SSL certificate..."
sh generateCertificate.sh

echo "Building Docker image..."
docker build -t nexus-ssl .

echo "Running Docker container..."
docker run -d -p 8081:8081 -p 8443:8443 nexus-ssl

echo "Done. Nexus is running with SSL configuration. HTTP: 8081, HTTPS: 8443"