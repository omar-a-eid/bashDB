#!/bin/bash

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