# Kubernetes/Minikube Implementation
## Instructions for MacOS

Ensure Docker Desktop is running

Ensure Minikube is running - `minikube start`

From root directory of this project, push the Docker image to the Minikube cluster:

```eval $(minikube docker-env) && docker build --no-cache -t pw/crudservice:latest ./service/```

or

```minikube cache add pw/crudservice:latest```

Apply the Kubernetes manifests to deploy the application, Redis server, and expose the services:

```
kubectl apply -f redis.yaml
kubectl apply -f config.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

Determine the Nodeport that the application is exposed on:

```
export NODE_PORT=$(kubectl get services/pw-service -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
```

Use the following command to return the URL for the service:

```
minikube service pw-service --url
```

Example output is `http://127.0.0.1:56689`
Similar to the non-Kubernetes deployment, the application would then be viewed at `http://127.0.0.1:56689/pw` and the swagger docs at `http://127.0.0.1:56689/docs`
Using the swagger docs to make a POST, for example `k2` and `v2` for key,value respectively) and view the result at `http://127.0.0.1:56689/pw/k2`
