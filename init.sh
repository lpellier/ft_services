#!/bin/sh

minikube start --driver=docker

./apply_everything.sh

minikube dashboard
