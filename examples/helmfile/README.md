# Description

This folder contains every thing to deploy grist on k8s with [helmfile](https://github.com/helmfile/helmfile)

## How to

For instance you can use it with minikube :

### First deployment

```
minikube start --cpus='4' --memory='8g'
kubectl create namespace grist
helmfile sync .
```

### Make a diff

```
export PASSWORD=$(kubectl get secret --namespace "grist" keycloak-postgresql -o jsonpath="{.data.password}" | base64 -d)
helmfile diff . --set global.postgresql.auth.password=$password
# To sync 
helmfile sync . --set global.postgresql.auth.password=$PASSWORD
```

