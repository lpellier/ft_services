#!/bin/sh

service docker start
sleep 5
minikube delete
minikube start --driver=docker

./apply_everything.sh

minikube dashboard
