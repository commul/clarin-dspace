#!/bin/bash
set -e

# FIXME: run tests (at least, autocheck syntax...)
# FIXME: make sure all changes are commited into the repository
# FIXME: (automatically) increase .version

ERCC_TAG="$(git describe --tags --abbrev=0 $(git rev-list --tags --max-count=1))"
ERCC_VERSION="${ERCC_TAG:-latest}"
UFAL_VERSION="$(git describe --tags --abbrev=0 $(git tag --list --sort="-creatordate" --merged clarin | head -n1))"
VERSION="$UFAL_VERSION:$ERCC_VERSION"

REPO_BASE="gitlab.inf.unibz.it:4567/commul/docker/clarin-dspace"
REPO_URL="$REPO_BASE/dspace-app/$VERSION"

echo "About to build: $REPO_URL"
read -p "Press enter to continue"

# export DOCKER_BUILDKIT=1
docker build \
    --build-arg LABEL_COMMIT_HASH="$(git rev-parse --short HEAD)" \
    --build-arg LABEL_VERSION="${UFAL_VERSION}_${ERCC_VERSION}" \
    --build-arg LABEL_BUILD_DATE="$(date -R)" \
    -t "$REPO_URL" . -f Dockerfile.ercc

docker push "$REPO_URL"

echo "Make sure to change Dockerfile.dspace to point to: $REPO_URL"
echo "$VERSION" > .version
