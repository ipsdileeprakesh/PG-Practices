 1. Demonstrate installing PostgreSQL with source code compilation
 
 2. How to run a SQL query from psql without login to the server

 ANS:
provide all login details with the query by using -c (command) and mention the required query in " " with out semicolon(;).

If the Database is password protected, then the solution would be (O.S. level)

dileep@ubuntu:~$ PGPASSWORD=postgres psql -p 7878 -d postgres -U postgres -c "select * from iknow"
   t
--------
 dinesh
 kumar
 sky
(3 rows)


In this method the query will login the postres and execute the command and shows the output of query and then logout from it. 

(login-->execute query-->show the output-->logout).


 3. Demonstrate the usage of (\watch meta command) in psql (Google)

 ANS:

\Watch meta command will displays the output of previous query for every 2 seconds(default) until interrupted or the query fails.

EX:
postgres=# SELECT CURRENT_TIMESTAMP;
              now
-------------------------------
 2018-04-23 05:21:01.864987-07
(1 row)

postgres=# \watch
Mon 23 Apr 2018 05:21:48 AM PDT (every 2s)

              now
-------------------------------
 2018-04-23 05:21:48.964409-07
(1 row)

Mon 23 Apr 2018 05:21:50 AM PDT (every 2s)

              now
-------------------------------
 2018-04-23 05:21:50.968495-07
(1 row) 



 4. Write a sql query to display all user tables along with's schema names

ANS:

For all schemas, all users:   postgres=# \dt *.*
EX:
postgres=# \dt *.*
                        List of relations
       Schema       |          Name           | Type  |  Owner
--------------------+-------------------------+-------+----------
 information_schema | sql_features            | table | dileep
 information_schema | sql_implementation_info | table | dileep
 information_schema | sql_languages           | table | dileep
 information_schema | sql_packages            | table | dileep
 information_schema | sql_parts               | table | dileep
 information_schema | sql_sizing              | table | dileep
 information_schema | sql_sizing_profiles     | table | dileep
 pg_catalog         | pg_aggregate            | table | dileep
 pg_catalog         | pg_am                   | table | dileep
 pg_catalog         | pg_amop                 | table | dileep
 pg_catalog         | pg_amproc               | table | dileep
----------------------and so on

In a particular schema:  	   postgres=# \dt public.*
EX:
postgres=# \dt *public.*
           List of relations
 Schema |    Name    | Type  |  Owner
--------+------------+-------+----------
 public | customers  | table | postgres
 public | iknow      | table | postgres
 public | link2_copy | table | postgres
 public | test       | table | postgres
(4 rows)


For current user with tables and schemas info,
EX:

postgres=# select user, table_name, table_schema from information_schema.tables where table_schema not in ('information_schema', 'pg_catalog');


 current_user | table_name | table_schema
--------------+------------+--------------
 postgres     | abc        | s1
 postgres     | abc        | s2
 postgres     | iknow      | public
 postgres     | customers  | public
 postgres     | test       | public
 postgres     | link2_copy | public
 postgres     | idontknow  | public
 postgres     | table11    | public
(8 rows)




 5. Describe the usage of search_path, and demonstrate how we need to set a perticular schema name as default search_path to a database.
 
 6. How to log only DDL(CREATE, ALTER, DROP, TRUNCATE) statements in log file (Google).
ANS:

1). ddl logs all data definition statements, such as CREATE, ALTER, and DROP statements.

2.) mod logs all ddl statements, plus data-modifying statements such as INSERT, UPDATE, DELETE, TRUNCATE, and COPY FROM. PREPARE, EXECUTE, and EXPLAIN ANALYZE statements.


Open Postgres.conf file
(dileep@ubuntu:/opt/postgresql/pg96/data$ vim postgresql.conf) and search for log_statement='none'
and 'none' change it to ddl or mod or all as per requirement.

Login to postgres and reload the file
postgres=# select pg_reload_conf();
pg_reload_conf
----------------
 t
(1 row)

EX:
postgres=# create table idontknow(I int);
CREATE TABLE

in log file we can see all the ddl or mod commands info.

2018-04-23 07:25:00 PDT postgres postgres LOG:statement: create table idontknow(I int);
2018-04-23 07:25:01 PDT postgres postgres LOG:duration: 381.126 ms

