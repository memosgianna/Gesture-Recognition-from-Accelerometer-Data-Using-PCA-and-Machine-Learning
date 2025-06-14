#!/bin/bash

NETWORK="mynetwork"
MONGO_CONTAINER="mymongo"
JUPYTER_CONTAINER="myjupyter"
JUPYTER_PORT=8888

# Create network if it doesn't exist
if ! docker network ls --format '{{.Name}}' | grep -wq "$NETWORK"; then
    echo "Creating network $NETWORK..."
    docker network create "$NETWORK"
else
    echo "Network $NETWORK already exists."
fi

# Check MongoDB container
if ! docker ps -a --format '{{.Names}}' | grep -wq "$MONGO_CONTAINER"; then
    echo "Creating and starting MongoDB container..."
    docker run -d --name "$MONGO_CONTAINER" --network "$NETWORK" mongo
else
    STATUS=$(docker inspect -f '{{.State.Status}}' "$MONGO_CONTAINER")
    if [ "$STATUS" != "running" ]; then
        echo "Starting existing MongoDB container..."
        docker start "$MONGO_CONTAINER"
    else
        echo "MongoDB container already running."
    fi
fi

# Check Jupyter container
if ! docker ps -a --format '{{.Names}}' | grep -wq "$JUPYTER_CONTAINER"; then
    echo "Creating and starting Jupyter container..."
    docker run -d \
        --name "$JUPYTER_CONTAINER" \
        --network "$NETWORK" \
        -p "$JUPYTER_PORT":8888 \
        -v /home/mhtsaras/iot:/home/jovyan/work \
        jupyter/base-notebook:latest start-notebook.sh --NotebookApp.token=''
else
    STATUS=$(docker inspect -f '{{.State.Status}}' "$JUPYTER_CONTAINER")
    if [ "$STATUS" != "running" ]; then
        echo "Starting existing Jupyter container..."
        docker start "$JUPYTER_CONTAINER"
    else
        echo "Jupyter container already running."
    fi
fi

echo "All set! Access Jupyter at: http://localhost:$JUPYTER_PORT"
echo "MongoDB is running in container: $MONGO_CONTAINER"
