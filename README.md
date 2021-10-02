# Alpine NINJAM Server container

![GitHub commits since tagged version](https://img.shields.io/github/commits-since/justinfrankel/ninjam/c7dec4de?label=commits%20on%20ninjam%20repo%20since%20last%20build&style=flat-square)

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/uzer/ninjamserver/latest?style=flat-square)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/uzer/ninjamserver/latest?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/uzer/ninjamserver?style=flat-square)

Small alpine container for Ninjam server.

Project URLs:
[Official Website](https://www-dev.cockos.com/ninjam/) |
[Dockerhub](https://hub.docker.com/r/uzer/ninjamserver) |
[Github (Dockerfiles + Samples)](https://github.com/uZer/docker-ninjamserver)


## Usage

1) Clone the repository

2) Edit the example configuration file according to your needs.
   Please change the admin password `myadminpass` to something else!

3) Run:

   ```
   $ docker-compose up
   ```

   Container port will get exposed on your host.


## Kubernetes example

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: ninjam
  labels:
    app: ninjam
spec:
  selector:
    app: ninjam
  ports:
    - name: ninjam
      port: 2049
      targetPort: ninjam
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ninjam
  labels:
    app: ninjam
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ninjam
  template:
    metadata:
      labels:
        app: ninjam
    spec:
      containers:
        - name: ninjam
          image: uzer/ninjamserver:latest
          imagePullPolicy: Always
          ports:
          - containerPort: 2049
            name: ninjam
          volumeMounts:
            - mountPath: /app
              name: ninjam-config
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 400m
              memory: 128Gi
      volumes:
        - name: ninjam-config
          hostPath:
            path: "/config/ninjamserver/ninjam-config/"
            type: DirectoryOrCreate
```
