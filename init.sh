#!/bin/sh

minikube start --driver=docker --cpus=4

eval $(minikube docker-env)

docker build -t nginx nginx/
docker build -t mysql mysql/
docker build -t wordpress wordpress/

kubectl apply -k ./

minikube dashboard