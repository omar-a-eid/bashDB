#!/bin/bash

function create_table_sql() {
    cols=$(echo "$1" | grep -oP '\([^;]+\)')
    declare -A col_names
    data=""
    primary_key_count=0

    if [ -f "$2" ]; then
        zenity --error --width="400" --text="Table is already created."
        return
    fi

    total_cols=$(echo "$cols" | tr -d '()' | tr ',' '\n' | wc -l)
    current_col=0

    while IFS= read -r col_def; do
        ((current_col++))
        col_name=$(echo "$col_def" | awk '{gsub(/[(]/,"",$1); print $1}')
        data_type=$(echo "$col_def" | awk '{gsub(/[,]/,"",$2); print $2}')
        primary_key="n"

        if [ "$data_type" != "int" ] && [ "$data_type" != "str" ] && ! [ "$data_type" ]; then
            zenity --error --width="400" --text="Invalid data type. Please enter 'int' or 'str'."
            return
        fi

        if ! [ "${col_names[$col_name]}" ]; then
            col_names[$col_name]=1
        else
            zenity --error --width="400" --text="Duplicate column name '$col_name'. Each column must have a unique name."
            return
        fi

        if echo "$col_def" | grep -q "primary key"; then
            if [ "$primary_key_count" -eq 0 ]; then
                primary_key="y"
                ((primary_key_count++))
            else
                zenity --error --width="400" --text="Only one primary key is allowed."
                return
            fi
        fi

        data+="$col_name|$data_type|$primary_key"
        
        # Check if this is the last col_def
        if ! [ "$current_col" -eq "$total_cols" ]; then
            data+="\n"
        fi
    done < <(echo "$cols" | tr -d '()' | tr ',' '\n')

    if [ -n "$data" ]; then
        echo -e "$data" > ".$2"
        touch "$2"
    fi
    zenity --info --width="400" --text="Table has been created successfully."
}