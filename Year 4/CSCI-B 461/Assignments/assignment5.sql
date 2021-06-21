-- Aman Patel
-- CSCI-B 461
-- October 20, 2020

-- Assignment 5: Query translation and optimization

-- Question 1a 

-- Original query
select p1.pid, p1.name
from person p1, worksfor w1
where p1.pid = w1.pid and w1.cname = 'Google' and
	exists (select 1
			from person p2, worksfor w2
			where p2.pid = w2.pid and
			(p1.pid,p2.pid) in (select k.pid1,k.pid2 from knows k) and
			w1.salary < w2.salary);

-- Convert 'in' set predicates to 'exists'

select p1.pid, p1.name
from person p1, worksfor w1
where p1.pid = w1.pid and w1.cname = 'Google' and
	exists (select 1
			from person p2, worksfor w2
			where p2.pid = w2.pid and
			exists (select 1
					from knows k
					where p1.pid = k.pid1 and p2.pid = k.pid2 and w1.salary < w2.salary));

-- Remove inner 'exists' predicate

select p1.pid, p1.name
from person p1, worksfor w1
where p1.pid = w1.pid and w1.cname = 'Google' and
	exists (select 1
			from person p2, worksfor w2, knows k
			where p2.pid = w2.pid and p1.pid = k.pid1 and 
			p2.pid = k.pid2 and w1.salary < w2.salary);
			
-- Remove outer 'exists' predicate

select distinct p1.pid, p1.name
from person p1, worksfor w1, person p2, worksfor w2, knows k
where p1.pid = w1.pid and w1.cname = 'Google' and
p2.pid = w2.pid and p1.pid = k.pid1 and 
p2.pid = k.pid2 and w1.salary < w2.salary;

-- Move the condition w1.cname = 'Google' to 'google'

with google as (select pid as wpid, cname, salary from worksfor where cname = 'Google')
select distinct p1.pid, p1.name
from person p1, google g, person p2, worksfor w2, knows k
where p1.pid = g.wpid and
p2.pid = w2.pid and p1.pid = k.pid1 and 
p2.pid = k.pid2 and g.salary < w2.salary;

-- Introduce join operations and subquery, rewrite google subquery

with google as (select pid, name, salary from person natural join worksfor where cname = 'Google')
select distinct g.pid, g.name 
from google g cross join worksfor w
			  join knows k on g.pid = pid1 and w.pid = pid2
where g.salary < w.salary;
	 
-- RA expression




-- Question 2a

-- Original query
select p.pid
from person p
where p.pid = SOME (select ps.pid
					from personSkill ps
					where ps.skill = 'Programming' or ps.skill = 'Networks') and
	  p.pid <> ALL (select w.pid
				    from worksFor w
				    where w.cname = 'Amazon') and
	    not exists (select p1.pid
					from person p1
					where p1.city = 'Indianapolis' and
						  p1.pid in (select k.pid2 from knows k where k.pid1 = p.pid));
					
-- Convert 'in' set predicates to 'exists'

select p.pid
from person p
where p.pid = SOME (select ps.pid
					from personSkill ps
					where ps.skill = 'Programming' or ps.skill = 'Networks') and
	  p.pid <> ALL (select w.pid
					from worksFor w
					where w.cname = 'Amazon') and
		not exists (select p1.pid
					from person p1
					where p1.city = 'Indianapolis' and
						  exists (select 1 from knows k where k.pid1 = p.pid and k.pid2 = p1.pid));
						  
-- Convert some and all to exists

select p.pid
from person p
where exists (select 1
					from personSkill ps
					where (ps.skill = 'Programming' or ps.skill = 'Networks') and ps.pid = p.pid) and
	  not exists (select 1
					from worksFor w
					where w.cname = 'Amazon' and w.pid = p.pid) and
		not exists (select p1.pid
					from person p1
					where p1.city = 'Indianapolis' and
						  exists (select 1 from knows k where k.pid1 = p.pid and k.pid2 = p1.pid));
						  
-- Remove exists predicates

select distinct p.pid
from person p, personSkill ps
where (ps.skill = 'Programming' or ps.skill = 'Networks') and ps.pid = p.pid and
	  not exists (select 1
					from worksFor w
					where w.cname = 'Amazon' and w.pid = p.pid) and
		not exists (select p1.pid
					from person p1, knows k
					where p1.city = 'Indianapolis' and k.pid1 = p.pid and k.pid2 = p1.pid);
						  
-- Remove and not exists predicates

select distinct q.pid
from (select distinct p.pid
	  from person p, personSkill ps
	  where (ps.skill = 'Programming' or ps.skill = 'Networks') and ps.pid = p.pid
	  except
	  select distinct p.pid
	  from worksFor w, person p
	  where w.cname = 'Amazon' and w.pid = p.pid
	  except
	  select p.pid
	  from person p1, knows k, person p
	  where p1.city = 'Indianapolis' and k.pid1 = p.pid and k.pid2 = p1.pid) q;					  
						  
-- Introduce join operations					  

select distinct q.pid
from (select distinct p.pid
	  from person p
		   join personSkill ps on (ps.skill = 'Programming' or ps.skill = 'Networks') and ps.pid = p.pid
	  except
	  select distinct p.pid
	  from worksFor w
	       join person p on w.cname = 'Amazon' and w.pid = p.pid
	  except
	  select p.pid
	  from person p1
	       join knows k on k.pid2 = p1.pid and p1.city = 'Indianapolis'
		   join person p on k.pid1 = p.pid) q;		
		   
-- Rewrite using subqueries
with PN as (select distinct pid
            from person p natural join personSkill ps 
            where ps.skill = 'Programming' or ps.skill = 'Networks'),
     A as (select distinct pid
           from worksFor
     where cname = 'Amazon'),
     I as (select p.pid
           from person p1
           join knows k on k.pid2 = p1.pid and p1.city = 'Indianapolis'
           join person p on k.pid1 = p.pid)
select distinct q.pid
from (select * from PN
      except
      select * from A
      except
      select * from I) q;

-- Question 3a

-- Original query
select p1.pid, p2.pid
from person p1, person p2
where (p1.pid, p2.pid) in (select k.pid1, k.pid2 from knows k) and
	   not p2.birthyear > SOME (select p.birthyear
								from person p
								where p.pid in (select k.pid2
												from knows k
												where k.pid1 = p1.pid))
												order by 1,2;

-- Convert 'in' set predicates to 'exists'
select p1.pid, p2.pid
from person p1, person p2
where exists (select 1 from knows k where k.pid1 = p1.pid and k.pid2 = p2.pid) and
	   not p2.birthyear > SOME (select p.birthyear
								from person p
								where exists (select 1
												from knows k
												where k.pid1 = p1.pid and p.pid = k.pid2))
												order by 1,2;

-- Convert not > some to not exists
select p1.pid, p2.pid
from person p1, person p2
where exists (select 1 from knows k where k.pid1 = p1.pid and k.pid2 = p2.pid) and
	  not exists (select 1
				  from person p
				  where p2.birthyear > p.birthyear and 
				   		exists (select 1
								from knows k
								where k.pid1 = p1.pid and p.pid = k.pid2))
								order by 1,2;

-- Remove exists set predicates
select p1.pid, p2.pid
from person p1, person p2, knows k
where k.pid1 = p1.pid and k.pid2 = p2.pid and
	  not exists (select 1
				  from person p, knows k
				  where p2.birthyear > p.birthyear and k.pid1 = p1.pid and p.pid = k.pid2)
				  order by 1,2;

-- Remove not exists set predicate
select p1.pid, p2.pid
from person p1, person p2, knows k
where k.pid1 = p1.pid and k.pid2 = p2.pid
except
select p1.pid, p2.pid
from person p, knows k, person p1, person p2
where p2.birthyear > p.birthyear and k.pid1 = p1.pid and p.pid = k.pid2
order by 1,2;

-- Introduce join operations
select p1.pid, p2.pid
from person p1
	 cross join person p2
	 join knows k on k.pid1 = p1.pid and k.pid2 = p2.pid
except
select p1.pid, p2.pid
from person p
	 join knows k on p.pid = k.pid2
	 join person p1 on k.pid1 = p1.pid
	 join person p2 on p2.birthyear > p.birthyear
	 order by 1,2;
	 
-- Rewrite using subqueries
with K1 as (select p1.pid, p2.pid
			from person p1
				cross join person p2
				join knows k on k.pid1 = p1.pid and k.pid2 = p2.pid),
	 PB as (select p1.pid, p2.pid
			from person p
				join knows k on p.pid = k.pid2
				join person p1 on k.pid1 = p1.pid
				join person p2 on p2.birthyear > p.birthyear)
select *
from (select * from K1 
	  except 
	  select * from PB) q;
	  
-- RA Expression

select r1.a from r r1 join 
				(select * from r r2 join 
								(select a from r r3) q on r2.b = q.a) q2 on r1.b = q2.a;
			

-- Original query			
select ra.a
from Ra ra
where not exists (select r.b
				  from R r
				  where r.a = ra.a and
						r.b not in (select s.b from S s));
						
-- Remove 'not in' set predicate
select ra.a
from Ra ra
where not exists (select r.b
				  from R r
				  where r.a = ra.a and
						not exists (select 1 from S s where r.b = s.b));
						
-- Remove and not exists predicate
select ra.a
from Ra ra
where not exists (select r.b
				  from R r
				  where r.a = ra.a
				  except
				 (select s.b from S s, R r where r.b = s.b);
				 
-- Remove outer not exists predicate
select ra.a
from Ra ra
except
(select r.b
from R r, Ra ra
where r.a = ra.a
except
select s.b from S s, R r where r.b = s.b);

-- Question 6a

-- Original query
select ra.a
from Ra ra
where not exists (select s.b
				  from S s
				  where s.b not in (select r.b
									from R r
									where r.a = ra.a));
									
-- Remove not in predicate
select ra.a
from Ra ra
where not exists (select s.b
				  from S s
				  where not exists (select r.b
									from R r, S s
									where r.a = ra.a and s.b = r.b));
									
-- Remove inner not exists predicate
select ra.a
from Ra ra
where not exists (select s.b
				  from S s
				  except
				  select r.b
				  from R r, S s
				  where r.a = ra.a and s.b = r.b);
				  
-- Remove outer not exists predicate
select ra.a
from Ra ra
except
select s.b
from S s
except
select r.b
from R r, S s
where r.a = ra.a and s.b = r.b;