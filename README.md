> ### Weather App
> Simple Phoenix app making use of Dark Sky's weather API to serve weather data.

[![Codeship Status for zac156/weather-app](https://app.codeship.com/projects/ebb464a0-c673-0137-c308-4650a9134f24/status?branch=master)](https://app.codeship.com/projects/367069)

# Instructions to build and run

1. Set your ENV variables in Dockerfile
2. `make build`: builds the Docker image
3. `make run`: runs the Docker image locally

# Tests

1. `make tests`: runs tests inside Docker container (env vars aren't needed for tests)

# Kubernetes

1. `kubectl apply -f k8s/weather-deployment.yaml`
2. `kubectl expose deployment weather --type=LoadBalancer`

# Dev

When using `minikube` run `minikube service weather` to access the service.
