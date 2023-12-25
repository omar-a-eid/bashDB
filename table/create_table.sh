#!/bin/bash

function create_table() {
  
    table_name=$(zenity --entry --width="400" --title="Create Table" --text="Enter table name:")
    if [ $? -eq 1 ]; then
        return
    fi
    if [ -f "$table_name" ]; then
        zenity --error --width="400" --text="Table is already created."
        return
    fi
    while [ -z "$table_name" ]; do
        zenity --error --width="400" --text="Table name cannot be empty."
        table_name=$(zenity --entry --width="400" --title="Create Table" --text="Enter table name:")

    done

    number=$(zenity --entry --width="400" --title="Create Table" --text="Enter number of columns:")
    while ! [[ "$number" =~ ^[0-9]+ ]] || [ "$number" -le 0 ]; do
        zenity --error --width="400" --text="Invalid number of columns. Please enter a positive integer."
        number=$(zenity --entry --width="400" --title="Create Table" --text="Enter number of columns:")

    done

    num=0
    touch "$table_name"
    touch ".$table_name"

    sep="|"
    flag="n"

    while [ $num -lt $number ]; do
        col_name=$(zenity --entry --width="400" --title="Create Table" --text="Enter column name:")
        while [ -z "$col_name" ]; do
            zenity --error --width="400" --text="Column name cannot be empty."
            col_name=$(zenity --entry --width="400" --title="Create Table" --text="Enter column name:")
        done

        data_type=$(zenity --entry --width="400" --title="Create Table" --text="Enter column data type (int/str):")
        while [ "$data_type" != "int" ] && [ "$data_type" != "str" ]; do
            zenity --error --width="400" --text="Invalid data type. Please enter 'int' or 'str'."
            data_type=$(zenity --entry --width="400" --title="Create Table" --text="Enter column data type (int/str):")
        done

        primary_key="n"
        if [ "$flag" == "n" ]; then
            primary_key=$(zenity --entry --width="400" --title="Create Table" --text="Is it primary key (type y or n):")
            while [ "$primary_key" != "y" ] && [ "$primary_key" != "n" ]; do
                zenity --error --width="400" --text="Invalid option. Please enter 'y' or 'n'."
                primary_key=$(zenity --entry --width="400" --title="Create Table" --text="Is it primary key (type y or n):")
            done

            if [ "$primary_key" == "y" ]; then
                flag="y"
            fi
        fi

        echo "$col_name|$data_type|$primary_key" >>".$table_name"

        let num=$num+1
    done

    zenity --info --width="400" --text="Table '$table_name' created successfully."
    return
}
