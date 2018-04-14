1. Create a database user with some password and try to change password it later.
ANS:

postgres=# create user fatty with password 'fatty';
CREATE ROLE

CHANGE USER PASSWORD WITH

postgres=# alter user fatty with password 'pig';
ALTER ROLE


2. Convert existing normal user to super user (Google)
ANS:


postgres=# create user fatty with password 'fatty';
CREATE ROLE

CONVERT NORMAL USER TO SUPER USER WITH

postgres=# alter user fatty superuser;
ALTER ROLE



3. How to find the postgresql uptime?
ANS: 

postgres=# select pg_postmaster_start_time();
   pg_postmaster_start_time
-------------------------------
 2018-04-13 03:38:08.251125-07

To find that from how many days the database is up, we need use

postgres=# select current_timestamp - pg_postmaster_start_time();
       ?column?
-----------------------
 1 day 04:46:06.219335


here date_trunc will not show milliseconds info.

postgres=# select date_trunc('second',current_timestamp - pg_postmaster_start_time());
   date_trunc
----------------
 1 day 04:40:40


To know present time we use

postgres=# select current_timestamp;
              now
-------------------------------
 2018-04-14 08:21:29.043819-07


4. Demonstrate the usage of 'include' in postgresql.conf by giving
	1. work_mem, shared_buffers and temp_buffers into memory.conf
	2. max_connections, port and listen_addresses into conn.conf

ANS:

Postgresql.conf is the default file which it has all configuration parameters with default values.

AND

By using "include" Manually we can create new configuration files which ends with .conf.

Process for New conf files:

1). Open Postgresql.conf with VIM =======> vim Postgresql.conf
2). Press I button for Insert
3). Go to end of the Postgresql.conf file and type new conf. file names.
EX:
	include='memory.conf'
	include='conn.conf'
4). save and quit(:wq) from Postgresql.conf
5). Open memory.conf with VIM ===========> vim memory.conf
	work_mem=500MB
	shared_buffers=250MB
	temp_buffers=150MB
6). Open conn.conf with VIM ===========> vim conn.conf
	max_connections = 500
	port = 7878
	listen_addresses = '192.168.233.143'

7). Restart or Reload which ever its required.


Postgresql database check all the parameters from configuration file(Postgresql.conf). Sometimes while starting server we will get errors because of parameter issues. Read the error description and change the values accordingly.







5. Define the parameter affect hirerachy levels.







