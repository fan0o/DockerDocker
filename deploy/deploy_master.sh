#!/usr/bin/env bash

echo "Creating Logs"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker logs dockerdocker > /home/ubuntu/logs-archive/dockerdocker-dev_`date +%Y%m%d-%H%M%S`.log'

echo "stopping running live application"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker stop dockerdocker'
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker rm dockerdocker'

ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker rmi fan0o/dockerdocker'

ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker login -u ' $DOCKER_USER ' -p ' $DOCKER_PASS ''

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker pull fan0o/dockerdocker:flask'

echo "starting the new live version"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'docker  run -d -p 4000:80 --restart=always --name dockerdocker fan0o/dockerdocker'

echo "success!"

exit 0
