#!/bin/sh

minikube start --driver=docker --cpus=3 --memory=3072

./apply_everything.sh

minikube dashboard
