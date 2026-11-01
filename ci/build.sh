#!/bin/bash
# Build the CI base images. Push them afterwards with
#   docker push xqms/ubuntu_texlive:<version>

set -e

cd "$(dirname "$0")"

versions=("$@")
if [[ ${#versions[@]} -eq 0 ]]; then
  versions=(24.04 26.04)
fi

for v in "${versions[@]}"; do
  docker build --pull --build-arg UBUNTU_VERSION=$v -t xqms/ubuntu_texlive:$v .
done
