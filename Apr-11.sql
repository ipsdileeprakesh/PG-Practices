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

5. Demonstrate the usage of LEFT and RIGHT outer joins

6. How to find the exact number of rows in a table without using COUNT(*) and reltuples from pg_class

7. What is the usage of ANALYZE command
ANS:
ANALYZE users; collects statistics for users table.
ANALYZE VERBOSE users; does exactly the same plus prints progress messages.