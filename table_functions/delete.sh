#!/bin/bash

function delete_from_table() {
    table_name=$(zenity --entry --width="400" --title="Delete From Table" --text="Enter table name:" --entry-text "")
    if [ $? -eq 1 ]; then
        return
    fi

    if [ ! -f "$table_name" ]; then
        zenity --error --width="400" --text="Table $table_name does not exist."
        return
    fi

    delete_value=$(zenity --entry --width="400" --title="Delete From Table" --text="Enter value to delete the row:" --entry-text "")

    sed -i "/\b$delete_value|/d" "$table_name"

    zenity --info --width="400" --text="Row(s) deleted successfully."
}