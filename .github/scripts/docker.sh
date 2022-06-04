#!/usr/bin/env bash
set -eux
set -o pipefail


function pull() {
  docker pull ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}:${VERSION}
}

function build() {
  docker build -t ${SERVICE_NAME} .

}

function tag() {
  docker tag ${SERVICE_NAME} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}:latest
  docker tag ${SERVICE_NAME} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}:${VERSION}

}

function push() {
  docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}:latest
  docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${SERVICE_NAME}:${VERSION}
}

function main() {
  if ! pull; then
    build
    tag
    push
  fi

}

main
