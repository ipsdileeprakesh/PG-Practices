1. Modify PostgreSQL authentication from md5 to pam 

2. Add a foriegn key to the table after inserting records into the child table
ANS:
postgres=# create table company(id int primary key, name text);
CREATE TABLE
postgres=# select * from company;
 id  |  name
-----+--------
 100 | DELL
 200 | HP
 300 | LENOVO
 400 | APPLE

postgres=# create table customers(id int primary key, name text,companyid int);
CREATE TABLE
postgres=# select * from customers;
 id |  name  | companyid
----+--------+-----------
  1 | Andhra |       100
  2 | Kerala |       200
  3 | Delhi  |       300
  4 | Assam  |       400
  5 | Bihar  |       500

here we are not given any foriegn key to child table (customers), alter and give foreign key to customers table.

postgres=# alter table customers add Foreign key (companyid) references company(id);
ERROR:  insert or update on table "customers" violates foreign key constraint "customers_companyid_fkey"
DETAIL:  Key (companyid)=(500) is not present in table "company". 

We got error because in company table we have only 4 records and customers table 5th record is there, so foregin key checked the details and ended up with error.

In this case we have to type "NOT VALID" while adding foreign key to the child talble (customers).

postgres=# alter table customers add Foreign key (companyid) references company(id) not valid;
ALTER TABLE

here succesfully added Foreign key constraint to the Customers table.

This "NOT VALID" will optionl help us to show all the records from the table.

Now foriegn key is added to table and If we try to add the new records which are not availble in parent table, it will show error as follows.

postgres=# insert into customers values (6,'Goa', 600);
ERROR:  insert or update on table "customers" violates foreign key constraint "customers_companyid_fkey"
DETAIL:  Key (companyid)=(600) is not present in table "company".





3. What is the alternative way to reload configuration file settings?
ANS:

OS 		== pg_ctl -D /opt/postgresql/pg96/data reload
POSTGRES	== SELECT PG_RELOAD_CONF();



4. How to check whether a paremeter change requires reload OR restart of the instance (SQL query)
ANS:

postgres=# select name, context from pg_settings order by category;
                name                 |      context
-------------------------------------+-------------------
 autovacuum_analyze_threshold        | sighup
 autovacuum_multixact_freeze_max_age | postmaster
 autovacuum_naptime                  | sighup
 autovacuum_max_workers              | postmaster
 autovacuum_analyze_scale_factor     | sighup
 lc_monetary                         | user
 client_encoding                     | user
 lc_ctype                            | internal
 wal_block_size                      | internal
 integer_datetimes                   | internal 
 log_error_verbosity                 | superuser
 log_duration                        | superuser
 log_disconnections                  | superuser-backend
 log_connections                     | superuser-backend 
 ignore_system_indexes               | backend
 wal_consistency_checking            | superuser
 post_auth_delay                     | backend 

here it is details:

sighup (Reload)		= The Changed settings can be made in postgresql.conf without restarting the server. Send a SIGHUP signal to the postmaster to cause it to re-read postgresql.conf 			  	  and apply the changes.
postmaster (Restart)	= These settings can only be applied when the server starts, so any change requires restarting the server. Values for these settings are stored in the 			  		 	  postgresql.conf file.
user			= The parameters can change by user for the current sessions which are they connected, once user leaves the session the changes will revertback to default.
internal		= The internal parameters cannot be changed; these are usually compile-time constants. If you want to change any of these, you’ll have to change it in Postgres 			  	  source code and compile a new set of Postgres executables.
superuser		= only superusers can change the settings while the session in progress, during code compilation or during postgres startup.(Normal users cannot change these 			  		  parameters).
backend			= Normal users can use backend for to create new parameters for the new session, The backend parameters can be changed/set while making a new connection to Postgres.
			  (Usually the applications set these parameters while making the initial connection)
superuser-backend	= only superusers can use superuser-backend to create the new values for the selected parameters to the new session.



5. Display top 5 biggest tables from the database.
ANS:

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
