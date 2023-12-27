#!/bin/bash
DIR="$PWD/database"

function list_database()
{
    databases=$(ls "$DIR" 2>/dev/null)

    if [ $? -eq 1 ]; then
        return
    fi
    if [ -n "$databases" ]; then
        zenity --info --width="200" --text="Databases:\n$databases"
    else
        zenity --info --width="400" --text="No databases found."
    fi
}
