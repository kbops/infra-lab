#!/bin/bash

MODE=$1

if [ "$MODE" == "night" ]; then
  terraform apply -var="node_min_size=0" -var="node_desired_size=0" -auto-approve
elif [ "$MODE" == "day" ]; then
  terraform apply -var="node_min_size=1" -var="node_desired_size=2" -auto-approve
else
  echo "Usage: $0 [night|day]"
fi
