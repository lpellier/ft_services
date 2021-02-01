#!/bin/sh


docker build -t nginx nginx
docker build -t mysql mysql
docker build -t phpmyadmin phpmyadmin
docker build -t wordpress wordpress

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -k metallb
kubectl apply -k nginx
kubectl apply -k mysql
kubectl apply -k phpmyadmin
kubectl apply -k wordpress
