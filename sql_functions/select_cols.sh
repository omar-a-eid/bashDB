#!/bin/bash

function display_columns ()
{
    header=()
    column_data=()
    line_numbers=()
    if [ $? -eq 1 ]; then
        return
    fi
    array=($(echo "$2" | awk -F', ' '{for (i=1; i<=NF; i++) print $i}'))

    for name in "${array[@]}"; do 
            line_number=$(grep -n "^$name|" ".$1" | cut -d ":" -f 1)
            if [ -n "$line_number" ]; then
                line_numbers+=("$line_number")
                header+=("$name")
            fi
    done

    if [[ -n "${line_numbers[@]}" ]]; then
        while IFS= read -r line; do
            for number in "${line_numbers[@]}"; do
                column_data+=($(echo "$line" | cut -d '|' -f "$number"))
            done
        done < "$1"
    fi

    column_options=""
    for col in "${header[@]}"; do
        column_options+="--column=$col "
    done
    
        zenity --list --width="600" --height="400" \
            --title="Displaying Data for '$1' table:" \
            $column_options \
            "${column_data[@]}"
}