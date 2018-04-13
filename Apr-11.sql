1. Demonstrate compress and zipping files using tar command
ANS:
OS LEVEL: 
We use tar command to compress the files.
			tar -czvf name-of-archive.tar.gz /path/to/directory-or-file

Here’s what those switches actually mean:
-c: Create an archive.
-z: Compress the archive with gzip.
-v: Display progress in the terminal while creating the archive, also known as “verbose” mode. The v is always optional in these commands, but it’s helpful.
-f: Allows you to specify the filename of the archive.
-x: Extract the tar file


To extract the tar files.
			tar -xzvf name-of-archive.tar





2. Deomonstrate the usage of sed command
ANS:
SED= STREAM EDITOR

We use sed like, searching, find and replace, insertion or deletion. 
mostly used for substitution or for find and replace. 
By using SED you can edit files even without opening it, which is much quicker way to find and replace something in file.

EX:
cat> sedpractice.txt
unix is great os. unix is opensource. unix is free os.
learn operating system.
unix linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.
TO FIND AND REPLACE:
dileep@ubuntu:~$ sed 's/unix/linux/' sedpractice.txt
linux is great os. unix is opensource. unix is free os.
learn operating system.
linux linux which one you choose.
linux is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.


Many uses are available in Internet for SED command... Please check it online...



	
3. Create citext extension and demonstrate it's usage
ANS:		CREATE EXTENSION citext;
EX:	
Create table mobile(t text); 
insert into mobile values('My mobile is Old Mobile');
select * from mobile where t='my mobile is old mobile';   
t
---
(0 rows) 

It shows 0 rows means no output for the query, because in table mobile we given values as 'My mobile is Old Mobile', but in query we selecting as 'my mobile is old mobile')
So we have to create extenstion with citext.

CREATE EXTENSION citext;
Create table mobile(t citext); 
insert into mobile values('My mobile is Old Mobile');
select * from mobile where t='my mobile is old mobile';   
  t
-------------------------
 My mobile is Old Mobile
(1 row)

4. How to check the table size from OS level
ANS: 1st we need check table size in Postgres by using meta command (\dt+) 
then find file path by using select pg_relation_filepath('Table name');
O/P:  pg_relation_filepath
----------------------
 base/12439/352630 

Then logout from postgres and in O.S. level check the file path to know the Table location.

dileep@ubuntu:cd /opt/postgresql/pg96/data/base/12439 and use grep option to get the table size
dileep@ubuntu:/opt/postgresql/pg96/data/base/12439$ ls -l | grep 352630
O/P:
-rw------- 1 dileep dileep  36249600 Apr  9 05:34 352630
-rw------- 1 dileep dileep     32768 Apr  9 05:28 352630_fsm

5. Demonstrate the usage of All JOINS, ORDER BY, GROUP BY
ANS: We need two or more tables for using Joins
EX:
select * from client;
 client_id | client_name
-----------+-------------
       100 | Siemens
       200 | Dell
       300 | HP
       400 | Lenovo
       500 | Nokia
       600 | Samsung
      1000 | Apple 
select * from customers;
 id |   name   | age |          address          | salary  | client_id
----+----------+-----+---------------------------+---------+-----------
  1 | Ramesh   |  32 | Ahmedabad                 | 2000.00 |       100
  2 | Hardik   |  25 | Delhi                     | 1500.00 |       200
  3 | kaushik  |  23 | Kota                      | 2000.00 |       300
  4 | Chaitali |  25 | Mumbai                    | 6500.00 |       400
  5 | Hardik   |  27 | Bhopal                    | 8500.00 |       500
  6 | Komal    |  22 | Pune                      | 4500.00 |        60
  8 | Ramu     |  45 | Bangalore                 | 8000.00 |       800


1) JOIN: 

SELECT CUSTOMERS.NAME, client.client_id, client.client_name FROM CUSTOMERS JOIN client ON CUSTOMERS.client_id=client.client_id;
   name   | client_id | client_name
----------+-----------+-------------
 Ramesh   |       100 | Siemens
 Hardik   |       200 | Dell
 kaushik  |       300 | HP
 Chaitali |       400 | Lenovo
 Hardik   |       500 | Nokia 
2) LEFT JOIN: 

SELECT CUSTOMERS.NAME, client.client_id, client.client_name FROM CUSTOMERS LEFT JOIN client ON CUSTOMERS.client_id=client.client_id;
   name   | client_id | client_name
----------+-----------+-------------
 Ramesh   |       100 | Siemens
 Hardik   |       200 | Dell
 kaushik  |       300 | HP
 Chaitali |       400 | Lenovo
 Hardik   |       500 | Nokia
 Komal    |           |
 Ramu     |           |
3) RIGHT JOIN: 

SELECT CUSTOMERS.NAME, client.client_id, client.client_name FROM CUSTOMERS RIGHT JOIN client ON CUSTOMERS.client_id=client.client_id;
   name   | client_id | client_name
----------+-----------+-------------
 Ramesh   |       100 | Siemens
 Hardik   |       200 | Dell
 kaushik  |       300 | HP
 Chaitali |       400 | Lenovo
 Hardik   |       500 | Nokia
          |      1000 | Apple
          |       600 | Samsung
4) FULL OUTER JOIN: 

SELECT CUSTOMERS.NAME, client.client_id, client.client_name FROM CUSTOMERS FULL OUTER JOIN client ON CUSTOMERS.client_id=client.client_id;
   name   | client_id | client_name
----------+-----------+-------------
 Ramesh   |       100 | Siemens
 Hardik   |       200 | Dell
 kaushik  |       300 | HP
 Chaitali |       400 | Lenovo
 Hardik   |       500 | Nokia
 Komal    |           |
 Ramu     |           |
          |      1000 | Apple
          |       600 | Samsung

5) GROUP BY:
SELECT NAME, sum(SALARY) FROM CUSTOMERS GROUP BY NAME;
   name   |   sum
----------+----------
 Chaitali |  6500.00
 Ramu     |  8000.00
 kaushik  |  2000.00
 Komal    |  4500.00
 Hardik   | 10000.00
 Ramesh   |  2000.00

6) ORDER BY:
SELECT * FROM CUSTOMERS ORDER BY NAME, SALARY;
 id |   name   | age |          address          | salary  | client_id
----+----------+-----+---------------------------+---------+-----------
  4 | Chaitali |  25 | Mumbai                    | 6500.00 |       400
  2 | Hardik   |  25 | Delhi                     | 1500.00 |       200
  5 | Hardik   |  27 | Bhopal                    | 8500.00 |       500
  3 | kaushik  |  23 | Kota                      | 2000.00 |       300
  6 | Komal    |  22 | Pune                      | 4500.00 |        60
  1 | Ramesh   |  32 | Ahmedabad                 | 2000.00 |       100
  8 | Ramu     |  45 | Bangalore                 | 8000.00 |       800






6. How to find the exact number of rows in a table without using COUNT(*) and reltuples from pg_class
ANS: 
TO find ROWS (reltuples)
select reltuples from pg_class where oid='customers'::regclass;
 reltuples
-----------
         7
TO find PAGES (relpages)
select relpages from pg_class where oid='customers'::regclass;
 relpages
----------
        1
analyze verbose customers;
INFO:  analyzing "public.customers"
INFO:  "customers": scanned 1 of 1 pages, containing 7 live rows and 0 dead rows; 7 rows in sample, 7 estimated total rows




7. What is the usage of ANALYZE command
ANS:
ANALYZE users; collects statistics for users table.
ANALYZE VERBOSE users; does exactly the same plus prints progress messages.