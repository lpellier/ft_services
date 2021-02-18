#!/bin/sh

eval $(minikube docker-env)

docker build -t nginx ../nginx
docker build -t mysql ../mysql
docker build -t php-fpm7 ../php-fpm7
docker build -t phpmyadmin ../phpmyadmin
docker build -t wordpress ../wordpress
docker build -t ftps ../ftps
docker build -t influxdb ../influxdb
docker build -t grafana ../grafana

KUB_IP=$(minikube ip | cut -c -11)24
kubectl create secret generic kub-ip --from-literal=kub-ip=$KUB_IP

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

sed "s/kub-ip/$(echo $(kubectl get secret kub-ip -o yaml |grep kub-ip |cut -c 10- |head -n1) |base64 --decode)-$(echo $(kubectl get secret kub-ip -o yaml |grep kub-ip |cut -c 10- |head -n1) |base64 --decode)/" srcs/metallb/template-config.yaml > srcs/metallb/metallb-config.yaml
kubectl apply -f ../metallb/metallb-config.yaml
kubectl apply -k ../mysql
kubectl apply -k ../ftps
sleep 5
kubectl apply -k ../phpmyadmin
kubectl apply -k ../wordpress
sleep 5
kubectl apply -k ../nginx
kubectl apply -k ../influxdb
kubectl apply -k ../grafana

echo "\e[41m\e[93mPlease wait before testing : Wordpress takes at least 10 seconds to setup\e[0m"
echo "\e[41m\e[93mNginx may restart up to three times until it finds pma service\e[0m"

kubectl get pods -w
