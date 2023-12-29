#!/bin/bash

function sql_insert() 
{
    table_name=$1
    input_fields=$2
    input_values=$3

    # read table metadata
    local tbl_cols=()
    local tbl_types=()
    local tbl_pks=()
    read_table_metadata "$table_name" "tbl_cols" "tbl_types" "tbl_pks"

    # split fields and values inputs into substrings
    IFS=',' read -ra fields <<< "$input_fields"
    IFS=',' read -ra values <<< "$input_values"

    # verify that number of fields within the query is equal to the number of values
    if [ ${#fields[@]} -ne ${#values[@]} ]; then
       zenity_error "you must specify values for all input fields"
       return
    fi

    # verify that the number of fields within the query is equal to the number of table columns
    if [ ${#fields[@]} -ne ${#tbl_cols[@]} ]; then
       zenity_error "you must specify values for all table columns"
       return
    fi

    # Check if each substring exists in the array
    for field in "${fields[@]}"; do
        found=0
        for col in "${tbl_cols[@]}"; do
            if [[ "$field" == "$col" ]]; then
                found=1
                break
            fi
        done

        if [ $found -eq 0 ]; then
            zenity_error "unknown field provided: $field"
            return
        fi
    done

    # convert fields and values arrays into map
    local -A input_map
    for ((i = 0; i < ${#fields[@]}; i++)); do
        input_map[${fields[$i]}]=${values[$i]}
    done

    local new_record=()
    for (( i = 0; i < ${#tbl_cols[@]}; i++ )); do
        # verify fields types for values
        case "${tbl_types[$i]}" in
        "int")
            if ! [[ "${input_map[${tbl_cols[$i]}]}" =~ ^[0-9]*$ ]]; then
                zenity_error "Invalid Datatype for field: ${tbl_cols[$i]}."
                return
            fi
            ;;
        "str")
            if ! [[ "${input_map[${tbl_cols[$i]}]}" =~ ^[a-zA-Z]*$ ]]; then
                zenity_error "Invalid Datatype for field: ${tbl_cols[$i]}."
                return
            fi
            ;;
        esac

        # verify that record is unique
        if [ "${tbl_pks[$i]}" == "y" ]; then
            if grep -q "\b${input_map[${tbl_cols[$i]}]}|" "$table_name"; then
                zenity_error "Duplicated value for primary key: ${tbl_cols[$i]}."
                return
            fi
        fi

        new_record+=${input_map[${tbl_cols[$i]}]}"|"
    done
    
    echo "$new_record" >> "$table_name"
    zenity_info "Row inserted into $table_name successfully."
}