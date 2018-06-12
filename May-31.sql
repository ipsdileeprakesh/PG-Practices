 1. Demonstrate, how do you fetch sample of 10% from a table which has 10000 rows
ANS:
postgres=# create table hahaha (T int);
CREATE TABLE
postgres=# insert into hahaha values (generate_series(1,10000));
INSERT 0 10000
postgres=# select * from hahaha limit 1000;
 t  
----
  1
  2
  3
  4
  5
 ----------------------------.

And by using random() function we can get random values on every select query.

postgres=# select * from hahaha where random()<0.01 limit 10;
  t   
------
  130
  177
  244
  327
  694
  741
  809
  882
  898
 1304
(10 rows)



 2. Demonstrate the usage of COPY command, and try to use it via non super user
ANS:
Only Superuser (DBA's) can use COPY command to get the data from database tables.

postgres=# COPY (select * from hahaha where random()<0.01 limit 10) TO '/home/dileep/Desktop/sample_file.csv'; --------------> here file succesfully saved in given location.
COPY 10

postgres=> create table hehe (t int);
CREATE TABLE
postgres=> insert into hehe values (generate_series(1,1000));
INSERT 0 1000
postgres=> COPY (select * from hehe where random()<0.01 limit 10) TO '/home/dileep/Desktop/hehe_sample.csv'; --------------> user must be superuser to use COPY command
ERROR:  must be superuser to COPY to or from a file
HINT:  Anyone can COPY to stdout or from stdin. psql's \copy command also works for anyone.




 3. Demonstrate the speed of COPY command text vs Binary, while dumping to file.
ANS:
postgres=# select * from hihi;
 key | numeric |       repeat       
-----+---------+--------------------
   1 |   70.02 | 111111111111111111
   2 |   70.02 | 111111111111111111
   3 |   70.02 | 111111111111111111
   4 |   70.02 | 111111111111111111
   5 |   70.02 | 111111111111111111
   6 |   70.02 | 111111111111111111
   7 |   70.02 | 111111111111111111
   8 |   70.02 | 111111111111111111
   9 |   70.02 | 111111111111111111
  10 |   70.02 | 111111111111111111
(10 rows)

TEXT FORMAT:

postgres=# COPY (select * from hihi) TO '/home/dileep/Desktop/sample_file.csv' with csv header;
COPY 10

dileep@localhost ~  vim ~/Desktop/sample_file.csv 
key,numeric,repeat
1,70.02,111111111111111111
2,70.02,111111111111111111
3,70.02,111111111111111111
4,70.02,111111111111111111
5,70.02,111111111111111111
6,70.02,111111111111111111
7,70.02,111111111111111111
8,70.02,111111111111111111
9,70.02,111111111111111111
10,70.02,111111111111111111

BINARY FORMAT:

postgres=# COPY (select * from hihi) TO '/home/dileep/Desktop/sample_file.csv' with BINARY;
COPY 10
dileep@localhost ~  vim ~/Desktop/sample_file.csv 


PGCOPY
ÿ^M
^@^@^@^@^@^@^@^@^@^@^C^@^@^@^D^@^@^@^A^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^B^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^C^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^D^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^E^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^F^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^G^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@^H^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@    ^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿ^@^C^@^@^@^D^@^@^@
^@^@^@^L^@^B^@^@^@^@^@^B^@F^@Èÿÿÿÿÿÿ



here Binary format files are not readable, only postgres can understand the Binary format.



 4. Copy the records from a table by replacing all NULL values as 'NULL' text
ANS:
postgres=# select * from hihi;
 key | numeric |       repeat       
-----+---------+--------------------
   1 |   70.02 | 111111111111111111
   2 |   70.02 | 111111111111111111
   3 |   70.02 | 111111111111111111
   4 |   70.02 | 111111111111111111
   5 |   70.02 | 111111111111111111
   6 |   70.02 | 111111111111111111
   7 |   70.02 | 111111111111111111
   8 |   70.02 | 111111111111111111
   9 |   70.02 | 111111111111111111
  10 |   70.02 | 111111111111111111
(10 rows)

postgres=# update hihi set repeat = NULL;
UPDATE 10

postgres=# COPY (select * from hihi) TO '/home/dileep/Desktop/sample_file.csv' with csv header NULL 'NULL';
COPY 10


dileep@localhost ~ vim ~/Desktop/sample_file.csv 
key,numeric,repeat
1,70.02,NULL
2,70.02,NULL
3,70.02,NULL
4,70.02,NULL
5,70.02,NULL
6,70.02,NULL
7,70.02,NULL
8,70.02,NULL
9,70.02,NULL
10,70.02,NULL

 5. Difference between \copy and COPY (Google)
ANS:
1) COPY: Only superuser can use this command and this COPY command we can use in server level.
2) \copy: We need to give full file path if the data is in a different directory. The psql \COPY command transfers data from the system where you run the command through to the database server.