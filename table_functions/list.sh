#!/bin/bash

function list_table()
{
    if [ $? -eq 1 ]; then
        return
    fi
    tables=()
    
    for table in *; do
        if [ -f ".$table" ]; then
            table_info=$(cat ".$table")
            column_name=$(echo "$table_info" | cut -d "|" -f 1)
            data_type=$(echo "$table_info" | cut -d "|" -f 2)
            primary_key=$(echo "$table_info" | cut -d "|" -f 3)

            tables+=("$table" "$column_name" "$data_type" "$primary_key")
        fi
    done

    if [ ${#tables[@]} -eq 0 ]; then
        zenity --info --width="400" --text="No tables found."
    else
        zenity --list --width="500" --height="400" \
            --title="List Tables" \
            --column="Table Name" \
            --column="Column Name" \
            --column="Data Type" \
            --column="Primary Key" \
            "${tables[@]}"
    fi
}