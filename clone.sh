#!/bin/bash

# prepare the environment
echo "Preparing the environment ..."

# Check and create the volumes directory if it doesn't exist
if [ ! -d "volumes" ]; then
    mkdir volumes
fi

cd volumes

# Function to clone a git repository if the directory does not exist
clone_if_not_exist() {
    local dir=$1
    local repo=$2

    if [ ! -d "$dir" ]; then
        mkdir "$dir"
        cd "$dir"
        echo "Cloning $repo from GitHub..."
        git clone "$repo" .
        cd ..
    fi
}

# Clone repositories if their directories do not exist
clone_if_not_exist "poc-mini-fileserver" "https://github.com/vatoer/poc-mini-fileserver.git"
clone_if_not_exist "legacy-edispo" "https://github.com/vatoer/legacy-edispo.git"
clone_if_not_exist "eoffice-perwakilan" "https://github.com/vatoer/eoffice-perwakilan.git"

echo "Environment preparation complete."
