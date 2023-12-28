#!/bin/bash
function show_table_menu_sql()
{
    while true; do
    if [ $? -eq 1 ]; then
        break
    fi
    choice=$(zenity --list \
        --title="Bash DBMS Menu" \
        --text="Connected to database '$dbname'" \
        --width=600 \
        --height=600 \
        --column="Option" --column="Description" \
        "List Tables" "List Existing Tables" \
        "Write SQL queries" "Write a query to do CRUD operations on tables" \
        "Back To Main Menu" "Get back to the database menu" )
    case $choice in
        "List Tables") list_table;;
        "Write SQL queries") handle_table_query;;
        "Back To Main Menu")
            cd ..
            break;;
        *)
          exit;;
    esac
    done

}