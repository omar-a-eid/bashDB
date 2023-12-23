function read_columns() {
    table_name=$1
    primary_key=$2

    colsNum=$(awk 'END{print NR}' .$table_name)
    cdata=()
    if [ $? -eq 1 ]; then
        return
    fi
    for (( i = 1; i <= $colsNum; i++ )); do
        colName=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $1}' .$table_name)
        colType=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$table_name)
        colKey=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$table_name)

        if [ -n "$primary_key" ] && [ "$colKey" == "y" ]; then
            cdata+=$primary_key"|"
            continue
        fi

        case "$colType" in
        "int")
            data=$(zenity --entry --width="400" --title="Enter Data" --text="Enter the data for $colName ($colType):" --entry-text "")
            while ! [[ "$data" =~ ^[0-9]*$ ]]; do
                zenity --error --width="400" --text="Invalid Datatype!!"
                data=$(zenity --entry --width="400" --title="Enter Data" --text="Enter the data for $colName ($colType):" --entry-text "")
            done
            ;;
        "str")
            data=$(zenity --entry --width="400" --title="Enter Data" --text="Enter the data for $colName ($colType):" --entry-text "")
            while ! [[ "$data" =~ ^[a-zA-Z]*$ ]]; do
                zenity --error --width="400" --text="Invalid Datatype!!"
                data=$(zenity --entry --width="400" --title="Enter Data" --text="Enter the data for $colName ($colType):" --entry-text "")
            done
            ;;
        esac

        if [ "$colKey" == "y" ]; then
            while grep -q "\b$data|" "$table_name"; do
                zenity --error --width="400" --text="Duplicated data!!"
                data=$(zenity --entry --width="400" --title="Enter Data" --text="Enter the data for $colName ($colType):" --entry-text "")
            done
        fi

        cdata+=$data"|"
    done

    echo "$cdata"
}

