#!/bin/sh

service docker start
sleep 5
minikube delete
minikube start --driver=docker

eval $(minikube docker-env)
KUB_IP=$(minikube ip | cut -c -11)24
kubectl create secret generic kub-ip --from-literal=kub-ip=$KUB_IP

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

#echo $(kubectl get secret kub-ip -o yaml |grep kub-ip |cut -c 10- |head -n1) | base64 --decode


sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/ftps/svc-template.yaml > srcs/ftps/service.yaml
sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/grafana/svc-template.yaml > srcs/grafana/service.yaml
sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/metallb/template-config.yaml > srcs/metallb/metallb-config.yaml
sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/nginx/svc-template.yaml > srcs/nginx/service.yaml
sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/phpmyadmin/svc-template.yaml > srcs/phpmyadmin/service.yaml
sed "s/kub-ip/$(echo $KUB_IP)-$(echo $KUB_IP)/" srcs/wordpress/svc-template.yaml > srcs/wordpress/service.yaml

#sed "s/kub-ip/$(echo $(kubectl get secret kub-ip -o yaml |grep kub-ip |cut -c 10- |head -n1) |base64 --decode)-$(echo $(kubectl get secret kub-ip -o yaml |grep kub-ip |cut -c 10- |head -n1) |base64 --decode)/" srcs/metallb/template-config.yaml > srcs/metallb/metallb-config.yaml

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
