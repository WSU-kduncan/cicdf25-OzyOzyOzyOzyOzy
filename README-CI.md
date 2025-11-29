# Project 4: Documentation

### 1. Docker file and Building Images
- Web contents can be found here -> ![web-content](/web-content)
- Docker file can be found here -> ![DockerFile](/web-content/Dockerfile)
#### Explanation of web-contents
The website that the docker image hosts is a very simple test website with no functionality. It is only there to prove the container is working.
#### Explanation of Docker File
The dockerfile simply pulls the httpd container image and then adds the web-contents folder contents to the apache root directory within the container.
#### How to build image from Docker File
'cd' into the directory containing the docker file (so web-content), then:
```
docker build -t name-of-image:latest .
```
This will build an image with the name you set and tag it as `latest`.
Tagging requirements: `docker tag name-of-image:latest myusername/my-repo:latest`
The image must be tagged with the relevant name and username/reponame that it belongs to. Customize the above command to your needs to tag the image to your repo.
#### How to run a container using the image from this project
```
docker pull ozyozyozy/ceg3120project3:latest
docker run -d --restart=always -p 80:80 ozyozyozy/ceg3120project3:latest
```

### 2.GitHub Actions & DockerHub

