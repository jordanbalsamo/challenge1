# Challenge 1

Requirements of the challenge:

1) Run a docker registry on your machine: docker run -d -p 5000:5000 --restart=always --name registry registry:2
2) Create a simple Hello World web app in a language of your choice;
3) Create a Dockerfile;
4) Create a script that builds an image and pushes it to the registry;
5) Push the image to the registry;
6) Change your app to print a different message;
7) Build another image and push it to the registry;
8) Make sure tags are different and reflect code changes;
9) Write another script that queries the Docker repo and returns the latest image tag;
10) Document in a README your image tagging system;
11) Use IaC / Terraform to deploy image to infra;

Output: git repo containing all work.


## Docker image tagging system 

For this challenge, I've chosen to use a git commit hash based Docker image tagging approach.

What this means is that whenever the docker_build.sh script is run, it will:

1) Build the Dockerfile
2) The Dockerfile will label the image with the latest git commit hash
3) The image will be tagged with the git commit hash

This approach has a a couple of flaws, though:

1) firstly it means an image is generated on every commit (potentially overkill);
2) if a developer makes changes, hasn't commited their code and runs the script, it means that an image could be tagged with an old commit hash.


Ideally, I'd like to set this up with CI/CD pipelines (located in the pipelines directory at root of repo) such that on merge of a feature branch into 'master' or 'dev', the docker_build.sh script (or a more refined version) would be invoked and take the commit hash on merge and tag it as a point in time / version of the docker image.