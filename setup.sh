#!/bin/bash

# sudo groupadd docker
# sudo usermod -aG docker $USER
# su $USER
minikube start --cpus=4 --driver=docker
eval $(minikube docker-env)
docker build -t nginx nginx/
kubectl apply -f nginx/nginx-deployment.yaml
kubectl expose deployment nginx-deployment --type=LoadBalancer
minikube service nginx-deployment