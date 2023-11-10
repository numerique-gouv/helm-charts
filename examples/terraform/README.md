# Example local deployment on Kubernetes Minikube using Terraform

This is an example deployment that can be used to test and verify the behaviour of a distributed grist deployment locally.
The different dependent services are only configured for ease of use and not security.
You're advised to configure you own Redis/PostgreSQL/S3/OpenIDC if you want to use this in production.

## Setting up TLS

This example relies on a self-signed TLS Cert and CA to allow using HTTPS when browsing the service deployed on minikube.
To set this up on your own:
- Download [mkcert](https://github.com/FiloSottile/mkcert)
- Run `mkcert -install` and `mkcert minikube.local "*.minikube.local"`
- Run `minikube addons enable ingress`
- Create a secret on minikube with this certificate using `kubectl -n kube-system create secret tls mkcert --key minikube.local+1-key.pem --cert minikube.local+1.pem;`
- Edit `$HOME/.minikube/profiles/minikube/config.json` to set the key `.KubernetesConfig.CustomIngressCert` to the secret's name `kube-system/mkcert`
- Run `minikube addons disable ingress ; minikube addons enable ingress`
- Run `minikube ip` and add the IP to your `/etc/hosts` with the domains `grist.minikube.local`, `mc.minikube.local` and `keycloak.minikube.local`

## Running the example

```bash
export KUBE_CONFIG_PATH=/path/to/your/minikube/kubeconfig # Usually $HOME/.kube/config
terraform plan -out=plan.tfplan
# check that the plan looks right before continuing
terraform apply plan.tfplan
```
Grist will be availabe at [https://grist.minikube.local](https://grist.minikube.local).

## Authentication

This example comes with a Keycloak deployment as IDP with a preconfigured realm to test right away.

The available users/passwords are:
- `su`/`su`: superadmin for keycloak, can check and edit realm settings or add users for example
- `admin`/`admin`: configured as default admin of the grist instance, can log into grist
- `user`/`user`: can log into grist
