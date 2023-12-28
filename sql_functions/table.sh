#!/bin/bash

function handle_table_query()
{
    while true; do
        query=$(zenity --entry --width="600" --title="SQL query" --text="Enter the query:")
        if [ $? -eq 1 ]; then
            break;
        fi
        query_lowercase=$(echo "$query" | tr '[:upper:]' '[:lower:]')
        create="^create table .*?[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\([^;]+\)[[:space:]]*;$"
        drop="^drop table .*?[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*;$"


        if [[ "$query_lowercase" =~ $create ]]; then
            echo "Valid"
        elif [[ "$query_lowercase" =~ $drop ]]; then
            field=$(echo "$query" | awk '{print $3}')
            name=$(echo "${field}" | awk -F';' '{print $1}')
            drop_table "$name"
        else
            echo "$query_lowercase"
        fi
    done
}