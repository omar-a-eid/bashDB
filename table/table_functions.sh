#!/bin/bash

function drop_table() {
    tname=$(zenity --entry --width="400" --title="Drop Table" --text="Enter the table name to drop:")
    if [ $? -eq 1 ]; then
        return
    fi
    if [ -z "$tname" ]; then
        zenity --error --width="400" --text="Table name cannot be empty."
        return
    fi

    if [ -f "$tname" ]; then
        rm "$tname"
        rm ".$tname"
        zenity --info --width="400" --text="Table '$tname' dropped successfully."
    else
        zenity --error --width="400" --text="Table '$tname' not found!"
    fi
}

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

function insert()
{
    table_name=$(zenity --entry --width="400" --title="Insert Into Table" --text="Enter Table Name:" --entry-text "")
    if [ $? -eq 1 ]; then
        return
    fi
    if [ ! -f "$table_name" ]; then
        zenity --error --width="400" --text="Invalid Table Name Provided!"
        return
    fi

    data=$(read_columns "$table_name")
    
    echo "$data" >> "$table_name"
    zenity --info --width="400" --text="Row inserted into $table_name."
}


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


function delete_from_table() {
    table_name=$(zenity --entry --width="400" --title="Delete From Table" --text="Enter table name:" --entry-text "")
    if [ $? -eq 1 ]; then
        return
    fi

    if [ ! -f "$table_name" ]; then
        zenity --error --width="400" --text="Table $table_name does not exist."
        return
    fi

    delete_value=$(zenity --entry --width="400" --title="Delete From Table" --text="Enter value to delete the row:" --entry-text "")

    sed -i "/\b$delete_value|/d" "$table_name"

    zenity --info --width="400" --text="Row(s) deleted successfully."
}
