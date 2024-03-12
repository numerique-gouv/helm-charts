# Description

This folder contains every thing to deploy grist on k8s with [helmfile](https://github.com/helmfile/helmfile) If you want you can use our local-cluster.sh script to setup everything. In order to use this script, you need :

- helm
- helm-diff  (plugin)
- helmfile
- docker
- kind
- mkcert

## How to

Deploy kind cluster:

### First deployment

```
./local-cluster.sh
kubectl -n ingress-nginx wait --for=condition=Available deployment/ingress-nginx-controller --timeout=300s
helmfile sync .
```

### Make a diff

```
helmfile diff .
# To sync 
helmfile sync .
```

### Use local docker image

The ./local-cluster.sh create a local registry. In order to use it, you just need to tag docker image as follow:

```
docker tag gristlabs/grist:1.1.9 localhost:5001/grist:1.1.9
docker push localhost:5001/grist:1.1.9
```

Then change value for the  docker image in the values.grist.yaml  as follow :

```
 image:
   repository: localhost:5001/grist
   pullPolicy: Always
   tag: 1.1.9
```

Then sync with helmfile  :

```
helmfile sync .
```
