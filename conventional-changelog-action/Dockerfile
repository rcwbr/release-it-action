# FROM ghcr.io/rcwbr/release-it-docker-conventional-changelog:0.1.0 TODO use semver image ref
FROM ghcr.io/rcwbr/release-it-docker-conventional-changelog:main

COPY ./.release-it.json /.release-it.json

ENTRYPOINT [ "bash", "-c", "git config --global --add safe.directory /github/workspace && release-it $@" ]
