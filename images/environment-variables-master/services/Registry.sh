#!/bin/sh

export GITHUB_REPO=Registry
export SERVICE_OUTPUT_DIR=services/$GITHUB_REPO
export SERVICE_WRITERS="$sue"
export CHARGEtoID=${projectCode}ABD156
export SOURCE_ORG_REPO=alchemy-registry/documentation
export SERVICE_SLACK_CHANNEL=\#doctopus-registry

export CLI_SOURCE_FILE=container-registry-cli.md
export CLI_REPO=container-registry-cli-plugin
export CLI_REPO_FILE=container-registry-cli.md
