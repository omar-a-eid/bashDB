#!/bin/bash
function show_menu_sql()
{
    while true; do
    if [ $? -eq 1 ]; then
        break
    fi
    choice=$(zenity --list \
        --title="Bash DBMS Menu" \
        --text="Database operations" \
        --width=400 \
        --height=400 \
        --column="Option" --column="Description" \
        "List Database" "List existing databases" \
        "Connect to Database" "Connect to a database" \
        "Write SQL queries" "Write query to create or drop database")
    case $choice in
        "List Database") list_database;;
        "Connect to Database") connect_database "sql";;
        "Write SQL queries") handle_query;;
        *)
          exit;;
    esac
    done

}