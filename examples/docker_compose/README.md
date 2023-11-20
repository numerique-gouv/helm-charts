# Example local deployment using docker compose

This is an example deployment that can be used to test and verify the behaviour of a distributed grist deployment locally.
The different dependent services are only configured for ease of use and not security.
It resembles a deployment on a trusted network with a reverse proxy doing SSL termination directing traffic to the `traefik` container.
You're advised to configure you own Redis/PostgreSQL/S3/OpenIDC if you want to use this in production.

## Running the example

```bash
docker compose up
```
Grist will be availabe at [http://grist.docker.localhost:8080](http://grist.docker.localhost:8080).

## Creating a bucket

Upon running this example, the bucket is not created automatically.
You'll need to go to `minio.docker.localhost:9090`, login with `admin`/`adminadmin` and create a bucket called `grist` with versionning enabled.

## Authentication

This example comes with a Keycloak deployment as IDP with a preconfigured realm to test right away.

The available users/passwords are:
- `su`/`su`: superadmin for keycloak, can check and edit realm settings or add users for example
- `admin`/`admin`: configured as default admin of the grist instance, can log into grist
- `user`/`user`: can log into grist
