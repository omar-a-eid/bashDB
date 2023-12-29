#!/bin/bash

function handle_table_query()
{
    while true; do
        query=$(zenity --entry --width="600" --title="SQL query" --text="Enter the query:")
        if [ $? -eq 1 ]; then
            break;
        fi

        query_lowercase=$(echo "$query" | tr '[:upper:]' '[:lower:]')
        create="^create table [a-zA-Z_][a-zA-Z0-9_]* \( [^;]+ \)[[:space:]]*;$"
        drop="^drop table [a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*;$"
        select_pattern="^select (\*|[a-zA-Z_][a-zA-Z0-9_]*(, [a-zA-Z_][a-zA-Z0-9_]*)*) from ([a-zA-Z_][a-zA-Z0-9_]*) ?(where (.+))?;$"
        insert="^insert into ([a-zA-Z_][a-zA-Z0-9_]*)[[:space:]]*\(([^;]+)\) values[[:space:]]*\(([^;]+)\)[[:space:]]*;$"
        
        if [[ "$query_lowercase" =~ $create ]]; then

            tname=$(echo "$query_lowercase" | awk '{print $3}')
            create_table_sql "$query_lowercase" "$tname"

        elif [[ "$query_lowercase" =~ $drop ]]; then

            field=$(echo "$query_lowercase" | awk '{print $3}')
            name=$(echo "${field}" | awk -F';' '{print $1}')
            drop_table "$name"

        elif [[ "$query_lowercase" =~ $select_pattern ]]; then

            cols=$(echo "${query}" | awk -F 'from' '{gsub(/^[ \t]+|[ \t]+$/, "", $1); print $1}' | sed 's/select//i')
            tname=$(echo "${query}" | awk -F 'from' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); gsub(/;/, "", $2); print $2}')
            where_condition=$(echo "${query}" | awk -F 'where' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')

            if ! [ -f "$tname" ];then 
                zenity --error --width="400" --text="Table $tname doesn't exists."
                return
            fi

            if [ "$(echo "$cols" | tr -d '[:space:]')" == "*" ]; then

                display_all "$tname"

            elif [ "$cols" ]; then

                display_columns "$tname" "$cols"

            fi
        elif [[ "$query_lowercase" =~ $insert ]]; then
            table_name="${BASH_REMATCH[1]}"
            fields="${BASH_REMATCH[2]}"
            values="${BASH_REMATCH[3]}"
            sql_insert "$table_name" "$fields" "$values"
            
        elif [[ "$query_lowercase" =~ $update ]]; then
            echo "Valid UPDATE command"
            
        else
            zenity --error --width="400" --text="Invalid query."

        fi
    done
}