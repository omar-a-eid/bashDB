#!/bin/bash
source table_functions/create.sh
source table_functions/delete.sh
source table_functions/drop.sh
source table_functions/helper_function.sh
source table_functions/insert.sh
source table_functions/list.sh
source table_functions/menu.sh
source table_functions/select.sh
source table_functions/update.sh

source database_functions/connect.sh
source database_functions/create.sh
source database_functions/drop.sh
source database_functions/list.sh
source database_functions/menu.sh

source handlers/main.sh

while true; do
	main
done