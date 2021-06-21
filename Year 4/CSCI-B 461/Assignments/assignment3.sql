-- create database
create database anp;

-- connecting database
\c anp;

-- data1 dataset for for Assignment3

-- Person relation contains a unique ID (pid), a name, a city, and a birthyear.
drop table if exists person;
create table person (pid  integer,
                     name text,
                     city text,
                     birthYear integer,
                     primary key (pid));

insert into person values
  (1,'Nick','NewYork',1990),
  (2,'Deepa','Indianapolis',1985),
  (3,'Eric','NewYork',1990),
  (4,'Ryan','Indianapolis',1995),
  (5,'Hasan','Indianapolis',1990),
  (6,'Arif','Indianapolis',1980),
  (7,'Ryan','Chicago',1980),
  (8,'Jean','SanFransisco',2000),
  (9,'Aya','SanFransisco',1985),
  (10,'Lisa','NewYork',2000),
  (11,'Arif','Chicago',1990),
  (12,'Deepa','Bloomington',1990),
  (13,'Nick','SanFransisco',1980),
  (14,'Ryan','Indianapolis',1990),
  (15,'Nick','Indianapolis',1990),
  (16,'Anna','Chicago',1980),
  (17,'Lisa','Bloomington',1990),
  (18,'Ryan','Bloomington',1995),
  (19,'Lisa','Chicago',1980),
  (20,'Danielle','Indianapolis',1985),
  (21,'Eric','Chicago',1980),
  (22,'Anna','Indianapolis',1985),
  (23,'Chris','Bloomington',1990),
  (24,'Aya','NewYork',1995),
  (25,'Arif','SanFransisco',1990),
  (26,'Anna','Bloomington',2000),
  (27,'Latha','SanFransisco',2000),
  (28,'Eric','Bloomington',2000),
  (29,'Linda','Bloomington',1990),
  (30,'Aya','NewYork',1995);


-- Knows relation contains unique pairs of pids, where each pid references a Person. 
drop table if exists knows;
create table knows (pid1 integer,
                    pid2 integer,
                    primary key(pid1, pid2),
                    foreign key (pid1) references person(pid),
                    foreign key (pid2) references person(pid));

insert into knows values
  (5,22),
  (15,28),
  (10,27),
  (11,27),
  (13,14),
  (11,14),
  (5,28),
  (1,26),
  (18,24),
  (24,5),
  (6,26),
  (15,7),
  (15,25),
  (19,27),
  (10,5),
  (11,19),
  (20,22),
  (27,23),
  (24,29),
  (4,10),
  (26,12),
  (13,15),
  (19,4),
  (20,10),
  (10,6),
  (1,7),
  (17,23),
  (9,26),
  (3,10),
  (21,29),
  (27,15),
  (12,13),
  (16,3),
  (14,24),
  (14,28),
  (12,4),
  (15,8),
  (4,28),
  (18,11),
  (12,16),
  (30,12),
  (4,9),
  (4,8),
  (29,13),
  (29,20),
  (24,18),
  (16,13),
  (30,17),
  (23,22),
  (7,16),
  (29,22),
  (26,3),
  (28,30),
  (25,10),
  (3,22),
  (22,21),
  (30,3),
  (1,20),
  (19,11),
  (29,15),
  (13,30),
  (11,12),
  (1,5),
  (13,18),
  (24,19),
  (30,10),
  (4,12),
  (24,11),
  (18,22),
  (3,2),
  (4,3),
  (12,23),
  (25,24),
  (17,20),
  (28,10),
  (8,17),
  (15,13),
  (1,9),
  (6,18),
  (3,4),
  (4,19),
  (24,23),
  (27,3),
  (12,5),
  (12,2),
  (26,22),
  (30,15),
  (20,13),
  (28,14),
  (14,5),
  (1,10),
  (7,9),
  (27,22),
  (12,11),
  (16,20),
  (12,3),
  (17,7),
  (2,14),
  (18,25),
  (16,24);

-- Company relation contains unique pairs containing a company name (cname), and a city.
drop table if exists company;
create table company(cname text,
                     city  text,
                     primary key (cname, city));

insert into company values
  ('Amazon','NewYork'),
  ('IBM','NewYork'),
  ('Amazon','Indianapolis'),
  ('Amazon','Bloomington'),
  ('Intel','NewYork'),
  ('Netflix','Indianapolis'),
  ('Yahoo','Indianapolis'),
  ('Google','Bloomington'),
  ('Apple','Indianapolis'),
  ('Hulu','Chicago'),
  ('Hulu','NewYork'),
  ('Yahoo','Chicago'),
  ('Intel','Bloomington'),
  ('Google','Chicago'),
  ('Zoom','Chicago'),
  ('Yahoo','NewYork'),
  ('Yahoo','Bloomington'),
  ('Netflix','Bloomington'),
  ('Microsoft','Chicago'),
  ('Netflix','NewYork'),
  ('Microsoft','Indianapolis'),
  ('Zoom','SanFransisco'),
  ('Netflix','SanFrancisco'),
  ('Yahoo','SanFrancisco'),
  ('IBM','SanFrancisco');


-- Worksfor relation contains a unique ID referenced from Person, a company name, and a salary.
drop table if exists worksfor;
create table worksfor(pid    integer,
                      cname  text,
                      salary integer,
                      primary key(pid),
                      foreign key (pid) references person(pid));

insert into worksfor values
  (1,'IBM',60000),
  (2,'Hulu',50000),
  (3,'Amazon',45000),
  (4,'Microsoft',60000),
  (5,'Amazon',40000),
  (6,'IBM',50000),
  (7,'IBM',50000),
  (8,'Netflix',45000),
  (9,'Yahoo',50000),
  (10,'Hulu',40000),
  (11,'Apple',40000),
  (12,'Netflix',55000),
  (13,'Apple',40000),
  (14,'IBM',50000),
  (15,'IBM',40000),
  (16,'Apple',55000),
  (17,'Google',45000),
  (18,'Amazon',45000),
  (19,'Zoom',45000),
  (20,'Microsoft',55000),
  (21,'Intel',55000),
  (22,'IBM',40000),
  (23,'Apple',40000),
  (24,'Google',45000),
  (25,'Hulu',50000),
  (26,'Intel',55000),
  (27,'Intel',50000),
  (28,'Intel',50000),
  (29,'Google',60000),
  (30,'Intel',60000);

-- Jobskill relation contains all unique possible skills employees can have.
drop table if exists jobskill;
create table jobskill(skill text,
                      primary key(skill));
insert into jobskill values 
  ('Programming'), 
  ('Databases'), 
  ('AI'), 
  ('Networks'), 
  ('Mathematics');

-- Personskill contains unique pairs containing an ID referenced from Person and a skill referenced from Jobskill.
drop table if exists personskill;
create table personskill(pid integer,
                         skill text,
                         primary key(pid,skill),
                         foreign key (pid) references person(pid),
                         foreign key (skill) references jobskill(skill));

insert into personskill values
  (27,'Programming'),
  (18,'Mathematics'),
  (10,'AI'),
  (29,'Networks'),
  (23,'AI'),
  (4,'AI'),
  (1,'Databases'),
  (10,'Networks'),
  (9,'Programming'),
  (13,'Networks'),
  (9,'AI'),
  (27,'Mathematics'),
  (20,'AI'),
  (29,'Databases'),
  (5,'Programming'),
  (26,'Databases'),
  (1,'Networks'),
  (28,'AI'),
  (15,'Programming'),
  (16,'Mathematics'),
  (12,'Databases'),
  (15,'Databases'),
  (24,'Programming'),
  (14,'AI'),
  (25,'Networks'),
  (13,'AI'),
  (12,'Programming'),
  (22,'Programming'),
  (7,'Mathematics'),
  (10,'Programming'),
  (16,'Databases'),
  (19,'Programming'),
  (7,'Programming'),
  (22,'AI'),
  (5,'Databases'),
  (2,'Mathematics'),
  (14,'Programming'),
  (26,'Networks'),
  (19,'Networks'),
  (21,'Programming'),
  (14,'Mathematics'),
  (19,'AI'),
  (2,'Networks'),
  (8,'Databases'),
  (13,'Mathematics'),
  (29,'Programming'),
  (3,'AI'),
  (16,'Networks'),
  (5,'Networks'),
  (17,'AI'),
  (24,'Databases'),
  (2,'Databases'),
  (27,'Networks'),
  (28,'Databases'),
  (30,'Databases'),
  (4,'Networks'),
  (6,'Networks'),
  (17,'Networks'),
  (23,'Programming'),
  (20,'Programming');

-- Queries

\qecho 'Question 1.1'

-- Create a function that determines the product of two polynomials given the coefficients and corresponding degrees.

create table p(coefficient bigint,
				degree integer);
				
create table q(coefficient bigint,
				degree integer);
				
insert into p values (2, 2), (-5, 1), (5, 0);
insert into q values (4, 4), (3, 3), (1, 2), (-1, 1), (0, 0);

create or replace function multiplicationPandQ()
returns table(coefficient bigint, degree integer) as
$$
select cast(sum(p.coefficient*q.coefficient) as bigint), p.degree+q.degree
from p, q
group by p.degree+q.degree
order by p.degree+q.degree desc;
$$ language sql;

select * from multiplicationPandQ();

\qecho 'Question 1.2'

-- Create a function that calculates the dot product of two vectors given a list of indices and their corresponding values.

create table x(index integer,
				value integer);
				
create table y(index bigint,
				value integer);
				
insert into x values (1, 7), (2, -1), (3, 2);
insert into x values (1, 1), (2, 1), (3, -10);
	
create or replace function dotProductXandY() returns bigint as
$$
select cast(sum(x.value*y.value) as bigint)
from x, y
where x.index = y.index;
$$ language sql;

select * from dotProductXandY();

\qecho 'Question 2.3'

-- Rewrite using COUNT instead of set predicates

-- Original:

-- select p.pid, p.name
-- from Person p
-- where p.city = 'Bloomington' and
-- exists(select 1
-- from personSkill ps
-- where ps.pid = p.pid and ps.skill <> 'Programming' and
-- ps.skill in (select ps1.skill
-- from worksFor w1, personSkill ps1
-- where w1.cname = 'Netflix' and
-- ps1.skill <> 'AI' and
-- w1.pid = p.pid));

select p.pid, p.name
from Person p
where p.city = 'Bloomington' and
(select count(ps1)
from worksFor w1, personSkill ps1
where w1.cname = 'Netflix' and
ps1.skill <> 'AI' and ps1.skill <> 'Programming' and
w1.pid = p.pid) != 0;

\qecho 'Question 2.4'

-- Rewrite using COUNT instead of set predicates

-- Original:

-- select w.pid, w.cname, w.salary
-- from worksFor w
-- where not(w.salary <= all (select w1.salary
-- from worksFor w1, Company c
-- where w.pid <> w1.pid and w.cname = w1.cname and
-- c.city not in (select p.city
-- from Person p
-- where p.birthyear <> 1990)));

select w.pid, w.cname, w.salary
from worksFor w
where not(w.salary <= all (select w1.salary
from worksFor w1, Company c
where w.pid <> w1.pid and w.cname = w1.cname and
(select count(p.city)
from Person p
where p.city = c.city p.birthyear <> 1990) = 0));

\qecho 'Question 3.5'

-- Find the pid and name of each person who lives in `Bloomington' and who knows 
-- at most one person who has at least 3 job skills using aggregate functions.

select *
from person p
where p.city = 'Bloomington' and
(select count(k.pid1)
from knows k, knows k2
where p.pid = k.pid1 and k.pid1 = k2.pid1 and k.pid2 != k2.pid2 and
(select count(p.pid)
from person p 
where p.pid = k.pid2 and (select count(ps.skill)
from personskill ps
where p.pid = ps.pid
group by ps.pid) >=3) > 0
and (select count(p.pid)
from person p 
where k2.pid2 = p.pid and (select count(ps.skill)
from personskill ps
where p.pid = ps.pid
group by ps.pid) >=3) > 0) = 0;

\qecho 'Question 3.6'

-- Find the pid and name of each person who has all but three job skills using aggregate functions. 
-- I.e., such a person lacks precisely three job skills from the possible job skills that are stored in the relation jobSkill.

select *
from person p
where (select count(ps.skill)
from personskill ps
where p.pid = ps.pid
group by ps.pid) = 2
order by 1;

\qecho 'Question 3.7'

-- Find the cname of each company along with the number of persons who
-- work for that company and who know at least two other persons who also
-- work for that company using aggregate functions.

select w3.cname, 0
from worksfor w3
where (select count(w.cname)
from knows k, knows k1, worksfor w, worksfor w1, worksfor w2
where w3.cname = w.cname and k.pid1 = k1.pid1 and k.pid2 != k1.pid2
and k.pid1 = w.pid and k.pid2 = w1.pid and k1.pid2 = w2.pid
and w.cname = w1.cname and w1.cname = w2.cname) = 0 union
(select w.cname, count(w.cname)
from knows k, knows k1, worksfor w, worksfor w1, worksfor w2
where k.pid1 = k1.pid1 and k.pid2 != k1.pid2
and k.pid1 = w.pid and k.pid2 = w1.pid and k1.pid2 = w2.pid
and w.cname = w1.cname and w1.cname = w2.cname
group by w.cname);

\qecho 'Question 4.8'

-- Find the pid and name of each person who does not know any person who
-- has a salary strictly above 55000.

create function salaryabove(amount integer)
returns table(pid integer, name text, city text, birthyear integer) as
$$
select p.pid, p.name, p.city, p.birthyear
from person p, worksfor w
where p.pid = w.pid and w.salary > amount;
$$ language sql;

select k.pid1
from knows k
where k.pid2 in(select pid from salaryabove(55000));

\qecho 'Question 4.9'

-- Find the pid and name of each person who knows all the persons who (a)
-- work at Netflix, (b) make at least 55000, and (c) are born after 1985.

create function worksatNetflix()
returns table(pid integer) as
$$
select p.pid
from person p, worksfor w
where p.pid = w.pid and w.cname = 'Netflix';
$$ language sql;

create function bornafter1985()
returns table(pid integer) as
$$
select p.pid
from person p
where p.birthyear > 1985;
$$ language sql;

create function salaryatleast55000()
returns table(pid integer) as
$$
select p.pid
from person p, worksfor w
where p.pid = w.pid and w.salary >= 55000;
$$ language sql;

select p.pid, p.name
from person p, knows k
where p.pid = k.pid1 and k.pid2 in (select *
from worksatnetflix()
intersect
select *
from salaryatleast55000()
intersect
select *
from bornafter1985())
order by 1;

\qecho 'Question 5.10'

-- Find the set of job skills of persons who work for `IBM'.
 
create function skillsatIBM()
returns table(skill text) as
$$
select distinct ps.skill
from worksfor w, personskill ps
where ps.pid = w.pid and w.cname = 'IBM';
$$ language sql;

\qecho 'Question 5.11'

create function salaryatleast50000()
returns table(pid integer) as
$$
select p.pid
from person p, worksfor w
where p.pid = w.pid and w.salary >= 50000;
$$ language sql;

\qecho 'Question 5.12'

-- Find the pid and name of each person who knows at least 2 persons who
-- each have exactly 3 job skills.

create function has3jobskills()
returns table(pid integer) as
$$
select p.pid
from person p, personskill ps, personskill ps2, personskill ps3
where p.pid = ps.pid and p.pid = ps2.pid and ps3.pid = p.pid
and ps.skill != ps2.skill and ps2.skill != ps3.skill and ps.skill != ps3.skill;
$$ language sql;

\qecho 'Question 5.13'

-- Find the pairs (p1; p2) of different person pids such that the person with
-- pid p1 and the person with pid p2 knows the same number of persons.

create function knowshowmany(pid integer)
returns table(count bigint) as
$$
select count(k.pid2)
from knows k
where pid = k.pid1;
$$ language sql;

select p.pid, p2.pid
from person p, person p2
where p.pid != p2.pid and (select count from knowshowmany(p.pid)) = (select count from knowshowmany(p2.pid));

-- connect to default database
\c postgres;

-- drop database
drop database anp;