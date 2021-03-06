#!/bin/sh

service docker start
sleep 5
minikube delete
minikube start --driver=docker

eval $(minikube docker-env)

minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable metallb

kubectl get configmap kube-proxy -n kube-system -o yaml |sed -e "s/strictARP: false/strictARP: true/" |kubectl apply -f - -n kube-system
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

docker build -t nginx srcs/nginx --network=host
docker build -t mysql srcs/mysql --network=host
docker build -t php-fpm7 srcs/php-fpm7 --network=host
docker build -t phpmyadmin srcs/phpmyadmin --network=host
docker build -t wordpress srcs/wordpress --network=host
docker build -t ftps srcs/ftps --network=host
docker build -t influxdb srcs/influxdb --network=host
docker build -t grafana srcs/grafana --network=host

# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"


kubectl apply -f srcs/metallb/metallb-config.yaml
kubectl apply -k srcs/mysql
kubectl apply -k srcs/ftps
sleep 5
kubectl apply -k srcs/phpmyadmin
kubectl apply -k srcs/wordpress
sleep 5
kubectl apply -k srcs/nginx
kubectl apply -k srcs/influxdb
kubectl apply -k srcs/grafana

echo "\e[41m\e[93mPlease wait before testing : Wordpress takes at least 10 seconds to setup\e[0m"
echo "\e[41m\e[93mNginx may restart up to three times until it finds pma service\e[0m"

kubectl get svc
kubectl get pods -w

minikube dashboard
