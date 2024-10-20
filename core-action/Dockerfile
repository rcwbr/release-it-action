# FROM ghcr.io/rcwbr/release-it-docker:0.1.0 TODO convert to semver ref
FROM ghcr.io/rcwbr/release-it-docker:main

COPY .release-it.json /.release-it.json
COPY entrypoint /entrypoint

ENTRYPOINT [ "bash", "/entrypoint" ]
