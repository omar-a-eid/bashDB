#!/bin/bash
DIR="$PWD/database"

function connect_database()
{
    dbname=$(zenity --entry --width="400" --title="Connect to Database" --text="Enter the database name:")

    if [ $? -eq 1 ]; then
        return
    fi
    if [ -n "$dbname" ]; then
        if [ -d "$DIR/$dbname" ]; then
            cd "$DIR/$dbname"
            show_db_menu "$dbname"
        else
            zenity --error --width="400" --text="Database '$dbname' not found!"
        fi
    else
        zenity --error --width="400" --text="Database name cannot be empty."
    fi
}
