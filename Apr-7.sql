	1. Demonstrate the usage of GROUP BY with UNION 
ANS:
TABLE1
  t |    add
---+-----------
 1 | Bangalore
 2 | Hyd
 3 | Delhi
 4 | Mumbai
 5 | Nellore 

TABLE2
 t |   add
---+---------
 1 | Nellore
 2 | Ongole
 3 | Guntur
 4 | vizag
 5 | Kadapa

SYNTAX: select add from table1 union select add from table2 group by add;
OUTPUT:
   add
-----------
 Guntur
 Delhi
 Bangalore
 vizag
 Kadapa
 Nellore
 Ongole
 Hyd
 Mumbai


	2. Demonstrate the usage of HAVING CLAUSE
ANS:
TABLE1
  t |    add
---+-----------
 1 | Bangalore
 2 | Hyd
 3 | Delhi
 4 | Mumbai
 5 | Nellore 
SYNTAX: select max(t), add from table1 group by add having max(t)>3;
OUTPUT:
 max |   add
-----+---------
   5 | Nellore
   4 | Mumbai




	3. Demonstrate the difference between GROUP BY AND DISTINCT.
  
ANS:	 SELECT t FROM newtest GROUP BY t;  Grouping opetions will be performed in memory if enough memory is exists.
	 vs
	 SELECT DISTINCT t FROM newtest;    Grouping operations will be performed in Disk storage, which takes more I/O and query execution will also takes more time.



	4. Display only even numbers from the below table?
ANS:  
e
----
  5
 11
 16
 18
  8
 15

SYNTAX: select e from even where e%2=0;
OUTPUT:
e
----
 16
 18
  8

	5. Display only odd numbers from the below table?
ANS:  
e
----
  5
 11
 16
 18
  8
 15

SYNTAX: select e from even where e%2=1;
OUTPUT:
e
----
 5
 11
 15
	
	6. Display the second maximum(6) number from the above table

SELECT o FROM one inn  => First and only executes one time


SELECT * FROM one out WHERE 2= (SELECT COUNT(*) FROM one inn WHERE out.o<=inn.o)



 inn.o  | out.o(Always const while comparing)
----+----			>=	<=
  1 >=  1			1	6						
  5 >=  5			2	5
  7 >=  7			3	4
  8 >=  8			4	3
  9 >=  9			5	2
 11 >= 11			6	1
