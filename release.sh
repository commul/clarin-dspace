#!/bin/bash
set -e

ERCC_VERSION="${1:-latest}"
UFAL_VERSION="$(git describe --tags --abbrev=0 $(git rev-list --tags --max-count=1 upstream/clarin))"
REPO_BASE="gitlab.inf.unibz.it:4567/commul/docker/clarin-dspace"

# export DOCKER_BUILDKIT=1
REPO_URL="$REPO_BASE/dspace-app/$UFAL_VERSION:$ERCC_VERSION"
docker build \
    --build-arg LABEL_COMMIT_HASH="$(git rev-parse --short HEAD)" \
    --build-arg LABEL_VERSION="${UFAL_VERSION}_${ERCC_VERSION}" \
    --build-arg LABEL_BUILD_DATE="$(date -R)" \
    -t "$REPO_URL" . -f Dockerfile.ercc

docker push "$REPO_URL"

echo "Make sure to change Dockerfile.dspace to point to: $REPO_URL"
