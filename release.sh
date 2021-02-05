#!/bin/bash
set -e

# FIXME: run tests (at least, autocheck syntax...)
# FIXME: make sure all changes are commited into the repository
# FIXME: (automatically) increase .version

ERCC_TAG="$(git describe --tags --abbrev=0 $(git rev-list --tags --max-count=1))"
ERCC_VERSION="${ERCC_TAG:-latest}"
UFAL_VERSION="$(git describe --tags --abbrev=0 $(git tag --list --sort="-creatordate" --merged clarin | head -n1))"

REPO="https://github.com/commul/clarin-dspace"
REGISTRY_BASE="gitlab.inf.unibz.it:4567/commul/docker/clarin-dspace/dspace-app"
IMAGE_BASE_URL="$REGISTRY_BASE/$UFAL_VERSION"

echo "About to build: $IMAGE_BASE_URL:$ERCC_VERSION"
read -p "Press enter to continue"

earthly --push \
    --build-arg UFAL_VERSION="$UFAL_VERSION" \
    --build-arg VERSION="$ERCC_VERSION" \
    --build-arg LABEL_VCS_URL="$REPO" \
    --build-arg DOCKER_URL="$IMAGE_BASE_URL" \
    +docker

echo "Make sure to change Dockerfile.dspace to point to: $IMAGE_URL"
