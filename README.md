# bashDB Documentation

## Table of Contents

1. [Introduction](#introduction)
2. [Project Overview](#project-overview)
3. [Getting Started](#getting-started)
4. [Project Structure](#project-structure)
5. [Features](#features)
6. [SQL Query Support](#sql-query-support)
   1. [Update Query (Coming Soon)](#update-query-coming-soon)
7. [Usage Rules](#usage-rules)
   1. [Query Syntax Standard](#query-syntax-standard)
8. [Future Features](#future-features)
   1. [DELETE Command (Future Enhancement)](#delete-command-future-enhancement)
   2. [Enhanced SELECT Command (Future Update)](#enhanced-select-command-future-update)
9. [Conclusion](#conclusion)

## 1. Introduction<a name="introduction"></a>

Welcome to the Bash Database Management System (DBMS) with Zenity documentation. This project offers a simple yet powerful solution for managing databases using a Bash script with the added convenience of Zenity for creating graphical user interfaces. Users can interact with the system through GUI dialogs or by executing SQL commands directly.

## 2. Project Overview<a name="project-overview"></a>

The BashDB project is designed to facilitate basic database management tasks using a Bash script. It leverages Zenity to create user-friendly dialogs, enabling users to add, view, and edit data within a straightforward database structure. The flexibility of the system allows users to choose between GUI interaction and direct SQL commands.

## 3. Getting Started<a name="getting-started"></a>

To get started with the Bash DBMS project, follow these steps:

```bash
# Clone the repository
git clone https://github.com/omar-a-eid/bashDB.git

# Navigate to the project directory
cd bashDB

# Run the main script
./main.sh
```

## 4. Project Structure<a name="project-structure"></a>

The project has the following structure:

- **main.sh:** The main script that serves as the entry point for the DBMS.
- **table_functions:** Additional functions and logic related to database operations.
- **database_functions:** Functions that are related to the main menu and the main operation of creating and connecting to the database, etc.
- **database:** The main directory that will contain the databases.
- **sql_functions:** Function to handle sql queries.

## 5. Features<a name="features"></a>

- Execute SQL commands directly through the interface.
- Add new records to the database.
- View all records in the database.
- Edit existing records in the database.
- User-friendly dialogs created with Zenity.

## 6. SQL Query Support<a name="sql-query-support"></a>

As of the latest update, BashDB supports SQL queries, allowing users to interact directly with the database using SQL commands through the command line interface.

### 6.1 Update Query (Future update)

An upcoming release will introduce support for SQL UPDATE queries, enabling users to modify existing records in the database using SQL commands.

## 7. Usage Rules<a name="usage-rules"></a>

### 7.1 Query Syntax Standard

When writing SQL queries within the BashDB system, ensure to leave spaces between brackets and values for proper parsing and execution:

```sql
insert into table_name ( col_name, col_name ) values ( value1, value2 );
```

## 8. Future Features<a name="future-features"></a>

The BashDB project is continually evolving with planned enhancements, including:

### 8.1 DELETE Command (Future Enhancement)

Upcoming updates will introduce an enhanced DELETE command capability. Currently, the system accepts only the `=` operator for equality in DELETE queries. However, in future releases, support for additional operators will be incorporated. This enhancement will allow users to execute advanced queries for selective record deletion based on specific criteria or conditions.

### 8.2 Enhanced SELECT Command (Future Update)

Future iterations will include the implementation of a WHERE clause for the SELECT command. This improvement enables users to retrieve specific data by applying conditions or filters within the query.

## 9. Conclusion<a name="conclusion"></a>

BashDB combines the simplicity of Bash scripting with the power of SQL queries, offering users an intuitive and versatile solution for managing databases. Whether you prefer the ease of graphical user interfaces or the precision of SQL commands, BashDB provides a flexible environment for your database management needs. Explore the features, provide feedback, and stay tuned for exciting updates as the project continues to evolve. Feel free to contribute to the project's development.

If you would like to see a demo of BashDB in action, you can watch it [here](https://drive.google.com/file/d/1eVVxJ3DE-jCEDIwLPSYQgCgduTPmT4_w/view?usp=sharing). Thank you for choosing BashDB for your database management tasks!
