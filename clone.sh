#!/bin/bash

# prepare the environment
echo "Preparing the environment ..."

# Check and create the volumes directory if it doesn't exist
if [ ! -d "volumes" ]; then
    mkdir volumes
fi

cd volumes

# Function to clone a git repository if the directory does not exist, or pull if it does
clone_or_pull() {
    local dir=$1
    local repo=$2

    if [ ! -d "$dir" ]; then
        echo "Directory $dir does not exist. Cloning $repo..."
        mkdir -p "$dir" && cd "$dir"
        git clone "$repo" .
        cd ..
    else
        echo "Directory $dir exists. Pulling latest changes from $repo..."
        cd "$dir"
        git pull
        cd ..
    fi
}

# Clone or pull repositories
clone_or_pull "poc-mini-fileserver" "https://github.com/vatoer/poc-mini-fileserver.git"
clone_or_pull "legacy-edispo" "https://github.com/vatoer/legacy-edispo.git"
clone_or_pull "eoffice" "https://github.com/vatoer/eoffice-perwakilan-docker.git"

echo "Environment preparation complete."
