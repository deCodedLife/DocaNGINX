#!/bin/bash

SPHINX_DIR=`dirname $0`

PROJECTS_DIR="$SPHINX_DIR/projects/"


LINE=$(seq -s "#" 70 | sed 's/[0-9]//g')


##
# Include basic configs
##

cat "$SPHINX_DIR/basic.conf"


##
# Include projects configs
##

if [ ! -d "$PROJECTS_DIR" ]; then
  echo "# Path '$PROJECTS_DIR' is incorrect."
  exit 1
fi

for project_dir in "${PROJECTS_DIR%?}"/*
do
  if [[ -d $project_dir ]]; then
    PROJECT_DIR="$PROJECTS_DIR"
    PROJECT_DIR+=$(basename "$project_dir")
    PROJECT_DIR+='/'


    for config_file in "${PROJECT_DIR%?}"/*
    do
      if [[ -f $config_file ]]; then
        CONFIG_FILE_NAME=$(basename "$config_file")

        echo -e "\n\n${LINE}\n# Include file ${CONFIG_FILE_NAME}\n${LINE}\n"
        cat "$config_file"
      fi
    done
  fi
done


