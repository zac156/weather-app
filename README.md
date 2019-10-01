# Instructions to build and run

1. make build
2. make run
3. make tests

# Kubernetes

1. kubectl apply -f k8s/weather-deployment.yaml
2. kubectl expose deployment weather --type=LoadBalancer

# Dev

When using `minikube` run `minikube service weather` to access the service.
