#!/bin/bash

function select_from_table() {
    table_name=$(zenity --entry --width="400" --title="Select From Table" --text="Enter table name:" --entry-text "")
    if [ $? -eq 1 ]; then
        return
    fi
    if [ ! -f "$table_name" ]; then
        zenity --error --width="400" --text="Table $table_name does not exist."
        return
    fi

    choice=$(zenity --list --width="400" --height="300" \
        --title="Select options:" \
        --column="Option" \
        "Display All Rows" \
        "Select a specific row")

    case $choice in
        "Display All Rows") display_all $table_name;;
        "Select a specific row") select_row $table_name ;;
    esac
    
}

function display_all() {
    header=()
    num_columns=""
    column_data=()
     if [ $? -eq 1 ]; then
        return
    fi   
    header=($(cut -d '|' -f 1 ".$1"))
    num_columns="${#header[@]}"

    column_options=""
    for col in "${header[@]}"; do
        column_options+="--column=$col "
    done
    
    column_data+=($(awk 'BEGIN {FS = "|"} {for (i=1; i<=NF; i++) printf $i " ";}' "$1"))
        zenity --list --width="600" --height="400" \
            --title="Displaying Data for '$1' table:" \
            $column_options \
            "${column_data[@]}"
}

function select_row() {
    if [ $? -eq 1 ]; then
        return
    fi 
    row=()
    header=()
    num_columns=""

    value=$(zenity --entry --width="400" --title="Select Row From Table" --text="Enter value to select from the row:" --entry-text "")

    row+=($(sed -n "/\b$value|/p" "$1" | tr '|' ' '))
    
    header=($(cut -d '|' -f 1 ".$1"))
    num_columns="${#header[@]}"
    column_options=""
    for col in "${header[@]}"; do
        column_options+="--column=$col "
    done
    
    zenity --list --width="600" --height="400" \
            --title="Displaying Data for '$1' table:" \
            $column_options \
            "${row[@]}"

}

