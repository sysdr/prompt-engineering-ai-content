#!/bin/bash
# Stop and clean up Day 1 Token Estimator Docker resources
CONTAINER_NAME="token-estimator-instance"
IMAGE_NAME="token-estimator-day1"

echo "Stopping container (if running)..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true
echo "Container cleaned up."
echo "To remove the image: docker rmi $IMAGE_NAME"
