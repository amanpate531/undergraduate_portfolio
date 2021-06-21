-- Creating database "anp"
CREATE DATABASE anp;

-- Connecting database
\c anp;

-- Table Creation Statements
create table employee(id integer not null, 
                      ename text,
                      city text,
                      cname text,
                      salary integer,
                      primary key(id));
					  
create table company(cname text, 
					 city text, 
					 primary key(cname, city));

create table jobskill(id integer, 
					  skill text,
                      primary key(id, skill),
					  foreign key(id) references Employee(id));
					  
create table manages(mid integer, 
					 eid integer, 
					 primary key(mid, eid),
					 foreign key(mid) references Employee(id),
					 foreign key(eid) references Employee(id));
					 

-- Data for the employee relation.
INSERT INTO Employee VALUES
     (1001,'Jean','Bloomington','Apple',60000),
     (1002,'Vidya', 'Indianapolis', 'Apple', 45000),
     (1003,'Anna', 'Chicago', 'Amazon', 55000),
     (1004,'Qin', 'Denver', 'Amazon', 55000),
     (1005,'Aya', 'Chicago', 'Google', 60000),
     (1006,'Ryan', 'Chicago', 'Amazon', 55000),
     (1007,'Danielle','Indianapolis', 'Netflix', 50000),
     (1008,'Emma', 'Bloomington', 'Amazon', 50000),
     (1009,'Hasan', 'Bloomington','Apple',60000),
     (1010,'Linda', 'Chicago', 'Amazon', 55000),
     (1011,'Nick', 'NewYork', 'Google', 55000), 
     (1012,'Eric', 'Indianapolis', 'Apple', 50000),
     (1013,'Lisa', 'Indianapolis', 'Netflix', 55000),
     (1014,'Deepa', 'Bloomington', 'Apple', 50000), 
     (1015,'Chris', 'Denver', 'Amazon', 60000),
     (1016,'YinYue', 'Chicago', 'Amazon', 55000),
     (1017,'Latha', 'Indianapolis', 'Netflix', 60000),
     (1018,'Arif', 'Bloomington', 'Apple', 50000);

-- Data for the company relation.
INSERT INTO Company VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington');

-- Data for the jobskill relation.
insert into JobSkill values
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1008,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'AI'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Programming'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'Programming'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI');


-- Data for the manages relation.
INSERT INTO Manages VALUES
   (1001, 1002),
   (1001, 1009),
   (1001, 1012),
   (1009, 1018),
   (1009, 1014),
   (1012, 1014),
   (1003, 1004),
   (1003, 1006),   
   (1003, 1015),
   (1015, 1016),
   (1006, 1008),
   (1006, 1016),
   (1016, 1010),
   (1005, 1011),
   (1013, 1007),
   (1013, 1017);

-- Queries

\qecho 'Question 1.1'

select * from employee;
select * from company;
select * from jobskill;
select * from manages;

\qecho 'Question 1.2'

-- Entering value of wrong type

insert into manages values('Apple', 'Programming');

-- Entering value that contradicts previous value

insert into manages values(1002, 1001);
delete from manages where mid = 1002 and eid = 1001;

-- Entering value for foreign key that is not present in original table

insert into manages values(10000, 12031);

-- Entering a NULL value for a primary key

insert into employee values(NULL, 'John', 'Bloomington', 'Apple', 35000);

-- Entering a value with the wrong number of fields

insert into manages values(1001, 1002, 1003);

-- Entering a value that already exists in the table

insert into manages values(1001, 1002);

\qecho 'Question 2.1'

/* Find the id, name, and salary of each employee who lives in Indianapolis
and whose salary is in the range [30000; 50000]. */

select e.id, e.ename, e.salary
from employee e
where e.city = 'Indianapolis' and e.salary >= 30000 and e.salary <= 50000;

\qecho 'Question 2.2'

/* Find the id and name of each employee who works in a city located in
Chicago and who has a manager who lives in Bloomington. */

select e.id, e.ename
from employee e
where e.city = 'Chicago' and e.id in 
(select m.eid from manages m
where m.mid in (select e2.id from employee e2
where e2.city = 'Bloomington'));

\qecho 'Question 2.3'

/* Find the id and name of each employee who lives in the same city as at
least one of his or her managers. */

select e.id, e.ename
from employee e, employee e2, manages m
where e.city = e2.city and e.id = m.eid and e2.id = m.mid;

\qecho 'Question 2.4'

-- Find the id and name of each employee who has at least 3 job skills.

select e.id, e.ename
from employee e
where e.id in (select distinct j.id 
				from jobskill j
				group by j.id 
				having count(j.id) >= 3);

\qecho 'Question 2.5'

/* Find the id, name, and salary of each manager who manages an employee
who manages at least one other employee who has a programming job
skill. */

select e.id, e.ename, e.salary
from employee e
where e.id in (select distinct m2.mid from manages m2
where m2.eid in (select distinct m.mid from manages m
where m.eid in (select j.id from jobskill j where j.skill = 'Programming')));

\qecho 'Question 2.6'

-- For the pairs (id1, id2) of different employees who have a common manager.

select e.id, e2.id
from employee e, employee e2, employee man, manages m, manages m2
where m.mid = man.id and m2.mid = man.id and e.id = m.eid and e2.id = m2.eid and e.id != e2.id;

\qecho 'Question 2.7'

/* Find the cname of each company that does not have employees who live
in Bloomington. */

select distinct c.cname
from company c
where c.cname not in (select distinct e.cname from employee e
where e.city = 'Bloomington');

\qecho 'Question 2.8'

/* For each company, list its name along with the ids of its employees who
have the highest salary. */

select e.id, e.ename
from employee e
group by e.cname
having max(e.salary);

\qecho 'Question 2.9'

/* Find the id and name of each employee who does not have a manager with
a salary higher than that of the employee. */

select distinct emp.id, emp.ename
from employee emp
where emp.id not in (select distinct e.id
from employee e, manages m, employee e2
where e.salary >= e2.salary and e.id = m.eid and e2.id = m.mid);

\qecho 'Question 2.10'

/* Find the id and name of each manager who has none of the skills of the
employees that he or she manages. */

select distinct man.id, man.ename
from employee man, manages m2, employee e3
where m2.eid = e3.id and m2.mid = man.id and (man.id, man.ename) not in (select distinct emp.id, emp.ename
from employee emp, jobskill j2
where j2.id = emp.id and (emp.ename, j2.skill) in (select distinct e2.ename, j.skill
from jobskill j, employee e, manages m, employee e2
where e.id = m.eid and e2.id = m.mid and j.id = e.id));

--Connect to default database
\c postgres;

--Drop database which I created
DROP DATABASE anp;