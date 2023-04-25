create database casestudy1;

use casestudy1;


create table Dept 
( DeptNo int primary key,
 Dname varchar(50) not null,
 LOC varchar(50) not null);

 insert into Dept (
 DeptNo,Dname,LOC)
 values(10,'ACCOUNTING','NEW YORK'),
 (20,'RESEARCH','DALLAS'),
 (30,'SALES','CHICAGO'),
 (40,'OPERATIONS','BOSTON');

 select * from Dept;

 create table EMP
 (EMPNO int,
 ENAME varchar(40),
 JOB Varchar(50),
 MGR int,
 HIREDATE date,
 SAL int,
 COMM int,
 DEPTNO int);

 insert into EMP(
 EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
 values(7369,'SMITH','CLERK',7902,'17-Dec-80',800,null,20),
 (7499,'ALLEN','SALESMAN',7698,'20-Feb-81',1600,300,30),
 (7521,'WARD','SALESMAN',7698,'22-Feb-81',1250,500,30),
 (7566,'JONES','MANAGER',7839,'2-Apr-81',2975,null, 20),
(7654,'MARTI','SALESMAN',7698,'28-Sep-81', 1250, 1400,30),
(7698 ,'BLAKE','MANAGER',7839,'1-May-81', 2850,null, 30),
(7782 ,'CLARK', 'MANAGER', 7839,'9-Jun-81', 2450,null, 10),
(7788,'SCOTT','ANALYST',7566,'9-Dec-82',3000,null,20),
(7839,'KING','PRESIDENT',null,'17-Nov-81',5000,null,10),
(7844,'TURNER','SALESMAN',7698,'8-Sep-81',1500, 0,30),
(7876,'ADAMS','CLERK', 7788,'12-Jan-83', 1100,null, 20),
(7900,'JAMES','CLERK', 7698,'3-Dec-81',950,null,30),
(7902,'FORD','ANALYST',7566,'3-Dec-81',3000,null, 20),
(7934,'MILLER','CLERK',7782,'23-Jan-82',1300,null,10);


select * from EMP,Dept;


-- ASSIGNMENTS ON OPERATORS

--1) Display all the employees who are getting 2500 and excess salaries in department 20.

select ENAME from EMP 
where SAL >= 2500 and DEPTNO = 20 ;

-- 2) Display all the managers working in 20 & 30 department.

select * from EMP
where job='Manager' and (Deptno= 20 or Deptno= 30);


--3) Display all the managers who don’t have a manager
select Ename, job from Emp
where mgr is null;

--4) Display all the employees who are getting some commission with their designation is neither MANANGER nor ANALYST

select Ename,job,comm from emp
where Job != 'manager' and job != 'Analyst'
and comm is not null;

-- 5) Display all the ANALYSTs whose name doesn’t ends with ‘S’ 
select ename,job from emp
where job='Analyst' and ename not like '%s';

-- 6) Display all the employees whose naming is having letter ‘E’ as the last but one character

select ename from Emp
where ename like '%%%e_';

-- 7) Display all the employees who total salary is more than 2000.(Total Salary = Sal + Comm)


select ename,(Sal + coalesce(Comm,0)) as T_sal,sal,comm from emp
where (Sal + coalesce(Comm,0)) >2000;

-- 8) Display all the employees who are getting some commission in department 20 & 30.

select * from emp
where comm is not null and (Deptno = 20 or deptno = 30);

-- 9) Display all the managers whose name doesn't start with A & S

select * from emp
where ENAME not like 'A%' and Ename not like 'S%' and job = 'manager';


-- 10) Display all the employees who earning salary not in the range of 2500 and 5000 in department 10 & 20.
 select * from emp
 where sal not between 2500 and 5000
 and deptno in (10 , 20);



 -- ASSIGNMENTS ON GROUPING
 
 -- 11) Display job-wise maximum salary.

 select job,max(sal) maximum_salary from emp
 group  by job;

 -- 12) Display the departments that are having more than 3 employees under it.

 select dname,count(dname) No_of_emp_each_dept from Dept D join
 emp E on D.DeptNo=E.DEPTNO
 group by Dname
 having count(dname) >3;
 
 -- 13) Display job-wise average salaries for the employees whose employee number is not from 7788 to 7790.

select job,Avg(sal) Avg_sal from Emp
where EMPNO not between 7788 and 7790
group by job;

-- 14) Display department-wise total salaries for all the Managers and Analysts, only if the average salaries for the same is greater than or equal to 3000.

select D.dname, sum(sal) Total_sal 
from Dept d
join emp e
on d.DeptNo=e.deptno
where e.job in ('Manager', 'analyst')
group by D.dname,D.DeptNo
having Avg(e.sal)>=3000;



create table skills
(id int, 
Name varchar(20));


insert into skills (id,Name)
values(101,'Oracle'),
(102,'Oracle'),
(103,'Oracle'),
(101,'Oracle'),
(102,'Java'),
(103,'Java'),
(101,'Java'),
(102,'Java'),
(103,'Java'),
(101,'Java'),
(101,'Java'),
(101,'Oracle'),
(101,'VB'),
(102,'ASP');

select * from skills;


-- 15) Select only the duplicate records along-with their count.


select id,name, count(*) count from skills
group by id, name
having count(*)>1;
;

-- 16) Select only the non-duplicate records.

select id ,name, count(*) count
from skills
group by id, name
having count(*) =1;

-- 17) Select only the duplicate records that are duplicated only once. 


select * from skills
group by id , name
having count(*) =2;

-- 18) Select only the duplicate records that are not having the id=101.

select * from skills
where  id !=101
group by id,name
having count(*)> 1



--- ASSIGNMENTS ON SUBQUERIES

-- 19) Display all the employees who are earning more than all the managers


select EMPNO, SAL 
from emp where SAL > all (
select SAL from emp 
where JOB = 'MANAGER')and Job <> 'manager';


--20)Display all the employees who are earning more than any of the managers.


SELECT * FROM emp WHERE sal > ANY (SELECT sal FROM emp WHERE job = 'MANAGER')


-- 21)Select employee number, job & salaries of all the Analysts who are earning more than any of the managers.

select empno,Job,sal from emp
where job = 'Analyst' and sal > all(
select max(sal) from emp where job ='Manager')

-- 22)Select all the employees who work in DALLAS.

select empno, ename from emp
where deptno in (
select DEPTNO from dept where loc='Dallas')

-- 23)Select department name & location of all the employees working for CLARK.

select dname, loc from dept
where dept.deptno = (
select deptno from emp where ename='ClARK')

-- 24)Select all the departmental information for all the managers



-- 25)Display the first maximum salary

select max(sal) as Max_Salary from emp 
where sal = (
select max(sal) from Emp)

-- 26)Display the second maximum salary
 
SELECT MAX(sal) AS second_max_salary
FROM emp
WHERE sal < (
  SELECT MAX(sal)
  FROM emp
)

-- 27) Display the third maximum salary


 select e1.sal third_max_sal from emp e1
 where 3-1 = (select count(distinct sal) from emp e2 
 where e2.SAL > e1.SAL)


-- 28)Display all the managers & clerks who work in Accounts and Marketing departments.

select * from emp
where job in ('Manager' , 'Clerk') 
and DEPTNO in(
select deptno from dept
where Dname in ( 'Accounting','Marketing'))


-- 29)Display all the salesmen who are not located at DALLAS

select * from emp
where job = 'Salesman' and 
DEPTNO not in ( select DEPTNO from Dept
where loc='Dallas')


-- 30) Get all the employees who work in the same departments as of SCOTT.


SELECT * FROM EMP
WHERE DEPTNO IN(
SELECT DEPTNO FROM EMP
WHERE ENAME = 'SCOTT' )


-- 31) Select all the employees who are earning same as SMITH.

select * from emp
where sal = (select sal from emp
where ename='Smith')




-- ASSIGNMENTS ON EQUI-JOINS

-- 32)Display all the managers & clerks who work in Accounts and Marketing departments.

select * from emp
join dept on emp.DEPTNO=Dept.DeptNo
where (emp.JOB = 'Manager' or emp.JOB ='Clerk')
and (dept.Dname = 'Accounting' or dept.Dname = 'Marketing')


-- 33)Display all the salesmen who are not located at DALLAS.


select * from emp e 
join dept d on e.DEPTNO=d.DeptNo
where e.Job = 'Salesman' and d.LOC <> 'Dallas'


-- 34)Select department name & location of all the employees working for CLARK.

select d.dname, d.loc from emp e
join dept d on e.DEPTNO = d.DeptNo
where e.MGR = ( select EMPNO from emp
where ename='Clark')


-- 35)Select all the departmental information for all the managers


select d.* from emp e
join dept d
on e.DEPTNO = d.DeptNo
where e.mgr in (select EMPNO from emp 
where Job= 'Manager')

-- 36)Select all the employees who work in DALLAS.


select e.ename from emp e
join dept d on e.DEPTNO=d.DeptNo
where d.LOC = 'Dallas'


-- 37) Delete the records from the DEPT table that don’t have matching records in EMP

delete  from dept 
where DeptNo not in (select distinct d.DeptNo from dept d
join emp e on d.DeptNo=d.DeptNo)


-- ASSIGNMENTS ON OUTER-JOINS

-- 38)Display all the departmental information for all the existing employees and if a department has no employees display it as “No employees”.

select d.Dname,d.DeptNo,d.loc, coalesce(count(e.Empno),'No emploee') as NO_of_Employee from dept d
left join emp e
on d.DeptNo=e.DEPTNO
group by d.DeptNo, d.dname, d.LOC


-- 39) Get all the matching & non-matching records from both the tables.

select * from emp e
full outer join dept d on e.DEPTNO = d.DeptNo



-- 40) Get only the non-matching records from DEPT table (matching records shouldn’t be selected).

select d.* from dept d
left join emp e 
on d.DeptNo = e.DEPTNO
where e.DEPTNO is null


-- 41)Select all the employees name along with their manager names, and if an employee does not have a manager, display him as “CEO”.

select e1.ename as Employee_name, coalesce(e2.ename,'CEO') as Manager_name 
from EMP e1
left join emp e2 on e1.MGR =e2.Empno



-- 42)Get all the employees who work in the same departments as of SCOTT
 
select e1.ENAME ,e2.ename as collegue from emp e1
join emp e2 on e1.MGR = e2.EMPNO
where e1.DEPTNO in (select DEPTNO from EMP where  ename = 'Scott') 
and e2.ename <> 'Scott'


-- 43)Display all the employees who have joined before their managers

select e1.ename employee_name,e1.HIREDATE Employee_Join_date,
e2.ename manager_name, e2.HIREDATE manager_join_date from emp e1 
left join emp e2  on e1.MGR =e2.EMPNO
where e1.HIREDATE  < e2.HIREDATE



-- 44) List all the employees who are earning more than their managers.

select e1.Ename Employee_name, e1.sal Employe_salary,
e2.ename Manager_name,e2.sal manger_salary from emp e1
left join emp e2 on e1.MGR = e2.EMPNO 
where e1.SAL>e2.SAL


-- 45) Fetch all the employees who are earning same salaries

select e1.EMPNO, e1.ename employee_name, e1.sal employee_sal,
e2.EMPNO,e2.ename Emplyee_name, e2.sal Employee_sal
from emp e1, emp e2 
where e1.SAL=e2.SAL and e1.ENAME<> E2.ENAME


-- 46) Display employee name , his date of joining, his manager name & his manager's date of joining


select e1.Ename employee_name, e1.HIREDATE Employee_joining_date, 
e2.ename Manager_name, e2.hiredate manager_joining_date from emp e1 
left join emp e2 on e1.MGR =e2.EMPNO







