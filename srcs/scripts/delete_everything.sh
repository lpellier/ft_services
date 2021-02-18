#!/bin/sh

kubectl delete -k ../nginx
kubectl delete -k ../mysql
kubectl delete -k ../phpmyadmin
kubectl delete -k ../wordpress
kubectl delete -f ../metallb/metallb-config.yaml
kubectl delete -k ../ftps
kubectl delete -k ../influxdb
kubectl delete -k ../grafana

kubectl delete all --all
