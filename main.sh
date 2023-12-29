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

source sql_functions/main.sh
source sql_functions/database.sh
source sql_functions/table_menu.sh
source sql_functions/table.sh
source sql_functions/create_table.sh
source sql_functions/select_cols.sh


while true; do
	main
done