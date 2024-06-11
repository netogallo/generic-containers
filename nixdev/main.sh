#!/bin/bash

_term() {
  echo "Caught SIGTERM signal!"
  kill "$MAIN_LOOP_PID"
}

trap _term SIGTERM


## Run the main loop
sleep infinity &
MAIN_LOOP_PID=$!
wait $MAIN_LOOP_PID
