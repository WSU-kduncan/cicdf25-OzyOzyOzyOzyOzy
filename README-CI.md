# Project 4: Documentation

## Continuous Integration Project Overview
- What is the goal of this project
The goal of this project is to gain an understanding of github actions and how they work. A basic github workflow will be created to push images to a public dockerhub repo.
- What tools are used in this project and what are their roles
GitHub actions, secrets, and dockerhub. Git will be used for tagging and repo management. Github actions will be used to set up the required workflows and dockerhub will serve as the testing ground for the workflows.
- Diagram of project


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

### 2. GitHub Actions & DockerHub
#### Configuring GitHub Repository Secrets:
- How to create a PAT for authentication (**and** recommended PAT scope for this project)
Under Account Settings in Dockerhub, select 'Personal Access Tokens". Then create a token with Read/Write scope. Giving an automated workflow delete permissions is a bad idea.
- How to set repository Secrets for use by GitHub Actions
While logged into your repo: Settings -> Security -> Secrets and variables -> Actions -> New repository secret. Name the secret then add the contents. You can call the secrets as a variable in your actions yml files.
- Describe the Secrets set for this project
For this project, my github username and a personal access token specifically made for this project was set in github secrets.
#### CI with GitHub Actions
- Explanation of workflow trigger
The workflow is triggered by a push to the main branch
- Explanation of workflow steps
On push to main, the workflow first uses github checkout to update the repository contents to the most recent push. It then pulls the relevant metadata for docker (in this case, my docker username and the public repo to push to). The workflow then logs in to docker with the username and PAT set in secrets. Finally, the workflow uses the docker action build-push-action to build and push the image to dockerhub.
- Explanation / highlight of values that need updated if used in a different repository
  - changes in workflow
The repository name needs to be changed in the yml file.
  - changes in repository
The only changes required in the repo is to set a PAT for the workflow and set it in the repositories secrets section.
- **Link** to workflow file in your GitHub repository
![Workflow File](.github/workflows/main.yml)
#### Testing & Validating
- How to test that your workflow did its tasking
The easiest solution is to make a superficial push to main. Then check the ativities section to see if the workflow finished successfully. If GitHub reports that the workflow execution was successful, you can then check your dockerhub repo and see when the last build was. If it was successful, it should say there was a recent push/build.
- How to verify that the image in DockerHub works when a container is run using the image
Run the image. Build a container based on the image and check if it works as expected.
- **Link** to your DockerHub repository 
![DockerHub repo](https://hub.docker.com/r/ozyozyozy/ceg3120project3)

### 3. Semantic Versioning
#### Generating `tag`s 
- How to see tags in a `git` repository
'git tag' will list all tags present in a repo.
- How to generate a `tag` in a `git` repository
'git tag "tagName"' ex. 'git tag v1.0' will create tag for the next commit called v1.0.
- How to push a tag in a `git` repository to GitHub
'git push origin "tagName"' or 'git push origin --tags' to push all tags.
#### Semantic Versioning Container Images with GitHub Actions
- Explanation of workflow trigger
This workflow will trigger on any push to main or push with a tag.
- Explanation of workflow steps
The workflow steps from the previous sections still apply. The only difference is now the docker action metadata-action will now organize pushes by semantic version, then perform the rest of the steps as in the previous section.
- Explanation / highlight of values that need updated if used in a different repository
  - changes in workflow
Same changes as before. Change the repository name to match the name you are pushing to.
  - changes in repository
Make sure the PAT for the workflow is correct and in the git repo's secrets.
- **Link** to workflow file in your GitHub repository
![Workflow File](.github/workflows/main.yml)
#### Testing & Validating
- How to test that your workflow did its tasking
Push a commit with a tag set and check workflows on github.
- How to verify that the image in DockerHub works when a container is run using the image
Pull the image and run it in a docker container.
- **Link** to your DockerHub repository with evidence of the tag set
![DockerHub repo](https://hub.docker.com/r/ozyozyozy/ceg3120project3)


### References
- https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets
- git man page
