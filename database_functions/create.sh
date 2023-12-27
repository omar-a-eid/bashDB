#!/bin/bash
DIR="$PWD/database"

function create_database()
{
    dbname=$(zenity --entry --width="400" --title="Create Database" --text="Enter name:")
    if [ $? -eq 1 ]; then
        return
    fi
    if [ -d "$DIR/$dbname" ]; then 
        zenity --error --width="400" --text="Database is already created."
        return 
    fi
    if [ -n "$dbname" ]; then
        mkdir -p "$DIR/$dbname"
        zenity --info --width="400" --text="The database '$dbname' has been created."
    else
        zenity --error --width="400" --text="Database name cannot be empty."
    fi
}
