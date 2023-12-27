#!/bin/bash

function show_db_menu()
{
    while true; do
    if [ $? -eq 1 ]; then
        break
    fi
    choice=$(zenity --list \
        --title="Database Menu" \
        --text="Connected to database '$dbname'" \
        --width=400 \
        --height=400 \
        --column="Options" \
        "Create Table" \
        "List Tables" \
        "Drop Table" \
        "Insert Into Table" \
        "Select From Table" \
        "Delete From Table" \
        "Update Table" \
        "Back To Main Menu" )
    case $choice in
        "Create Table") create_table;;
        "List Tables") list_table;;
        "Drop Table") drop_table;;
        "Insert Into Table") insert;;
        "Select From Table") select_from_table;;
        "Delete From Table") delete_from_table;;
        "Update Table") update_table;;
        "Back To Main Menu")
            cd ..
            break;;
        *)
          exit;;
    esac
    done
}


