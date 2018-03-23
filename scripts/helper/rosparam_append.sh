#!/bin/bash
# $0 is the script name, $1 id the first ARG, $2 is second...

if [ "$2" = "" ]
then
  echo "Usage: $0 <filename> <namespace>"
else
  dump_command="rosparam dump"
  load_command="rosparam load"
  anonym=$(( ( RANDOM % 1000 )  + 1 ))
  
  FILE="$1"  
  NAMESPACE="$2"

  IS_NAMESPACE=$(rosparam list | /bin/egrep "$NAMESPACE")

  if [ -z "$IS_NAMESPACE" ];
  then
    echo "No previous Namespace found, simply loading new parameters"
    command="$load_command $FILE $NAMESPACE"
    eval $command
  else           

    #Dumps the current parameters in the server
    command="$dump_command current_$anonym.txt $NAMESPACE"
    eval $command

    #Temporarly loads the new parameters
    command="$load_command $FILE $NAMESPACE"
    eval $command

    #Dumps the new parameters
    command="$dump_command new_$anonym.txt $NAMESPACE"
    eval $command

    #Searching the new parameters in the current ones
    command="grep -F -f current_$anonym.txt new_$anonym.txt > search_$anonym.txt"
    eval $command

    #Difference berween the new parameters and the search results
    command="diff new_$anonym.txt search_$anonym.txt > diff_$anonym.txt"
    eval $command

    if [ -s "diff_$anonym.txt" ]
    then
	echo "Appending new parameters, using anonym: $anonym."
        # do something as file has data

        #Appends both files
        cat current_$anonym.txt >> new_$anonym.txt

        #Loads all the new parameters
        command="$load_command new_$anonym.txt $NAMESPACE"
        eval $command

    else
	echo "Parameters are already loaded. Resetting old parameters"
        # do something as file is empty

        #Loads all the old parameters
        command="$load_command current_$anonym.txt $NAMESPACE"
        eval $command
    fi

    #Remove temporary files
    rm new_$anonym.txt
    rm current_$anonym.txt
    rm search_$anonym.txt
    rm diff_$anonym.txt

  fi

fi
