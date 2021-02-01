#!/bin/sh

minikube start --driver=docker

eval $(minikube docker-env)
minikube -p minikube docker-env

./apply_everything.sh

minikube dashboard
