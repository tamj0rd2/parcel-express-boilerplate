#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'
RED='\033[1;31m'
BLUE='\033[1;34m'
DC_FLAGS='--log-level ERROR'

export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

print() {
  echo -e "${1}== ${*:2} ==\033[0m"
}

function finish {
  if [ $? -ne 0 ];
  then print $RED BUILD FAILED
  else print $GREEN BUILD SUCCESS
  fi

  docker-compose $DC_FLAGS down
}
trap finish EXIT

print $BLUE 'stopping services'
docker-compose $DC_FLAGS down

print $BLUE 'running typecheck and lint'
npx concurrently --kill-others-on-fail 'npm:typecheck' 'npm:lint'

print $BLUE 'running unit tests'
docker-compose $DC_FLAGS build -q unit-tests
docker-compose $DC_FLAGS run unit-tests

#== Uncomment this block once we have some cdcs
# print $BLUE 'running cdcs'
# docker-compose $DC_FLAGS build -q --parallel dss-cdc iss-cdc peqs-cdc intel-store-cdc yahoo-cdc
# docker-compose $DC_FLAGS up dss-cdc iss-cdc peqs-cdc intel-store-cdc yahoo-cdc
# CDC_FAIL_COUNT=$(docker-compose ps -q | xargs docker inspect -f '{{ .State.ExitCode }}' | grep -v 0 | wc -l | tr -d '[:space:]')
# if [ $CDC_FAIL_COUNT -ne 0 ]; then exit 1; fi
#==

#== Uncomment this block we have some integration tests
# print $BLUE 'running integration tests'
# docker-compose $DC_FLAGS build -q integration-tests
# docker-compose $DC_FLAGS run integration-tests
#==

print $BLUE 'starting web'
#== dependency services should be added to the below line
# example: docker-compose $DC_FLAGS build -q --parallel web dss iss peqs intel-store yahoo individual
docker-compose $DC_FLAGS build -q --parallel web
docker-compose $DC_FLAGS up -d web
#==

print $BLUE 'running accessibility and acceptance tests'
docker-compose $DC_FLAGS build -q --parallel accessibility-tests acceptance-tests
docker-compose $DC_FLAGS up accessibility-tests acceptance-tests
ENDGAME_FAIL_COUNT=$(docker-compose ps -q | xargs docker inspect -f '{{ .State.ExitCode }}' | grep -v 0 | wc -l | tr -d '[:space:]')
if [ $ENDGAME_FAIL_COUNT -ne 0 ]; then exit 1; fi
