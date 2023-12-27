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

