# flask-env-var
Show Environment Variables in the running container

## Run image
```
# docker run -d -p 8080:5000 --name flask-env-var fsainovich/flask-env-var:0.1
```

## Customize image
### Build image container

After clone repo and made your changes, run the commands bellow (replace path and tag for your docker registry)
```
# docker build -t fsainovich/flask-env-var:0.1 .
# docker login
# docker push fsainovich/flask-env-var:0.1
```
