1. How to find the used cached memory in OS level (Google)
ANS:
By using top and free -m commands we can get the memory details.

EX:
1). dileep@ubuntu:~$ free -m
              total        used        free      shared  buff/cache   available
Mem:           3922         859         308         301        2754        2428
Swap:          4093           0        4093

2). top - 07:23:48 up  8:47,  4 users,  load average: 0.08, 0.03, 0.00
Tasks: 245 total,   1 running, 244 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.0 us,  0.7 sy,  0.0 ni, 98.4 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem :  4016436 total,   322152 free,   873060 used,  2821224 buff/cache
KiB Swap:  4192252 total,  4192252 free,        0 used.  2493860 avail Mem

   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
  1820 dileep    20   0 1300212 134792  67388 S   1.6  3.4   5:55.98 compiz
 24832 dileep    20   0   41920   3756   3040 R   1.6  0.1   0:00.20 top
  1874 dileep    20   0  494424  27764  24212 S   0.3  0.7   0:52.15 vmtoolsd
     1 root      20   0  119732   5832   3960 S   0.0  0.1   0:08.42 systemd
     2 root      20   0       0      0      0 S   0.0  0.0   0:00.05 kthreadd
     4 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 kworker/0:0H
     6 root       0 -20       0      0      0 S   0.0  0.0   0:00.00 mm_percpu_wq
     7 root      20   0       0      0      0 S   0.0  0.0   0:04.89 ksoftirqd/0   


2. Install/Create pgfincore, pg_buffercache extensions in database level

3. Define what is the CHECKPOINT it's background behavior?
ANS:
Only superusers can call CHECKPOINT
It is a point where all the data files will update in disk and write the information in log files. 
In case of crash, the recovery procedure checks the latest CHECKPOINT and recovery the data till that point.
If any changes made for the data files before that CHECKPOINT is guaranteed to be in disk.






4. Install PostgreSQL 9.5 version, and demonstrate a dblink connection from your current version to the 9.5?
ANS:
In this case we should have two versions of Postgresql (Postgresql 9.6 and Postgresql 9.5).
SERVER 1 = Postgresql 9.6
SERVER 2 = Postgresql 9.5

In SERVER 1:

1st we need to install dblink by using right path ( dileep@ubuntu:~/postgres/postgresql-9.6.1/contrib$ make install dblink )

After installation we need to create extension dblink in postgresql.
postgres=# create extension dblink;
CREATE EXTENSION
postgres=# \dx
                                 List of installed extensions
  Name   | Version |   Schema   |                         Description
---------+---------+------------+--------------------------------------------------------------
 dblink  | 1.2     | public     | connect to other PostgreSQL databases from within a database
 plpgsql | 1.0     | pg_catalog | PL/pgSQL procedural language
(2 rows)

In SERVER 2:
Create table wiht values in SERVER 2
postgres=# select * from kumar;
 a |  b
---+-----
 1 | aaa
 2 | bbb
 3 | ccc
(3 rows)

TO GET SERVER2 FILES WE NEED TO CREATE DBLINK CONNECTION IN SERVER 1:
postgres=# select dblink_connect('link1', 'dbname=postgres port=5433 user=postgres host=localhost password=postgres');
 dblink_connect
----------------
 OK
(1 row)
IF DBLINK CONNECTION IS SUCCESFUL THEN
postgres=# select * from dblink('link1', 'select * from kumar') as test (t int, a varchar);
 t |  a
---+-----
 1 | aaa
 2 | bbb
 3 | ccc
(3 rows)

5. Demonstrate the usage of psql's -H, -R, -A, -t and -F parameters