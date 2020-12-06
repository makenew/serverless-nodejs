#!/usr/bin/env bash

set -e
set -u

help () {
  echo
  echo '# This will set all required environment variables on the CircleCI project.'
  echo
  echo '# Supply values to set when prompted.'
  echo '# Values left blank will not be updated.'
  echo
  echo 'Values may also be provided via' \
       'the corresponding environment variable (prefixed with CI_).'
  echo 'Optionally, set NONINTERACTIVE=true to skip all prompts.'
  echo
  echo 'For example, assuming CIRCLE_TOKEN is set in your environment,' \
       'update NPM_TOKEN with'
  echo
  echo '    $ NONINTERACTIVE=true CI_NPM_TOKEN=token .circleci/envvars.sh'
}

help_circleci () {
  echo
  echo '> Get a personal CircleCI API Token at' \
       'https://circleci.com/account/api'
}

help_npm_token () {
  echo
  echo '> Use an npm token with publish permission.'
}

command -v jq >/dev/null 2>&1 || \
  (echo 'jq required: https://stedolan.github.io/jq/' && exit 2)

envvar () {
  name=$1
  value=${2:-}
  if [[ -n $value ]]; then
    if [[ -z $circle_token ]]; then
      echo
      echo 'Error: missing CircleCI token.'
      exit 2
    fi

    curl -X POST \
      --header 'Content-Type: application/json' \
      -u "${circle_token}:" \
      -d '{"name": "'$name'", "value": "'$value'"}' \
      "https://circleci.com/api/v1.1/project/github/${circle_repo}/envvar"
  fi
}

main () {
  noninteractive=$1
  circle_repo=$(jq -r .repository package.json)

  circle_token=${CIRCLE_TOKEN:-}
  [[ -n "${circle_token}" || $noninteractive == 'true' ]] || help_circleci
  if [[ -z $circle_token && $noninteractive != 'true' ]]; then
    read -p '> CircleCI API token (CIRCLE_TOKEN): ' circle_token
  fi

  npm_token=${CI_NPM_TOKEN:-}
  [[ -n "${npm_token}" || $noninteractive == 'true' ]] || help_npm_token
  if [[ -z $npm_token && $noninteractive != 'true' ]]; then
    read -p '> NPM token (NPM_TOKEN): ' npm_token
  fi

  aws_default_region=${CI_AWS_DEFAULT_REGION:-}
  if [[ -z $aws_default_region && $noninteractive != 'true' ]]; then
    read -p '> AWS default region (AWS_DEFAULT_REGION): ' aws_default_region
  fi

  aws_access_key_id=${CI_AWS_ACCESS_KEY_ID:-}
  if [[ -z $aws_access_key_id && $noninteractive != 'true' ]]; then
    read -p '> AWS access key id (AWS_ACCESS_KEY_ID): ' aws_access_key_id
  fi

  aws_secret_access_key=${CI_AWS_SECRET_ACCESS_KEY:-}
  if [[ -z $aws_secret_access_key && $noninteractive != 'true' ]]; then
    read -p '> AWS secret access key (AWS_SECRET_ACCESS_KEY): ' aws_secret_access_key
  fi

  envvar 'NPM_TOKEN' "${npm_token}"
  envvar 'AWS_DEFAULT_REGION' "${aws_default_region}"
  envvar 'AWS_ACCESS_KEY_ID' "${aws_access_key_id}"
  envvar 'AWS_SECRET_ACCESS_KEY' "${aws_secret_access_key}"
}

noninteractive=${NONINTERACTIVE:-false}
if [[ $noninteractive != 'true' ]]; then
  help
fi
main $noninteractive
