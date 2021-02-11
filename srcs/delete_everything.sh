#!/bin/sh

kubectl delete -k nginx
kubectl delete -k mysql
kubectl delete -k phpmyadmin
kubectl delete -k wordpress
kubectl delete -k metallb
kubectl delete -k ftps
kubectl delete -k influxdb
kubectl delete -k grafana
