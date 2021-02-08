#!/bin/sh

service docker start
sleep 5
minikube delete
minikube start --driver=docker --cpus=3 --memory=3072

./apply_everything.sh

minikube dashboard
