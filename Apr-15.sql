 1. Describe each character meaning in SELECT current_timestamp.

ANS:
postgres=# SELECT CURRENT_TIMESTAMP;
              now
-------------------------------
 2018-04-23 05:16:59.864987-07
(1 row)

Here result displays with current Year, month, date, time with minutes, seconds and milliseconds and Timezone(-07 or +07)



 2. Demonstrate the temporary file generation


 3. How to kill or shutdown a postgres manually (Google)

ANS:
Check the Postgres running or not by using (ps -ef | grep postgres) in O.S. level.
Note down the PID of Postgres.
use sudo kill to shutdown the postgres process.
EX:
dileep@ubuntu:~$ ps -ef | grep postgres
dileep     3803      1  0 05:13 pts/4    00:00:00 /opt/postgresql/pg96/bin/postgres -D /opt/postgresql/pg96/data
dileep     3804   3803  0 05:13 ?        00:00:00 postgres: logger process
dileep     3806   3803  0 05:13 ?        00:00:00 postgres: checkpointer process
dileep     3807   3803  0 05:13 ?        00:00:00 postgres: writer process
dileep     3808   3803  0 05:13 ?        00:00:00 postgres: wal writer process
dileep     3809   3803  0 05:13 ?        00:00:00 postgres: autovacuum launcher process
dileep     3810   3803  0 05:13 ?        00:00:00 postgres: stats collector process
dileep     3812   3289  0 05:13 pts/4    00:00:00 grep --color=auto postgres


dileep@ubuntu:~$ sudo kill 3803
dileep@ubuntu:~$ ps -ef | grep postgres
dileep     3817   3289  0 05:13 pts/4    00:00:00 grep --color=auto postgres

(OR)

BY using service file we can stop, start or reload the postgres database

EX:

sudo service postgresql-10 stop





 4. Demonstrate the password less access between two machines (ssh)


 5. Demonstrate the usage of scp and rsync

 6. How to stop/kill a query in postgresql?

ANS:
postgres=# create table table11(t int);
CREATE TABLE
postgres=# insert into table11 values(generate_series(1,12313214646464646));

where this table is taking so much time to process. If we want to kill the query or process, we should use pg_cancel_backend or pg_terminate_backend.


To cancel these long running queries we should use:
SELECT pg_cancel_backend(pid);


To kill the query which had stuck we should use:
SELECT pg_terminate_backend(pid);

SOLUTION:

Open other session and do these steps to kill the process..

First we need to know the pid of the process for that we use
 
select * from pg_stat_activity where state='active'; 


postgres=# select * from pg_stat_activity where state='active';
-[ RECORD 1 ]----+------------------------------------------------------------------
datid            | 352838
datname          | postgres
pid              | 23579
usesysid         | 16384
usename          | postgres
application_name | psql
client_addr      |
client_hostname  |
client_port      | -1
backend_start    | 2018-04-25 05:42:02.435027-07
xact_start       | 2018-04-25 05:46:53.443045-07
query_start      | 2018-04-25 05:46:53.443045-07
state_change     | 2018-04-25 05:46:53.44305-07
wait_event_type  |
wait_event       |
state            | active
backend_xid      | 120452
backend_xmin     | 120452
query            | insert into table11 values(generate_series(1,12313214646464646));


here in output we can find pid 23579 of insert into table11 values(generate_series(1,12313214646464646));, 

note it down.

postgres=# select pg_cancel_backend(23579);
-[ RECORD 1 ]-----+--
pg_cancel_backend | t
 
In query session the output displays as

postgres=# insert into table11 values(generate_series(1,12313214646464646));
ERROR:  canceling statement due to user request

or


postgres=# select pg_terminate_backend(23579);
-[ RECORD 1 ]--------+--
pg_terminate_backend | t 

In query session the output displays as

postgres=# insert into table11 values(generate_series(1,12313214646464646));
FATAL:  terminating connection due to administrator command
server closed the connection unexpectedly
        This probably means the server terminated abnormally
        before or while processing the request.
The connection to the server was lost. Attempting reset: Succeeded.