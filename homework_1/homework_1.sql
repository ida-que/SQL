-- 'employees' table
create table employees(
    id serial primary key,
    employee_name varchar(50) not null
);

insert into employees(employee_name)
select unnest (array['Charlotte','Aiden','Elian','Adelaide','Penelope','Mike','Connie','Stuart','Brooke','Oscar','Roland','Victor','Deanna','Honey','Justin','George','Max','Tiana','Vincent','James','Alina','Aida','Bruce','Dale','Amy','Sydney','Maria','Martin','Jessica','Frederick','Maya','Sabrina','Aston','Amanda','Brianna','Rubie','Florrie','Stuart','Clark','Adison','Agata','Lyndon','Alisa','Tyler','Alexander','Natalie','Aldus','Sarah','Vincent','Melanie','Abraham','Honey','Lucas','Blake','Garry','Arianna','Kelsey','Lana','Darcy','Emily','Marcus','Robert','Edgar','Vanessa','Catherine','Sabrina','Frederick','Jordan','Tyler','Adelaide']);

select * from employees;


-- 'salary' table
create table salary(
    id serial primary key,
    monthly_salary int not null
);

do $$
begin
	for i in 10..25 -- range of 10 to 25 in a loop
	loop
		insert into salary(monthly_salary)
		values (i*100); -- multiplying each loop value by 100 and inserting this value to monthly_salary
	end loop;
end $$;

select * from salary;

-- 'employee_salary' table
create table employee_salary
(id serial primary key,
employee_id int not null unique,
salary_id int not null);

do $$
declare
	v_row record; -- define that variable 'row' in table 'employees' is a record (row)
	v_max_salary_id int; -- define that variable 'max salary id' is an integer
begin
	select max(id)
	into v_max_salary_id
	from salary; -- looking for a maximum salary_id to pass to the random()
	for v_row in select * from employees limit 30 -- looping 30 records (rows) from 'employees' table
	loop
		insert into employee_salary(employee_id, salary_id) values(v_row.id, floor(random() * v_max_salary_id + 1)); -- passing the IDs from 'employee' and 'salary'
	end loop;
end $$;

insert into employee_salary(employee_id, salary_id) values(generate_series(200, 209), 1);

select * from employee_salary;

-- 'roles' table
create table roles(
    id serial primary key,
    role_name int not null unique
);

alter table roles
alter column role_name type varchar(30);

insert into roles(role_name)
select unnest(array['Junior Python developer', 'Middle Python developer', 'Senior Python developer', 'Junior Java developer', 'Middle Java developer', 'Senior Java developer', 'Junior JavaScript developer', 'Middle JavaScript developer', 'Senior JavaScript developer', 'Junior Manual QA engineer', 'Middle Manual QA engineer', 'Senior Manual QA engineer', 'Project Manager', 'Designer', 'HR', 'CEO', 'Sales manager', 'Junior Automation QA engineer', 'Middle Automation QA engineer', 'Senior Automation QA engineer']);


select * from roles;

-- 'roles_employee' table
create table roles_employee(
    id serial primary key,
    employee_id int not null unique references employees(id),
    role_id int not null references roles(id)
);


do $$
declare
	v_row record; -- define that variable 'row' in table 'employees' is a record (row)
	v_max_role_id int; -- define that variable 'max role id' is an integer
begin
	select max(id)
	into v_max_role_id
	from roles; -- looking for a maximum role_id to pass to the random()
	for v_row in select * from employees limit 40 -- looping 40 records (rows) from 'employees' table
	loop
		insert into roles_employee(employee_id, role_id) values(v_row.id, floor(random() * v_max_role_id + 1)); -- passing the IDs from 'employee' and 'roles'
	end loop;
end $$;


select * from roles_employee;










