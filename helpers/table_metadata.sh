function read_table_metadata() {
    local table_name="$1"
    if [ -z "$table_name" ]; then
        zenity_error "$table_name not found"
        return
    fi

    local -n cols_var="$2"
    local -n types_var="$3"
    local -n pk_var="$4"

    local columns=()
    local col_types=()
    local primary_keys=()
    local cols_num=$(awk 'END{print NR}' .$table_name)

    for (( i = 1; i <= $cols_num; i++ )); do
        col_name=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $1}' .$table_name)
        col_type=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$table_name)
        col_key=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$table_name)

        columns+=("$col_name")
        col_types+=("$col_type")
        primary_keys+=("$col_key")
    done

    # assign columns array to the columns array variable provided as function argument
    if [ -z "$cols_var" ]; then
        cols_var=("${columns[@]}")
    fi

    # assign tpes array to the tpes array variable provided as function argument
    if [ -z "$types_var" ]; then
        types_var=("${col_types[@]}")
    fi

    # assign pk array to the pk array variable provided as function argument
    if [ -z "$pk_var" ]; then
        pk_var=("${primary_keys[@]}")
    fi
}