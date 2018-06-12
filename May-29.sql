1. Demonstrate the usage of DEFFERABLE PRIMARY KEY constraints?
ANS:
DEFFERABLE means Postpone
DEFERRED constraints are not checked until transaction commit. Each constraint has its own IMMEDIATE or DEFERRED mode.

Ex: 
postgres=# create table index(t int primary key);
CREATE TABLE
postgres=# begin;
BEGIN
postgres=# insert into index values(1);
INSERT 0 1
postgres=# insert into index values(1);
ERROR:  duplicate key value violates unique constraint "index_pkey"
DETAIL:  Key (t)=(1) already exists.
postgres=# end;
ROLLBACK

Because of Primary Key constraint duplication will not happen.
To avoid errors in transactions we can use Defferable Primary Key constraints, There are 3 types of Deferrable constraints.

DEFERRABLE INITIALLY DEFERRED, DEFERRABLE INITIALLY IMMEDIATE, or NOT DEFERRABLE

EX:
postgres=# create table index (t int primary key deferrable initially deferred);
CREATE TABLE
postgres=# begin;
BEGIN
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1					-----------------> here duplicates will allow till Commit the transaction.
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1
postgres=# insert into index values (1);
INSERT 0 1
postgres=# End;
ERROR:  duplicate key value violates unique constraint "index_pkey"
DETAIL:  Key (t)=(1) already exists.

Here Primary Key DEFERRABLE INITIALLY DEFERRED constraint will not check duplicated immediatly, once we commit the transaction the constraint will check the duplicates and shows as error as above example. So total transacton got rollback.

DEFERRABLE INITIALLY IMMEDIATE is the default one, where the constraint works immediatly in the transaction and shows error.
EX:
postgres=# create table index2 (t int primary key DEFERRABLE INITIALLY IMMEDIATE);
CREATE TABLE
postgres=# begin;
BEGIN
postgres=# insert into index2 values (1);
INSERT 0 1
postgres=# insert into index2 values (1);
ERROR:  duplicate key value violates unique constraint "index2_pkey"
DETAIL:  Key (t)=(1) already exists.

NOT DEFERRABLE is always IMMEDIATE and is not affected by the SET constraints.


2. Demonstrate the DEFERRABLE PRIMARY KEY along with FOREIGN KEY table?
ANS:
 
We cannot add deferrable unique constraints with foreign keys. we will get an error message if you try to add a foreign key that refers to a unique constraint that is deferrable.

postgres=# create table company(id int primary key deferrable initially deferred, name text);
CREATE TABLE
postgres=# begin;
BEGIN
postgres=# insert into company values (100,'DELL');
INSERT 0 1
postgres=# insert into company values (200,'LENOVO');
INSERT 0 1
postgres=# insert into company values (300,'HP');
INSERT 0 1
postgres=# end;
COMMIT
postgres=# create table customers(id int primary key, name text,companyid int);
CREATE TABLE
postgres=# insert into customers values (1,'Andhra',100);
INSERT 0 1
postgres=# insert into customers values (2,'Goa',200);
INSERT 0 1
postgres=# insert into customers values (3,'Pune',200);
INSERT 0 1
postgres=# alter table customers add Foreign key (companyid) references company(id);
ERROR:  cannot use a deferrable unique constraint for referenced table "company"



3. Demonstrate the usage of SEQUENCE?
ANS:

SEQUENCE is one type of constraint which defaulty gives series of numbers to inputs.

1)
postgres=# create table company2 (id serial, No int); -----------------> here serial datatype defaultly gives serial numbers for the id column
CREATE TABLE
postgres=# insert into company2(NO) values (12345);
INSERT 0 1
postgres=# insert into company2(NO) values (22345);
INSERT 0 1
postgres=# insert into company2(NO) values (32345);
INSERT 0 1
postgres=# select * from company2;
 id |  no   
----+-------
  1 | 12345
  2 | 22345
  3 | 32345
(3 rows)

Here we can give input manually for the Id column also, if we give any duplication table will consider it.

postgres=# insert into company2(id, NO) values (1,32345);
INSERT 0 1
postgres=# insert into company2(NO) values (25341);
INSERT 0 1
postgres=# select * from company2;
 id |  no   
----+-------
  1 | 12345
  2 | 22345
  3 | 32345
  1 | 32345-----------------------> manually entered data and displays duplication of id no.
  4 | 25341
(5 rows)


2)
postgres=# create sequence test1;
CREATE SEQUENCE
postgres=# create table company1(id int, No int);
CREATE TABLE
postgres=# insert into company1 values (nextval('test1'),10);
INSERT 0 1
postgres=# insert into company1 values (nextval('test1'),20);
INSERT 0 1
postgres=# insert into company1 values (nextval('test1'),30);
INSERT 0 1
postgres=# insert into company1 values (nextval('test1'),30);
INSERT 0 1
postgres=# select * from company1;
 id | no 
----+----
  1 | 10
  2 | 20
  3 | 30
  4 | 30
(4 rows)

But one drawback is there for nextval() function, in transaction if we rollback because of error, the sequence value will not reflect in table.

postgres=# begin;
BEGIN
postgres=# insert into company1 values (nextval('test1'),40);
INSERT 0 1
postgres=# insert into company1 values (nextval('test1'),aaa);
ERROR:  column "aaa" does not exist
LINE 1: insert into company1 values (nextval('test1'),aaa);
                                                      ^
postgres=# end;
ROLLBACK
postgres=# insert into company1 values (nextval('test1'),50);
INSERT 0 1
postgres=# insert into company1 values (nextval('test1'),60);
INSERT 0 1
postgres=# select * from company1;
 id | no 
----+----
  1 | 10
  2 | 20
  3 | 30
  4 | 30
  6 | 50	------------------------> here id no. 5 is succesfully generated in transaction because of error this nextval() function will not display the id no.
  7 | 60				  In transaction the sequence values cannot rollback.
(6 rows)



4. Demonstrate the usage of an INDEX on a table?
Ans:
INDEX its a kind of table which relates to the main table. The data whichever has inserted in Main Table, defaulty the same data will be stored in INDEX tables. 
EX:
postgres=# create table new (t int);
CREATE TABLE
postgres=# create index new1 on new (t);
CREATE INDEX
postgres=# insert into new values (10);
INSERT 0 1
postgres=# insert into new values (20);
INSERT 0 1
postgres=# \d+ new
                                    Table "public.new"
 Column |  Type   | Collation | Nullable | Default | Storage | Stats target | Description 
--------+---------+-----------+----------+---------+---------+--------------+-------------
 t      | integer |           |          |         | plain   |              | 
Indexes:
    "new1" btree (t)

postgres=# insert into new values (generate_series(1,100000));
INSERT 0 100000

When we search for the data in big tables, the queries will check the Index tables and display the output fastly.

postgres=# EXPLAIN SELECT * FROM NEW WHERE T=2545;
                             QUERY PLAN                              
---------------------------------------------------------------------
 Index Only Scan using new1 on new  (cost=0.29..8.31 rows=1 width=4)
   Index Cond: (t = 2545)
(2 rows)


postgres=# EXPLAIN ANALYZE SELECT * FROM NEW WHERE T=10;
                                                  QUERY PLAN                                                   
---------------------------------------------------------------------------------------------------------------
 Index Only Scan using new1 on new  (cost=0.29..8.31 rows=1 width=4) (actual time=0.017..0.019 rows=2 loops=1)----------> Index only scan means the query scans only Index Table
   Index Cond: (t = 10)
   Heap Fetches: 2
 Planning time: 0.085 ms
 Execution time: 0.041 ms					------------------------------------------> with index we got less time for output, the query will check the index and get 												the output quickly.
(5 rows)


postgres=# DROP INDEX NEW1;
DROP INDEX

postgres=# EXPLAIN ANALYZE SELECT * FROM NEW WHERE T=10;
                                           QUERY PLAN                                            
-------------------------------------------------------------------------------------------------
 Seq Scan on new  (cost=0.00..1693.03 rows=1 width=4) (actual time=0.027..13.757 rows=2 loops=1)------------> seq scan on means the query is going to scan whole Table.
   Filter: (t = 10)
   Rows Removed by Filter: 100000
 Planning time: 0.114 ms
 Execution time: 13.780 ms					-------------------------------------------> Here we dropped the Index and executed the same query but it took some time for 
									to execution and display the output, coz the query need to search whole table to get result.
(5 rows)







5. Demonstrate the performance issue with multiple indexes on a table?
ANS:
We can create multiple Indexes in Postgresql but there is a problem with multiple Indexes. 

If we Insert or Update or Delete the data in table, the same data should reflect in the multiple Indexes also, because of that latency will happen. It causes the performace issues.

EX:
postgres=# create table new (t int);
CREATE TABLE
postgres=# create index new1 on new(t);					-----------------> Index created
CREATE INDEX
postgres=# insert into new values (generate_series(1,1000000));
INSERT 0 1000000
postgres=# \di+ new1;							------------------> index new1 details shows size 21MB for total table.
                       List of relations
 Schema | Name | Type  |  Owner   | Table | Size  | Description 
--------+------+-------+----------+-------+-------+-------------
 public | new1 | index | postgres | new   | 21 MB | 
(1 row)

postgres=# update new set t=123 where t%2=1;
UPDATE 500000
postgres=# \di+ new1;							--------------------> index new1 details after update, here size 35MB means the updated data stored in Index table 
                       List of relations						and previous data also will be there in Index table, When we Insert the data in Main table, that data
 Schema | Name | Type  |  Owner   | Table | Size  | Description 			will overwrite that data space.
--------+------+-------+----------+-------+-------+-------------
 public | new1 | index | postgres | new   | 35 MB | 
(1 row)

postgres=# create index new2 on new (t);				---------------------> Index created
CREATE INDEX
postgres=# \di+ new2;							---------------------> Index new2 details shows size 21MB for total table.
                       List of relations
 Schema | Name | Type  |  Owner   | Table | Size  | Description 
--------+------+-------+----------+-------+-------+-------------
 public | new2 | index | postgres | new   | 21 MB | 
(1 row)




postgres=# \di+ new*;;							-----------------------> list of indexes on table New
                       List of relations
 Schema | Name | Type  |  Owner   | Table | Size  | Description 
--------+------+-------+----------+-------+-------+-------------
 public | new1 | index | postgres | new   | 35 MB | 
 public | new2 | index | postgres | new   | 21 MB | 
(2 rows)



If we have multiple indexes on table, when the query runs it takes data from smaller size index.


postgres=# EXPLAIN ANALYZE SELECT * FROM NEW WHERE T=10;
                                                   QUERY PLAN                                                   
----------------------------------------------------------------------------------------------------------------
 Index Only Scan using new2 on new  (cost=0.42..4.72 rows=17 width=4) (actual time=0.202..0.203 rows=1 loops=1) -------------> here the output taken from the small size index table.
   Index Cond: (t = 10)
   Heap Fetches: 0
 Planning time: 0.299 ms
 Execution time: 0.217 ms						--------------------------------------> Here query Execution taken less time and shown output from the smaller size 														Index File.
(5 rows)




postgres=# drop index new2;
DROP INDEX								--------------------------------------> Here drop smaller size Index


postgres=# EXPLAIN ANALYZE SELECT * FROM NEW WHERE T=10;
                                                    QUERY PLAN                                                    
------------------------------------------------------------------------------------------------------------------
 Index Only Scan using new1 on new  (cost=0.42..4.72 rows=17 width=4) (actual time=38.855..38.859 rows=1 loops=1)
   Index Cond: (t = 10)
   Heap Fetches: 0
 Planning time: 27.414 ms
 Execution time: 38.892 ms						---------------------------------------> Here query Execution took more time compare to previous one, because Index (5 rows)											file size is 35MB.


