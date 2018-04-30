#!/usr/bin/env bash

image_name=10.0.0.44:5000/jenkins_springboot


aliimage=$image_name:`TZ=CST-8 date '+%Y%m%d-%H%M'`
echo $aliimage

if [ "`docker images | awk '/^10.0.0.44:5000\/jenkins_springboot/ { print $3 }'`" ]; then
    docker rmi -f $(docker images | awk '/^10.0.0.44:5000\/jenkins_springboot/ { print $3 }' );
fi
mvn clean install -U  -Dmaven.test.skip=true
docker build --no-cache -t $aliimage .
echo "Push Image:" $aliimage " to repository..."
docker push $aliimage
