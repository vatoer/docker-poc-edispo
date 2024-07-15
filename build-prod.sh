#!/bin/bash

# Load .env.nextjs file and export its variables
export $(egrep -v '^#' .env.nextjs | xargs)

# Build the Docker image, passing the environment variables as build arguments
docker build --build-arg BASE_PATH_UPLOAD="$BASE_PATH_UPLOAD" \
             --build-arg BASE_PATH_UPLOAD_KELUAR="$BASE_PATH_UPLOAD_KELUAR" \
             --build-arg BASE_PATH_UPLOAD_MASUK="$BASE_PATH_UPLOAD_MASUK" \
             --build-arg TMP_UPLOAD_PATH="$TMP_UPLOAD_PATH" \
             -t your-image-name .