#!/usr/bin/env bash
# This script queries the private registry and pulls the latest tag name.
# Requires jq - a simple JSON parsing utility.
# Simply pass in the repo name as the first parameter when calling the script.
# Assumes we want the most recent non-'latest' tag at position 1: https://blog.container-solutions.com/docker-latest-confusion

# REPO=$1

if [ $# -eq 0 ]; then
    echo "Please provide a repo with a flag (-r) when invoking this scipt."
    exit 1
fi

while getopts r: option
do
    case "${option}"
    in
        r) REPO=${OPTARG};;
    esac
done

echo Querying registry tags for $REPO repo:
curl -s http://localhost:5000/v2/$REPO/tags/list | jq -r .tags[1]
