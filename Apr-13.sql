
1. How to drop a parent table without dropping the child table.

2. What is a database system identifier and how to find it.
ANS: System Identifier number will be assigned when Postgres database is installed in server and The system identifier remains the same even if the server has cloned or backup....etc..

Many actions on the server will keyed to the system identifier.

If anything happens to server, by using system identifier we can find the problems which has happened.

IN OS LEVEL

pg_controldata /opt/postgresql/pg96/data | grep "system identifier";
Database system identifier:           6519466583466762612


3. How to find the query execution duration time from log file.
ANS: open config file and change log_min_duration_statement value from -1 to 0 and reload the conf file.
Create a Table with values
check latest log file from /opt/postgresql/pg96/data/pg_log$ ls -l
open with cat postgresql-2018-04-13_033808.log

4. What is the difference between TRUNCATE, DELETE and DROP statement. (Google)

 1)TRUNCATE:
TRUNCATE is a DDL command 
TRUNCATE is executed using a table lock and whole table is locked for remove all records. 
We cannot use Where clause with TRUNCATE. 
TRUNCATE removes all rows from a table. 
Minimal logging in transaction log, so it is performance wise faster. 
TRUNCATE TABLE removes the data by deallocating the data pages used to store the table data and records only the page deallocations in the transaction log. 
Identify column is reset to its seed value if table contains any identity column. 
To use Truncate on a table you need at least ALTER permission on the table. 
Truncate uses the less transaction space than Delete statement. 
Truncate cannot be used with indexed views. 
 2)DELETE:
DELETE is a DML command.
DELETE is executed using a row lock, each row in the table is locked for deletion.
We can use where clause with DELETE to filter & delete specific records.
The DELETE command is used to remove rows from a table based on WHERE condition.
It maintain the log, so it slower than TRUNCATE.
The DELETE statement removes rows one at a time and records an entry in the transaction log for each deleted row.
Identity of column keep DELETE retain the identity.
To use Delete you need DELETE permission on the table.
Delete uses the more transaction space than Truncate statement.
Delete can be used with indexed views.
 3)DROP:
The DROP command removes a table from the database. 
All the tables' rows, indexes and privileges will also be removed. 
No DML triggers will be fired. 
The operation cannot be rolled back.
DROP and TRUNCATE are DDL commands, whereas DELETE is a DML command.
DELETE operations can be rolled back (undone), while DROP and TRUNCATE operations cannot be rolled back.

5. Demonstrate the usage of TRANSACTION REPEATABLE READ and SERIALIZATION.



