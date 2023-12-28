#!/bin/bash

function handle_query()
{
    while true; do
        query=$(zenity --entry --width="400" --title="SQL query" --text="Enter the query:")
        if [ $? -eq 1 ]; then
            break;
        fi
        fields=($(echo "$query" | awk '{print $1, $2, $3}'))

        if [[ $query == *';' ]] && [[ "${fields[1],,}" == "database" ]]; then
            name=$(echo "${fields[2]}" | awk -F';' '{print $1}')
            if [[ $name ]]; then
                if [[ "${fields[0],,}" == "create" ]]; then 
                    create_database "$name"
                elif [[ "${fields[0],,}" == "drop" ]]; then
                    drop_database "$name"
                else 
                    zenity --error --width="400" --text="Invalid query"
                fi
                break
            else
                zenity --error --width="400" --text="Invalid query "
            fi
        else
        zenity --error --width="400" --text="Invalid query "
        fi
    done
}