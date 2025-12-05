# Project 5 documentation  

## Description
#### Continuous Deployment Project Overview
- What is the goal of this project  
The goal of this project is to learn about webhooks and succesfully deploy a webhook that only triggers on dockerhub image builds tagged `latest`.
- What tools are used in this project and what are their roles  
git, docker, adnanh's webhook, and github actions are the main tools used for this project. Git is is used for github management, github actions invoke the container build and therefore the webhook, and docker is used to host the container along with dockerhub hosting the image and managing the webhook. Adnanh's webhook is the required webhook to use for this project.   
- Diagram of project  
![Diagram](/images/diagram5.png)

## Part 1 - Script a Refresh Documentation  
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

## Part 2 - Listen Documentation
#### 1. Configuring a `webhook` Listener on EC2 Instance
- How to install [adnanh's `webhook`](https://github.com/adnanh/webhook) to the EC2 instance  
`apt install webhook`
- How to verify successful installation  
After configuring webhook as according to the documentation, run `webhook` with `$ /path/to/webhook -hooks hooks.json -verbose`. If this returns a http endpoint for the webhook.  
- Summary of the `webhook` definition file  
The webhook definition file checks the payload of an incoming webhook for a push to the dockerhub repo. If found, it will then execute dockerscript.sh which will take down and redeploy the container with the new image.
- How to verify definition file was loaded by `webhook`  
journalctl will report whether the configuration file was loaded. `journalctl -u webhook --since="today"'
- How to verify `webhook` is receiving payloads that trigger it  
Use the previous journalctl to monitor whether the webhook received the payload.
  - how to monitor logs from running `webhook`  
`journalctl -u webhook --since="today"`
  - what to look for in `docker` process views  
Docker process views should show the same image ID as what is reported in dockerhub.
- **LINK to definition file** in repository  
![Hooks definition file](/deployment/hooks.yaml)
#### 2. Configure a `webhook` Service on EC2 Instance 
- Summary of `webhook` service file contents  
The service file tells the hook to listen on port 9000 for any IP. It also has definitions in place to read from hooks.yaml for the correct configuration for the hook. My file also sets what user/group the webhook should run as.
- How to `enable` and `start` the `webhook` service  
use `systemctl enable --now webhook`
- How to verify `webhook` service is capturing payloads and triggering bash script  
The simplest way to verify the webhook service is running is to use a combination of journalctl and curl. For example, `curl http://localhost:9000/hooks/hook-id` will test the hook and if verbose mode is on, will report whether or not the hook was triggered. If the hooks definition file is set correctly, it should report that the hook was receieved but the script did not run.
- **LINK to service file** in repository  
![Hooks service file](/deployment/webhook.service)  

## Part 3 - Send a Payload Documentation
#### 1. Configuring a Payload Sender
- Justification for selecting GitHub or DockerHub as the payload sender  
Due to github automatically triggering a docker image build on push, I chose dockerhub. In my mind, there is no reason to build extra rules for github when the project depends on the latest pushed image in the dockerhub repo
- How to enable your selection to send payloads to the EC2 `webhook` listener  
Create the webhook in dockerhub, then push to the github repo.
- Explain what triggers will send a payload to the EC2 `webhook` listener  
The only trigger to send a payload is a build with the `latest` tag. This will send out the webhook response.
- How to verify a successful payload delivery  
Watch the logs of the webhook. On succesful payload delivery, the webhook will create a log entry stating so.
- How to validate that your webhook *only triggers* when requests are coming from appropriate sources (GitHub or DockerHub)  
Curl is a good tool for this. It will attempt to trigger the webhook but sending traffic on the specified port, which is then analyzed by the webhook. If the proper conditions are not met, then the webhook will not execute the script. If there was a misconfiguration in the script, the webhook would execute the script from just using curl to invoke the webhook.

