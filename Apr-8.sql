1. Modify PostgreSQL authentication from md5 to pam 

2. Add a foriegn key to the table after inserting records into the child table

3. What is the alternative way to reload configuration file settings?
ANS:
OS 		== pg_ctl -D /opt/postgresql/pg96/data reload
POSTGRES	== SELECT PG_RELOAD_CONF();

4. How to check whether a paremeter change requires reload OR restart of the instance (SQL query)


5. Display top 5 biggest tables from the database.
SYNTAX:
select table_name, pg_relation_size(table_schema || '.' || table_name) from information_schema.tables where table_schema not in ('information_schema','pg_catalog') order by 2 desc limit 5; 

OUTPUT:
 table_name    | pg_relation_size
------------------+------------------
 big5             |         36249600
 big4             |         28999680
 pgbench_accounts |         26877952
 big3             |         18128896
 big2             |          7249920
