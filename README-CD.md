#Project 5 documentation  

##Part 1 - Script a Refresh Documentation  
#### 1. EC2 Instance Details
    - AMI information  
Ubuntu 24.04lts AMI ID: `ami-0ecb62995f68bb549`  
    - Instance type  
T2-Medium
    - Recommended volume size  
30GB
    - Security Group configuration  
Limit SSH traffic to a set of trusted IPs  
Allow HTTPS & HTTP traffic from anywhere  
    - Security Group configuration justification / explanation  
Since this is a web server, you are going to need access to http/s from anywhere to allow you to properly use the website. For security purposes, limiting SSH access is always reccomended.

#### 2. Docker Setup on OS on the EC2 instance
    - How to install Docker for OS on the EC2 instance  
```
apt install docker.io
systemctl enable --now docker
```
    - Additional dependencies based on OS on the EC2 instance  
git is the other reccomended package, however is should not end up used in this project (or at least not on the container instance).  
    - How to confirm Docker is installed and that OS on the EC2 instance can successfully run containers  
`docker run hello-world`: This will run a hello world container that will show whether or not docker is installed properly.  
#### 3. Testing on EC2 Instance  
    - How to pull container image from DockerHub repository  
`git pull ozyozyozy/ceg3120project3`
    - How to run container from image  
`docker run -d --name project5 --restart=always -p 80:80 ozyozyozy/ceg3120project3:latest`  
    - How to verify that the container is successfully serving the web application  
Go to your browser and enter `<IPOfHostSystem>:80`  

#### 4. Scripting Container Application Refresh
    - Description of the bash script  
The script `dockersript.sh` is a simple bash script that stops and removes the already running container, then recreates the container after pulling the latest image from ozyozyozy/ceg3120project3.  
    - How to test / verify that the script successfully performs its taskings  
Run the script. Please note that the user that executes the script must be a member of the `docker` group or the script will have to be run with sudo priveleges.  
    - **LINK to bash script** in repository
![Bash Script](/deployment/dockerscript.sh)
