# THIS IS A GENERATED FILE! See Earthfile.d/ for details.
#
# Usage: earthly --push --no-cache +docker

docker-precondition:
    FROM alpine:latest
    ARG UFAL_VERSION
    RUN --no-cache test -n "$UFAL_VERSION" || (echo "Use --build-arg UFAL_VERSION=\$(git describe --tags --abbrev=0 \$(git tag --list --sort='-creatordate' --merged clarin | head -n1))" && false )

docker-from-docker:
    FROM DOCKERFILE .
    ARG DOCKER_BASE_URL="gitlab.inf.unibz.it:4567"
    ARG EARTHLY_GIT_PROJECT_NAME  # https://docs.earthly.dev/earthfile/builtin-args
    ARG GIT_PROJECT_NAME="commul/docker/clarin-dspace"
    ARG COMMUL_REGISTRY_URL="https://gitlab.inf.unibz.it/commul/docker/clarin-dspace/container_registry/"
    ARG LABEL_VCS_URL="https://github.com/commul/clarin-dspace"

    ARG AUTHOR="Egon W. Stemle <egon.stemle@eurac.edu>"
    ARG MAINTAINER="Egon W. Stemle <egon.stemle@eurac.edu>"
    LABEL author="$AUTHOR"
    LABEL maintainer="$MAINTAINER"

    # An updated VERSION ARG triggers an update of the texlive installation
    ARG EARTHLY_TARGET_TAG
    ARG VERSION=$EARTHLY_TARGET_TAG

    ARG UFAL_VERSION
    ARG EARTHLY_GIT_HASH
    ARG GIT_HASH=$EARTHLY_GIT_HASH
    ARG EARTHLY_TARGET_TAG_DOCKER
    ARG TARGET_TAG_DOCKER=$EARTHLY_TARGET_TAG_DOCKER
    ARG DOCKER_URL="$DOCKER_BASE_URL/$GIT_PROJECT_NAME/dspace-app/$UFAL_VERSION"

    LABEL org.label-schema.schema-version="1.0" \  # http://label-schema.org/rc1/
          org.label-schema.version="$VERSION" \
          org.label-schema.vcs-url="$LABEL_VCS_URL" \
          org.commul.git-hash="$GIT_HASH" \
          org.commul.registry-url="$COMMUL_REGISTRY_URL" \
          org.commul.docker-url="$DOCKER_URL"

    RUN echo $VERSION > /tmp/release
    SAVE ARTIFACT --keep-ts /tmp/release AS LOCAL ./.release

    SAVE IMAGE dspace-app:latest
    SAVE IMAGE --push "$DOCKER_URL:latest"
    SAVE IMAGE --push "$DOCKER_URL:$VERSION"

docker:
    BUILD +docker-precondition
    BUILD +docker-from-docker
