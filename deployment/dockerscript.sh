#/bin/bash

docker stop project5
docker rm project5
docker pull ozyozyozy/ceg3120project3:main
docker run -d --name project5 --restart=always -p 80:80 ozyozyozy/ceg3120project3:latest

