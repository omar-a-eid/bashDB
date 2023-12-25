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

function drop_database()
{
    dbname=$(zenity --entry --width="400" --title="Drop Database" --text="Enter the database name to drop:")
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
