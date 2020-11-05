#!/usr/bin/env bash

# This script automates the build of the Dockerfile in this repo, tags it and pushes it to a locally-hosted registry.
# Assumes that registry is running: docker run -d -p 5000:5000 --restart=always --name registry registry:2

if [ $# -eq 0 ]; then
    echo "Please provide an image (-i) as a parameter to this script."
    exit 1
fi

while getopts i: option
do
    case "${option}"
    in
        i) IMG=${OPTARG};;
    esac
done

TAG=$(git log -1 --format=%h)

# Pull python image
docker pull python:3.6.1-alpine

# # Build an image from Dockerfile that includes our server code and pass in git commit hash as an image label
docker image build -t "$IMG:$TAG" --build-arg GIT_COMMIT=$TAG ../../

# # Tag the built image locally and prep with registry name for Docker to push to registry
docker tag "$IMG:$TAG" "localhost:5000/$IMG:$TAG"

# # Push locally tagged image to registry
docker push "localhost:5000/$IMG:$TAG"

# # Clean-up local images
#docker image remove "$IMG:$TAG"
docker image remove "localhost:5000/$IMG:$TAG"

# If we wanted to run the container locally, we can create one from image built via Dockerfile and remove once process ends.
docker container run -p 5001:5000 --rm "$IMG:$TAG"
