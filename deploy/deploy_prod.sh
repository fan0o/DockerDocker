#!/usr/bin/env bash

echo "Creating Logs"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker logs dockerdockerprod > /root/logs-archive/dockerdocker-prod_`date +%Y%m%d-%H%M%S`.log'

echo "stopping running live application"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker stop dockerdockerprod'
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker rm dockerdockerprod'

ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker rmi fan0o/dockerdocker:prod'

ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker login -u ' $DOCKER_USER ' -p ' $DOCKER_PASS ''

echo "pulling latest version of the code"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'sudo docker pull fan0o/dockerdocker:prod'

echo "starting the new live version"
ssh $DEPLOY_USER@$DEPLOY_HOST_MASTER 'docker  run -d -p 8000:80 --restart=always --name dockerdockerprod fan0o/dockerdocker:prod'

echo "success!"

exit 0
