function zenity_error() {
    local errMsg="$1"
    local width=${2:-"400"}

    zenity --error --width="$width" --text="$errMsg"
}

function zenity_info() {
    local errMsg="$1"
    local width=${2:-"400"}

    zenity --info --width="$width" --text="$errMsg"
}
