# Kubernetes
## Install minikube and kubectl

### MacOS

`curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

`curl -LO  https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/`

### Linux

`curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.23.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

`curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/`

## Start a minikube cluster on MacOS

### Enable Heapster and Ingress

`minikube addons enable heapster; minikube addons enable ingress`

## Start a minikube cluster on Linux

`minikube start --memory=4096`

### Create cluster on MacOS

`minikube start --memory=8192 --vm-driver=xhyve`

### Create dashboard

`minikube service kubernetes-dashboard --namespace kube-system`

### Create Nginx proxy

`kubectl run nginx --image nginx --port 80`

### Expose the proxy

`kubectl expose deployment nginx --type NodePort --port 80`

### Open in browser

`minikube service nginx`

# Deploy CI/CD Pipeline

[Tutorial](https://www.linux.com/blog/learn/chapter/Intro-to-Kubernetes/2017/5/set-cicd-pipeline-kubernetes-part-1-overview)

`git clone git@github.com:wjax2017/kubernetes-ci-cd.git`

`cd kubernetes-ci-cd`

`kubectl apply -f manifests/registry.yml`

`kubectl rollout status deployments/registry`

`minikube service registry-ui`

`docker build -t 127.0.0.1:30400/hello-kenzan:latest -f applications/hello-kenzan/Dockerfile applications/hello-kenzan`

`docker stop socat-registry`

`docker rm socat-registry`

`docker run -d -e "REGIP=`minikube ip`" --name socat-registry -p 30400:5000 chadmoon/socat:latest bash -c "socat TCP4-LISTEN:5000,fork,reuseaddr TCP4:`minikube ip`:30400"`

`docker push 127.0.0.1:30400/hello-kenzan:latest`

## Deploy the app

`kubectl apply -f applications/hello-kenzan/k8s/deployment.yaml`

`minikube service hello-kenzan`

## Deploy the pipeline

`kubectl apply -f manifests/jenkins.yml`

`kubectl rollout status deployment/jenkins`

## Setup a StatefulSet for Postgresql

Show postgresql directory

## Create namespace to postgresql

`kubectl create namespae postgresql`

## Deploy stuff

`./run.sh`