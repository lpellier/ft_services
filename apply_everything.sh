#!/bin/sh

eval $(minikube docker-env)

docker build -t nginx nginx
docker build -t mysql mysql
docker build -t php-fpm7 php-fpm7
docker build -t phpmyadmin phpmyadmin
docker build -t wordpress wordpress

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -k metallb
kubectl apply -k mysql
sleep 5
kubectl apply -k phpmyadmin
kubectl apply -k wordpress
sleep 5
kubectl apply -k nginx

echo "\e[41m\e[93mPlease wait before testing : Wordpress takes at least 10 seconds to setup\e[0m"
echo "\e[41m\e[93mNginx may restart up to three times until it finds pma service\e[0m"

kubectl get pods -w
