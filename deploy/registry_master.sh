#!/usr/bin/env bash

echo "${DOCKER_PASS}" > DOCKER_PASS
cat DOCKER_PASS | docker login --username $DOCKER_USER --password-stdin

echo "Docker Tagging"
docker tag imagebuildinginprocess fan0o/dockerdocker:flask

echo "Docker push to registry"
docker push fan0o/dockerdocker:flask

echo "success!"

exit 0
