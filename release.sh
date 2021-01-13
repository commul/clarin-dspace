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

# export DOCKER_BUILDKIT=1
docker build \
    --label org.label-schema.version="${UFAL_VERSION}:${ERCC_VERSION}" \
    --label org.label-schema.build-date="$(date -R)" \
    --label org.label-schema.vcs-url="$REPO" \
    --label org.label-schema.registry-overview-url="https://gitlab.inf.unibz.it/commul/docker/clarin-dspace/container_registry" \
    --label org.label-schema.commit-hash="$(git rev-parse --short HEAD)" \
    -t "$IMAGE_BASE_URL" . -f Dockerfile.ercc

DOCKER_HASH="$(docker image ls "$IMAGE_BASE_URL" --format "{{.ID}}" | head -n1)"
docker tag "$DOCKER_HASH" "$IMAGE_BASE_URL:$ERCC_VERSION"
docker tag "$DOCKER_HASH" "$IMAGE_BASE_URL:latest"
docker push "$IMAGE_BASE_URL:$ERCC_VERSION"
docker push "$IMAGE_BASE_URL:latest"

echo "Make sure to change Dockerfile.dspace to point to: $IMAGE_URL"
echo "$VERSION" > .version
