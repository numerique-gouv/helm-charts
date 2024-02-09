### Plane Helm Setup
---

Follow below steps to setup **Plane**

Basic Install
```
helm install \
    --create-namespace \
    --namespace plane-ns \
    --set ingress.host="plane.example.com" \
    my-plane makeplane/plane-ce
```

Customise Remote Postgress URL
```
    --set postgres.local_setup=false \
    --set env.pgdb_remote_url="postgress://[username]:[password]@[pg-host]/[db-name]" \
```

Customise Remote Redis URL
```
    --set redis.local_setup=false \
    --set env.remote_redis_url="redis://[redis-host]:[6379]" \
```


Customise SMTP using 
```
    --set smtp.host="smtp.example.com" \
    --set smtp.user="my-email-address@example.com" \
    --set smtp.password="my-password" \
    --set smtp.from="Plane Mailer <mailer@example.com>" \
    --set smtp.port=587 \
    --set smtp.use_tls=1 \

```


helm install \
    --create-namespace \
    --namespace plane-test \
    --set ingress.host="test.example.com" \
    plane-test ./plane-charts -f ./plane-charts/values.yaml