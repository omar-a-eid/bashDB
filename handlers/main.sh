#!/bin/bash
function main()
{
    choice=$(zenity --list \
        --title="Bash DBMS Menu" \
        --text="Welcome to bash DBMS" \
        --width=400 \
        --height=400 \
        --column="Option" --column="Description" \
        "Interface" "Using GUI to interact with databases" \
        "SQL" "Using SQL queries to interact with databases " )
    case $choice in
        "Interface") show_menu;;
        "SQL") list_database;;
        *)
          exit;;
    esac
}