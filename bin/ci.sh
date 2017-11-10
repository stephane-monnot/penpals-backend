#!/bin/sh

# --build: Build images before starting containers.
# --abort-on-container-exit: Stops all containers if any container is stopped
docker-compose -f "docker-compose.yml" -f "docker-compose.ci.yml" up --build --abort-on-container-exit
