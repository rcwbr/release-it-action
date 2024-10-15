# FROM ghcr.io/rcwbr/release-it-docker-conventional-changelog:0.1.0 TODO use semver image ref
FROM ghcr.io/rcwbr/release-it-docker-conventional-changelog:main

COPY ./.release-it.json /.release-it.json

RUN npm install --global conventional-changelog-cli
ENTRYPOINT [ "bash", "-c", "git config --global --add safe.directory /github/workspace && conventional-changelog --preset conventionalcommits" ]
