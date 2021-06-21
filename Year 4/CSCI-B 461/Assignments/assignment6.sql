-- Aman Patel
-- October 29, 2020
-- CSCI-B 461

-- Assignment 6

-- Creating database "a6"
CREATE DATABASE a6;

-- Connecting database
\c a6;

-- Data for assignment 6

drop table if exists person;
create table person (pid  integer,
                     name text,
                     city text,
                     birthYear integer);

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
  (30,'Aya','NewYork',1995),
-- new
  (31,'Linda','London',1980);
-- 
drop table if exists knows;
create table knows (pid1 integer,
                    pid2 integer);

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
  (16,24),
  (31,3), (31,9), (31,11), (31,20), (31,21), (31,22), (31,23),
-- new
  (31,1), (31,2), (31,4), (31, 5), (31,6), (31,7), (31,8), (31,10), 
  (31,12), (31,14), (31,15), (31,16);
--

drop table if exists company;
create table company(cname text);

insert into company values
  ('Amazon'),
  ('IBM'),
  ('Intel'),
  ('Netflix'),
  ('Yahoo'),
  ('Google'),
  ('Apple'),
  ('Hulu'),
  ('Zoom'),
  ('Microsoft'),
  ('Britbox');

drop table if exists companyLocation;
create table companylocation(cname text,
                     city  text);

insert into companyLocation values
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



drop table if exists worksfor;
create table worksfor(pid    integer,
                      cname  text,
                      salary integer);


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
--  The next two tuples were deleted
--  (17,'Google',45000),
--  (18,'Amazon',45000),
  (18,'Amazon',55000),
  (19,'Zoom',45000),
  (20,'Microsoft',55000),
  (21,'Intel',55000),
  (22,'IBM',40000),
  (23,'Apple',40000),
--  The next tuple was deleted
--  (24,'Google',45000),
  (25,'Hulu',50000),
  (26,'Intel',55000),
  (27,'Intel',50000),
  (28,'Intel',50000),
--  The next tuple was deleted
--  (29,'Google',60000),
  (30,'Intel',60000);


drop table if exists jobskill;
create table jobskill(skill text);

insert into jobskill values 
  ('Programming'), 
  ('Databases'), 
  ('AI'), 
  ('Networks'), 
  ('Mathematics'),
-- new 
  ('Algorithms'),
--
  ('OperatingSystems');


drop table if exists personskill;
create table personskill(pid integer,
                         skill text);


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
--  The next tuple was deleted
--  (3,'Programming'),
  (16,'Networks'),
  (5,'Networks'),
  (17,'AI'),
  (24,'Databases'),
  (2,'Databases'),
  (27,'Networks'),
  (28,'Databases'),
  (30,'Databases'),
-- new
  (30,'OperatingSystems'),
-- 
  (4,'Networks'),
  (6,'Networks'),
  (17,'Networks'),
  (23,'Programming'),

-- new
  (1, 'OperatingSystems'),
  (29, 'OperatingSystems'),
  (31, 'Databases'),
-- 
  (20,'Programming');

-- Question 1a

/* Define a view cityHasCompanies(city,companies) which associates
with each city the set of cnames of companies who are located in that
city. */

create or replace view cityHasCompanies as
	select distinct city, array(select c1.cname
								from companylocation c1
								where c1.city = c.city order by cname) as companies
	from companylocation c;

-- Question 1b

/* Define a view companyLocations(cname,locations) which asso-
ciates with each company, identified by a cname, the set of cities
in which that company is located. */

create or replace view companylocations as
	select distinct cname, array(select c1.city
								from companylocation c1
								where c1.cname = c.cname order by city) as companies
	from company c;

-- Question 1c

/* Define a view knowsPersons(pid,persons) which associates with
each person, identified by a pid, the set of pids of persons he or she
knows. Observe that a person may know no one. */

create or replace view knowsPersons as
	select distinct pid, array(select k.pid2
								from knows k
								where p.pid = k.pid1 order by pid2) as people
	from person p
	order by pid;
	
-- Question 1d

/* Define a view isKnownByPersons(pid,persons) which associates
with each person, identified by a pid, the set of pids of persons who
know that person. Observe that there may be persons who are not
known by any one. */

create or replace view isKnownByPersons as
	select distinct pid, array(select k.pid1
								from knows k
								where p.pid = k.pid2 order by pid1) as people
	from person p
	order by pid;
	
-- Question 1e

/* Define a view personHasSkills(pid,skills) which associates with
each person, identified by a pid, his or her set of job skills. Observe
that a person may not have any job skills. */

create or replace view personHasSkills as
	select distinct pid, array(select ps.skill
								from personskill ps
								where ps.pid = p.pid order by skill) as skills
	from person p
	order by pid;

-- Question 1f

/* Define a view skillOfPersons(skills,persons) which associates
with each job skill the set of pids of persons who have that job skill.
Observe that there may be job skills that are not job skills of any
person. */

create or replace view skillOfPersons as
	select distinct js.skill, array(select ps.pid
								from personskill ps
								where ps.skill = js.skill order by pid) as pids
	from jobskill js
	order by skill;
	
-- Question 2a

/* Find the pid and name of each person who knows at least 2 persons
who work for `Amazon'. */

with amazon as (select ce1.employees
				from companyemployees ce1, companyemployees ce2
				where ce1.cname = ce2.cname and ce1.cname = 'Amazon')
select pid, name
from person p
where cardinality(setintersection((select * from amazon), 
								  (select k.people 
								   from knowspersons k 
								   where k.pid = p.pid))) >= 2;

-- Question 2b

/* Find the pid and name of each person who knows all persons who
work for `Amazon' and who make at most 40000. */

with amazon as (select pid 
				from companyemployees ce, worksfor w 
				where ce.cname = 'Amazon' and w.salary <= 40000 and w.cname = 'Amazon')
select p.pid, p.name
from person p
where overlap((select array(select * from amazon)), 
			  (select k.people 
			   from knowspersons k 
			   where k.pid = p.pid));

-- Question 2c

/* Find each skill that is not among the skills of employees of companies
located in `Bloomington' */

with Bloomco as (select companies from cityhascompanies where city = 'Bloomington'),
emps as (select ce.employees from companyemployees ce where isIn(ce.cname, (select * from Bloomco))),
pids as (select array_agg(distinct pid order by pid) from emps, unnest(employees) pid),
jobskills as (select phs.skills from person p, personhasskills phs where p.pid = phs.pid and isIn (p.pid, (select * from pids))),
skillList as (select array_agg(distinct skill order by skill) from jobskills, unnest(skills) skill)
select * from unnest((select * from setdifference((select array(select * from jobskill)), 
												  (select * from skillList)))) as skill;

-- Question 2d

/* Find each skill that is not among the skills of employees of companies
that have more than 5 employees. */

with emp as (select employees from companyemployees where cardinality(employees) > 5),
pids as (select array_agg(distinct pid order by pid) from emp, unnest(employees) pid),
jobskills as (select phs.skills from person p, personhasskills phs where p.pid = phs.pid and isIn (p.pid, (select * from pids))),
skillList as (select array_agg(distinct skill order by skill) from jobskills, unnest(skills) skill)
select * from unnest((select * from setdifference((select array(select * from jobskill)), 
												  (select * from skillList)))) as skill;

-- Question 2e

/* Find the pid of each person who only has skills that are skills of
persons who make less than 50000 and who work at `Amazon'. */

with amazon as (select pid from companyemployees ce, worksfor w where ce.cname = 'Amazon' and w.salary < 50000 and w.cname = 'Amazon'),
amazonskills as (select phs.pid, phs.skills from personhasskills phs where phs.pid in (select * from amazon)),
skillList as (select array_agg(distinct skill order by skill) from amazonskills, unnest(skills) skill)
select p.pid
from person p
where subset((select phs.skills from personhasskills phs where p.pid = phs.pid), (select * from skillList))

-- Question 2f

-- Find the pid of each person who has all but 4 job skills.

select p.pid
from person p
where cardinality(setdifference((select array (select * from jobskill)), 
								(select phs.skills 
								 from personhasskills phs 
								 where phs.pid = p.pid))) = 4

-- Question 2g

/* Find the pid and name of each person along with the set of persons
he or she knows and who work for 'Amazon'. */

with amazon as (select employees from companyemployees where cname = 'Amazon')
select p.pid, p.name, setintersection((select * from amazon), 
									  (select k.people from knowspersons k where k.pid = p.pid))
from person p

-- Question 2h

/* Find the pairs (p1; p2) such that not all persons who know person p1
are persons that are known by person p2. */

select count(*) from person p1, person p2
where not subset((select k.people from isknownbypersons k where k.pid = p1.pid), 
				 (select k.people from knowspersons k where k.pid = p2.pid));

-- Question 2i

/* Find the pid of each person along with the set of his of her skills
that are among the skills of employees who work for `Amazon' or for
`Google'. */

with amaGoo as (select * from setunion((select employees from companyemployees where cname = 'Amazon'), (select employees from companyemployees where cname = 'Google'))),
amaGooskills as (select phs.pid, phs.skills from personhasskills phs where isIn(phs.pid, (select * from amaGoo))),
skillList as (select array_agg(distinct skill order by skill) from amaGooskills, unnest(skills) skill)
select p.pid, setintersection((select * from skillList), (select phs.skills from personhasskills phs where phs.pid = p.pid))
from person p

--Connect to default database
\c postgres;

--Drop database which I created
DROP DATABASE a6;