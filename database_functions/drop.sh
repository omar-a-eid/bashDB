#!/bin/bash
DIR="$PWD/database"

function drop_database()
{
    if ! [[ "$1" ]]; then
        dbname=$(zenity --entry --width="400" --title="Drop Database" --text="Enter the database name to drop:")
    else
        dbname="$1"
    fi

    if [ $? -eq 1 ]; then
        return
    fi
    if [ -n "$dbname" ]; then
        if [ -d "$DIR/$dbname" ]; then
            rm -r "$DIR/$dbname"
            zenity --info --width="400" --text="Database '$dbname' dropped successfully."
        else
            zenity --error --width="400" --text="Database '$dbname' not found"
        fi
    else
        zenity --error --width="400" --text="Database name cannot be empty."
    fi
}
