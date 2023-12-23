#!/bin/bash
function show_menu()
{
    choice=$(zenity --list \
        --title="Bash DBMS Menu" \
        --text="Welcome to bash DBMS" \
        --width=400 \
        --height=400 \
        --column="Option" --column="Description" \
        "Create Database" "Create a new database" \
        "List Database" "List existing databases" \
        "Connect to Database" "Connect to a database" \
        "Drop Database" "Drop an existing database")
    case $choice in
        "Create Database") create_database;;
        "List Database") list_database;;
        "Connect to Database") connect_database;;
        "Drop Database") drop_database;;
        *)
          exit;;
    esac
}