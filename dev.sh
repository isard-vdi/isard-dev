#!/bin/sh

# Load the environment variables
[ -f .env ] && export $(grep -v '^#' .env | xargs)

if [ -z "$GITLAB_USER" ] || [ "$GITLAB_USER" = "example"  ]; then
    echo "Please, set the configuration values in the '.env' file. You can find a example in the 'env.example' file"
    exit 1
fi

if [ ! "$(docker ps -q -f name=isard-dev)" ]; then
    if [ "$(docker ps -aq -f name=isard-dev -f status=exited)" ]; then
        docker start isard-dev

    else

        docker run --privileged -d \
            --name isard-dev \
            -e DISPLAY=$DISPLAY \
            -e GITLAB_USER="$GITLAB_USER" \
            -e GITLAB_NAME="$GITLAB_NAME" \
            -e GITLAB_EMAIL="$GITLAB_EMAIL" \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -v /dev/kvm:/dev/kvm \
            -v /dev/shm:/dev/shm \
            -v $(pwd)/files:/data/dev \
            isard/dev
    fi

    echo "waiting for the container to start..."
    sleep 60
fi

docker exec -u dev -w /home/dev \
    -ti isard-dev /run/current-system/profile/bin/bash --login
