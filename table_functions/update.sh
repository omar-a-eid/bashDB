#!/bin/bash
function update_table() {
    table_name=$(zenity --entry --width="400" --title="Update Table" --text="Enter table name:" --entry-text "")

    if [ $? -eq 1 ]; then
        return
    fi
    
    if [ ! -f "$table_name" ]; then
        zenity --error --width="400" --text="Table $table_name does not exist."
        return
    fi

    primary_key_info=$(awk -F'|' '$3 == "y" {print NR,$1}' ".$table_name")

    primary_key_line=$(echo "$primary_key_info" | awk '{print $1}')
    primary_key=$(echo "$primary_key_info" | awk '{print $2}')

    if [ -z "$primary_key" ]; then
        zenity --error --width="400" --text="No primary key defined for the table."
        return
    fi

    primary_key_value=$(zenity --entry --width="400" --title="Update Table" --text="Enter primary key value to specify the row:" --entry-text "")
    record_line_number=""
    record_line_number=$(sed -n "/\b$primary_key_value|/=" "$table_name")
    echo $record_line_number
    if [ -n "$record_line_number" ]; then
        data=$(read_columns "$table_name" "$primary_key_value")
        sed -i "${record_line_number}c\\$data" "$table_name"
        zenity --info --width="400" --text="Row(s) updated successfully."
    else
        zenity --info --width="400" --text="No record found with the given primary key value."
    fi
}
