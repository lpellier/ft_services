#!/bin/sh

minikube start --driver=docker --cpus=4

eval $(minikube docker-env)
minikube -p minikube docker-env

docker build -t nginx nginx/
docker build -t mysql mysql/
docker build -t wordpress wordpress/

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -k .

minikube dashboard