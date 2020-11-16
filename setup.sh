#!/bin/bash

sudo groupadd docker
sudo usermod -aG docker $USER
su $USER
docker start minikube --driver=docker
