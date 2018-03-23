#!/bin/bash
# $0 is the script name, $1 id the first ARG, $2 is second...
# <number_of_controllers> is needed due to ros adding extra arguments to the script call

if [ "$#" = 1 ]
then
  echo "Usage: $0 <namespace> <number_of_controllers> <controller_1_name> <controller_2_name> ... <controler_n_name>"
else
  NAMESPACE="$1"

  NUM_CONTROLLERS="$2"

  echo "Starting $NUM_CONTROLLERS controllers !"

  CONTROLLER_LIST="'$3'"
  for ((i=1; i<NUM_CONTROLLERS; i++))
  do
    echo "concatenating: " $4
    CONTROLLER_LIST="$CONTROLLER_LIST,'$4'"
    shift 1
  done

  echo "Starting: $CONTROLLER_LIST under namespace: $NAMESPACE"

  sleep 10

  command="rosservice call --wait $NAMESPACE/controller_manager/switch_controller \"{start_controllers: [${CONTROLLER_LIST}], stop_controllers: [], strictness: 1}\""

  echo $command
  
  eval $command
fi
