variable "HOSTNAME" {
  default = ""
}
// HOST for OS compatibility
variable "HOST" {
  default = "${HOSTNAME}"
}

variable "GITHUB_REF_PROTECTED" {
  default = "false"
}
variable "GITHUB_SHA" {
  // If not running in CI, assume local
  default = "local"
}
variable "GITHUB_REF_NAME" {
  // If not executing in GitHub Actions, use a local, host-specific ref
  default = "local-${HOST}"
}
variable "VERSION" {
  // Default the version to the ref from CI, sanitized
  // Replace any non-alphanumeric (or underscore) characters in the ref with dashes
  default = replace(GITHUB_REF_NAME, "/[^[:alnum:]_]/", "-")
}

variable "REGISTRY" {
  default = "ghcr.io/rcwbr/release-it-action"
}

variable "VARIANTS" {
  default = [
    "core"
  ]
}

target "release-it-action" {
  matrix = {
    variant = VARIANTS
  }
  name = "release-it-action-${variant}"
  dockerfile = "${variant}/Dockerfile"
  cache-from = [
    // Always pull cache from main
    "type=registry,ref=${REGISTRY}-${variant}-cache:main",
    "type=registry,ref=${REGISTRY}-${variant}-cache:${VERSION}"
  ]
  cache-to = [
    "type=registry,ref=${REGISTRY}-${variant}-cache:${VERSION}"
  ]
  output = [
    "type=docker,name=release-it-action-${variant}",
    // If running for an unprotected ref (e.g. PRs), append the commit SHA
    (
      "${GITHUB_REF_PROTECTED}" == "true"
      ? "type=registry,name=${REGISTRY}-${variant}:${VERSION}"
      : "type=registry,name=${REGISTRY}-${variant}:${VERSION}-${GITHUB_SHA}"
    )
  ]
}

group "default" {
  targets = [
    for variant in VARIANTS: "release-it-action-${variant}"
  ]
}
