#!/bin/bash

function sql_delete() {
    table_name="$1"
    where_condition=$(echo "$2" | tr -d '[:space:]')
    echo "$where_condition"
    column=$(echo "$where_condition" | awk -F"=" '{print $1}' | tr -d '[:space:]')
    value=$(echo "$where_condition" | awk -F"=" '{print $2}' | tr -d '[:space:]')
    column_number=$(grep -n "^$column|" ".$table_name" | cut -d ":" -f 1)


    if [[ "$column" ]] && [[ "$value" ]]; then
        rows=($(awk -v col="$column_number" -v val="$value" -F"|" '$col == val {print NR}' "$table_name"))
        if [[ ${#rows[@]} -gt 0 ]]; then
            for ((i=${#rows[@]}-1; i>=0; i--)); do
                sed -i "${rows[i]}d" "$table_name"
            done
            zenity --info --width="400" --text="Row(s) deleted successfully."
        else
            echo "No matching rows found for the given condition."
        fi
    else
        echo "Invalid column or value."
    fi

    # Perform the delete operation
    zenity --info --width="400" --text="Row(s) deleted successfully."
}
    
    #sed -i "/\b$delete_value|/d" "$table_name"