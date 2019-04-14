#!/usr/bin/env bash

echo "${DOCKER_PASS}" > DOCKER_PASS
cat DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin

echo "Docker Tagging"
docker tag fan0o/dockerdocker fan0o/dockerdocker:prod

echo "Docker push to registry"
docker push fan0o/dockerdocker:prod

echo "success!"

exit 0
