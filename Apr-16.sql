{\rtf1\ansi\ansicpg1252\deff0\nouicompat{\fonttbl{\f0\fnil\fcharset0 Courier New;}}
{\*\generator Riched20 10.0.16299}\viewkind4\uc1 
\pard\f0\fs22\lang16393  \ul 1. Demonstrate installing PostgreSQL with source code compilation\ulnone\par
 \par
 \ul 2. How to run a SQL query from psql without login to the server\par
 ANS:\par
\ulnone provide all login details with the query by using -c (command) and mention the required query in " " with out semicolon(;).\par
\par
If the Database is password protected, then the solution would be (O.S. level)\par
\par
dileep@ubuntu:~$ PGPASSWORD=postgres psql -p 7878 -d postgres -U postgres -c "select * from iknow"\par
   t\par
--------\par
 dinesh\par
 kumar\par
 sky\par
(3 rows)\par
\par
\par
In this method the query will login the postres and execute the command and shows the output of query and then logout from it. \par
\par
(login-->execute query-->show the output-->logout).\par
\par
\par
 3. Demonstrate the usage of (\\watch meta command) in psql (Google)\par
 ANS:\par
\par
\\Watch meta command will displays the output of previous query for every 2 seconds(default) until interrupted or the query fails.\par
\par
EX:\par
postgres=# SELECT CURRENT_TIMESTAMP;\par
              now\par
-------------------------------\par
 2018-04-23 05:21:01.864987-07\par
(1 row)\par
\par
postgres=# \\watch\par
Mon 23 Apr 2018 05:21:48 AM PDT (every 2s)\par
\par
              now\par
-------------------------------\par
 2018-04-23 05:21:48.964409-07\par
(1 row)\par
\par
Mon 23 Apr 2018 05:21:50 AM PDT (every 2s)\par
\par
              now\par
-------------------------------\par
 2018-04-23 05:21:50.968495-07\par
(1 row) \par
\par
\par
\par
 4. Write a sql query to display all user tables along with's schema names\par
ANS:\par
\par
For all schemas, all users:   postgres=# \\dt *.*\par
EX:\par
postgres=# \\dt *.*\par
                        List of relations\par
       Schema       |          Name           | Type  |  Owner\par
--------------------+-------------------------+-------+----------\par
 information_schema | sql_features            | table | dileep\par
 information_schema | sql_implementation_info | table | dileep\par
 information_schema | sql_languages           | table | dileep\par
 information_schema | sql_packages            | table | dileep\par
 information_schema | sql_parts               | table | dileep\par
 information_schema | sql_sizing              | table | dileep\par
 information_schema | sql_sizing_profiles     | table | dileep\par
 pg_catalog         | pg_aggregate            | table | dileep\par
 pg_catalog         | pg_am                   | table | dileep\par
 pg_catalog         | pg_amop                 | table | dileep\par
 pg_catalog         | pg_amproc               | table | dileep\par
----------------------and so on\par
\par
In a particular schema:  \tab    postgres=# \\dt public.*\par
EX:\par
postgres=# \\dt *public.*\par
           List of relations\par
 Schema |    Name    | Type  |  Owner\par
--------+------------+-------+----------\par
 public | customers  | table | postgres\par
 public | iknow      | table | postgres\par
 public | link2_copy | table | postgres\par
 public | test       | table | postgres\par
(4 rows)\par
\par
\par
For current user with tables and schemas info,\par
EX:\par
\par
postgres=# select user, table_name, table_schema from information_schema.tables where table_schema not in ('information_schema', 'pg_catalog');\par
\par
\par
 current_user | table_name | table_schema\par
--------------+------------+--------------\par
 postgres     | abc        | s1\par
 postgres     | abc        | s2\par
 postgres     | iknow      | public\par
 postgres     | customers  | public\par
 postgres     | test       | public\par
 postgres     | link2_copy | public\par
 postgres     | idontknow  | public\par
 postgres     | table11    | public\par
(8 rows)\par
\par
\par
\par
\par
 5. Describe the usage of search_path, and demonstrate how we need to set a perticular schema name as default search_path to a database.\par
 \par
 6. How to log only DDL(CREATE, ALTER, DROP, TRUNCATE) statements in log file (Google).\par
ANS:\par
\par
1). ddl logs all data definition statements, such as CREATE, ALTER, and DROP statements.\par
\par
2.) mod logs all ddl statements, plus data-modifying statements such as INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE, EXECUTE, and EXPLAIN ANALYZE statements.\par
\par
\par
Open Postgres.conf file\par
(dileep@ubuntu:/opt/postgresql/pg96/data$ vim postgresql.conf) and search for log_statement='none'\par
and 'none' change it to ddl or mod or all as per requirement.\par
\par
Login to postgres and reload the file\par
postgres=# select pg_reload_conf();\par
pg_reload_conf\par
----------------\par
 t\par
(1 row)\par
\par
EX:\par
postgres=# create table idontknow(I int);\par
CREATE TABLE\par
\par
in log file we can see all the ddl or mod commands info.\par
\par
2018-04-23 07:25:00 PDT postgres postgres LOG:statement: create table idontknow(I int);\par
2018-04-23 07:25:01 PDT postgres postgres LOG:duration: 381.126 ms\par
\par
\par
}
 