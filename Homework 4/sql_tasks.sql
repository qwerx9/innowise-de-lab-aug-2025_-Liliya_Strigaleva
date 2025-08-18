CREATE TABLE employees (
  	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
  	last_name VARCHAR(50) NOT NULL,
  	department VARCHAR(50),
  	salary DECIMAL(10, 2)
);

CREATE TABLE projects (
 	project_id SERIAL PRIMARY KEY,
 	project_name VARCHAR(100) NOT NULL,
  	budget DECIMAL(12, 2),
 	start_date DATE,
	end_date DATE
);

CREATE TABLE employee_projects (
  	employee_id INT,
  	project_id INT,
  	hours_worked INT,
  	PRIMARY KEY (employee_id, project_id),
  	FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
  	FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);

INSERT INTO employees (first_name, last_name, department, salary) 
VALUES
	('Alice', 'Smith', 'HR', 60000.00),
	('Bob', 'Johnson', 'IT', 75000.00),
	('Charlie', 'Brown', 'Finance', 62000.00),
	('Diana', 'Prince', 'IT', 80000.00),
	('Eve', 'Davis', 'HR', 58000.00);

INSERT INTO projects (project_name, budget, start_date, end_date) 
VALUES
	('Website Redesign', 150000.00, '2023-01-15', '2023-06-30'),
	('Mobile App Development', 200000.00, '2023-03-01', '2023-10-31'),
	('Internal Tools Upgrade', 80000.00, '2023-05-10', '2023-09-15');

INSERT INTO employee_projects (employee_id, project_id, hours_worked) 
VALUES
	(2, 1, 160), -- Bob Johnson (ID 2) on Website Redesign (ID 1)
	(4, 1, 120), -- Diana Prince (ID 4) on Website Redesign (ID 1)
	(2, 2, 200), -- Bob Johnson (ID 2) on Mobile App Development (ID 2)
	(1, 3, 80), -- Alice Smith (ID 1) on Internal Tools Upgrade (ID 3)
	(3, 3, 100); -- Charlie Brown (ID 3) on Internal Tools Upgrade (ID 3)

-- task_1_DML
/*
Действия: 
	1. Вставить двух новых сотрудников в таблицу Employees.
	2. Выбрать всех сотрудников из таблицы Employees.
	3. Выбрать только FirstName и LastName сотрудников из отдела 'IT'.
	4. Обновить Salary 'Alice Smith' до 65000.00.
	5. Удалить сотрудника, чья LastName — 'Prince'.
	6. Проверить все изменения, используя SELECT * FROM Employees;
*/
	
--1. Вставить двух новых сотрудников в таблицу Employees.
INSERT INTO employees (first_name, last_name, department, salary)
VALUES
	('Alex', 'Badboy', 'IT', 70000.00),
	('Stasy', 'Rows', 'Finance', 68000.00);

--2.Выбрать всех сотрудников из таблицы Employees.
SELECT * 
FROM 
	Employees;

--3. Выбрать только FirstName и LastName сотрудников из отдела 'IT'.
SELECT 
	first_name, 
	last_name
FROM 
	Employees
WHERE 
	department = 'IT';

--4. Обновить Salary 'Alice Smith' до 65000.00.
UPDATE 
	Employees
SET 
	Salary = 65000.00
WHERE 
	first_name = 'Alice' AND last_name = 'Smith';

--5. Удалить сотрудника, чья LastName — 'Prince'
DELETE FROM 
	employees
WHERE 
	last_name = 'Prince';

--6. Проверить все изменения, используя SELECT * FROM Employees;
SELECT * 
FROM 
	employees;

-- task_2_DDL
/*
Действия:
	1. Создать новую таблицу с именем Departments со столбцами:
		DepartmentID (SERIAL PRIMARY KEY), DepartmentName
		(VARCHAR(50), UNIQUE, NOT NULL), Location (VARCHAR(50)).
	2. Изменить таблицу Employees, добавив новый столбец с именем
		Email (VARCHAR(100)).
	3. Добавить ограничение UNIQUE к столбцу Email в таблице
		Employees, предварительно заполнив любыми значениями
	4. Переименовать столбец Location в таблице Departments в
		OfficeLocation.
*/

--1. Создать новую таблицу с именем Departments со столбцами:
--   DepartmentID (SERIAL PRIMARY KEY), DepartmentName
--   (VARCHAR(50), UNIQUE, NOT NULL), Location (VARCHAR(50)).
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE NOT NULL,
    location VARCHAR(50)
);

--2. Изменить таблицу Employees, добавив новый столбец с именем Email (VARCHAR(100)).
ALTER TABLE 
	employees
ADD COLUMN 
	email VARCHAR(100);

--3. Добавить ограничение UNIQUE к столбцу Email в таблице
--   Employees, предварительно заполнив любыми значениями
UPDATE 
	employees
SET 
	email = LOWER(CONCAT(last_name, '@email.com'))
WHERE 
	email IS NULL;

ALTER TABLE 
	employees
ADD CONSTRAINT 
	unique_email UNIQUE (email);

--4. Переименовать столбец Location в таблице Departments в OfficeLocation.
ALTER TABLE
	departments 
RENAME COLUMN 
	location TO office_location;

-- task_3_DCL
/*
Действия:
	1. Создать нового пользователя PostgreSQL (роль) с именем hr_user и
		простым паролем.
	2. Предоставить hr_user право SELECT на таблицу Employees.
	3. Тест: В новой сессии подключиться как hr_user и попытаться
		выполнить SELECT * FROM Employees;. (Должно сработать).
	4. Как hr_user, попытаться выполнить INSERT нового сотрудника в
		Employees. (Должно завершиться неудачей).
	5. Как пользователь-администратор, предоставить hr_user права
		INSERT и UPDATE на таблицу Employees.
	6. Тест: Как hr_user, попробовать выполнить INSERT и UPDATE
		сотрудника. (Теперь должно сработать).
*/

--1. Создать нового пользователя PostgreSQL (роль) с именем hr_user и
--   простым паролем.1
CREATE USER 
	hr_user 
WITH 
	LOGIN 
PASSWORD 
	'123123';

--2. Предоставить hr_user право SELECT на таблицу Employees.
CREATE ROLE employees_reader;

GRANT employees_reader TO hr_user;

GRANT SELECT ON TABLE employees TO employees_reader;

GRANT CONNECT ON DATABASE innowise_course TO hr_user;

GRANT USAGE ON SCHEMA public TO hr_user;

--3
--Выполнила тест, результат в "result_task"

--4
--Выполнила тест, результат в "result_task"

--5. Как пользователь-администратор, предоставить hr_user права
--   INSERT и UPDATE на таблицу Employees.

CREATE ROLE employees_editor;

GRANT employees_editor TO hr_user;

GRANT SELECT, INSERT, UPDATE ON TABLE employees TO employees_editor;

GRANT USAGE, SELECT ON SEQUENCE employees_employee_id_seq TO employees_editor;
--6
--Выполнила тест, результат в "result_task"

-- task_4_DML_DCL
/*
Действия:
	1. Увеличить Salary всех сотрудников в отделе 'HR' на 10%.
	2. Обновить Department любого сотрудника с Salary выше 70000.00
		на 'Senior IT'.
	3. Удалить всех сотрудников, которые не назначены ни на один проект в
		таблице EmployeeProjects. Подсказка: Используйте подзапрос NOT
		EXISTS или LEFT JOIN
	4. Вставить новый проект и назначить на него двух существующих
		сотрудников с определенным количеством HoursWorked в
		EmployeeProjects, и все это в одном блоке BEGIN/COMMIT.
*/

--1. Увеличить Salary всех сотрудников в отделе 'HR' на 10%.
UPDATE 
	employees
SET 
	salary = salary * 1.10
WHERE 
	department = 'HR';

--2. Обновить Department любого сотрудника с Salary выше 70000.00 на 'Senior IT'.
UPDATE 
	employees
SET 
	department = 'Senior IT'
WHERE 
	salary > 70000.00;

--3. Удалить всех сотрудников, которые не назначены ни на один проект в
--   таблице EmployeeProjects. Подсказка: Используйте подзапрос NOT
--	 EXISTS или LEFT JOIN
DELETE FROM 
	employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employee_projects ep
    WHERE ep.employee_id = e.employee_id
);

--4. Вставить новый проект и назначить на него двух существующих
--	 сотрудников с определенным количеством HoursWorked в
--	 EmployeeProjects, и все это в одном блоке BEGIN/COMMIT.
DO $$
DECLARE
    new_project_id INT;
BEGIN
    INSERT INTO projects (project_name, budget, start_date, end_date)  
    VALUES ('Automation App Development', 130000.00, '2023-02-15', '2023-07-30')
    RETURNING project_id INTO new_project_id;

    INSERT INTO employee_projects (employee_id, project_id, hours_worked) 
    VALUES
        (1, new_project_id, 160),
        (2, new_project_id, 85);
END;
$$;

--task_5_functions&views
/*
Действия:
	1. Функция: Создать функцию PostgreSQL с именем
		CalculateAnnualBonus, которая принимает employee_id и
		Salary в качестве входных данных и возвращает рассчитанную
		сумму бонуса (10 % от Salary) для этого сотрудника. Используйте
		PL/pgSQL для тела функции.
	2. Использовать эту функцию в операторе SELECT, чтобы увидеть
		потенциальный бонус для каждого сотрудника.
	3. Представление (View): Создать представление с именем
		IT_Department_View, которое показывает EmployeeID,
		FirstName, LastName и Salary только для сотрудников из отдела 'IT'.
	4. Выбрать данные из вашего представления IT_Department_View.
*/

/*1. Функция: Создать функцию PostgreSQL с именем
		CalculateAnnualBonus, которая принимает employee_id и
		Salary в качестве входных данных и возвращает рассчитанную
		сумму бонуса (10 % от Salary) для этого сотрудника. Используйте
		PL/pgSQL для тела функции.
*/
CREATE FUNCTION CalculateAnnualBonus(
	emp_id INT, 
	salary NUMERIC
)
RETURNS NUMERIC 

LANGUAGE plpgsql

AS $$

BEGIN
    RETURN salary * 0.10;
END;
$$; 

--2. Использовать эту функцию в операторе SELECT, чтобы увидеть
--	 потенциальный бонус для каждого сотрудника.
SELECT 
    employee_id,
    first_name,
    last_name,
    salary,
    CalculateAnnualBonus(employee_id, salary) AS bonus
FROM 
	employees;

--3. Представление (View): Создать представление с именем
--	 IT_Department_View, которое показывает EmployeeID,
--	 FirstName, LastName и Salary только для сотрудников из отдела 'IT'.
CREATE VIEW it_department_view AS
SELECT 
    employee_id,
    first_name,
    last_name,
    salary
FROM 
	employees
WHERE 
	department = 'IT';

--4. Выбрать данные из вашего представления IT_Department_View.
SELECT * FROM it_department_view;

--task_6_DML_optional
/*
Действия:
	1. Найти ProjectName всех проектов, в которых 'Bob Johnson'
		работал более 150 часов.
	2. Увеличить Budget всех проектов на 10%, если к ним назначен хотя
		бы один сотрудник из отдела 'IT'.
	3. Для любого проекта, у которого еще нет EndDate (EndDate IS
		NULL), установить EndDate на один год позже его StartDate.
	4. Вставить нового сотрудника и немедленно назначить его на проект
		'Website Redesign' с 80 отработанными часами, все в рамках одной
		транзакции. Использовать предложение RETURNING, чтобы получить
		EmployeeID вновь вставленного сотрудника.
*/

--1. Найти ProjectName всех проектов, в которых 'Bob Johnson' работал более 150 часов.
SELECT 
	p.project_name
FROM 
	projects p
INNER JOIN 
	employee_projects ep ON p.project_id = ep.project_id
INNER JOIN 
	employees e ON ep.employee_id = e.employee_id
WHERE 
	e.first_name = 'Bob' AND e.last_name = 'Johnson' AND ep.hours_worked > 150;

--2. Увеличить Budget всех проектов на 10%, если к ним назначен хотя
--	 бы один сотрудник из отдела 'IT'.
UPDATE 
	projects
SET 
	budget = budget * 1.10
WHERE 
	project_id IN (
    SELECT DISTINCT 
    	ep.project_id
    FROM 
    	employee_projects ep
    INNER JOIN 
    	employees e ON ep.employee_id = e.employee_id
    WHERE 
    	e.department = 'IT'
);

--3. Для любого проекта, у которого еще нет EndDate (EndDate IS NULL),
--	 установить EndDate на один год позже его StartDate.
UPDATE 
	projects
SET 
	end_date = start_date + INTERVAL '1 year'
WHERE 
	end_date IS NULL;

/*4. Вставить нового сотрудника и немедленно назначить его на проект
		'Website Redesign' с 80 отработанными часами, все в рамках одной
		транзакции. Использовать предложение RETURNING, чтобы получить
		EmployeeID вновь вставленного сотрудника.
*/
DO $$
DECLARE
    new_emp_id INT;
    target_project_id INT;
BEGIN
   
    SELECT project_id INTO target_project_id
    FROM 
		projects
    WHERE 
		project_name = 'Website Redesign';

    INSERT INTO employees (first_name, last_name, department, salary)
    VALUES 
		('Alice', 'Petrova', 'Marketing', 5200.00)
    RETURNING employee_id INTO new_emp_id;

    INSERT INTO employee_projects (employee_id, project_id, hours_worked)
    VALUES (new_emp_id, target_project_id, 80);
END;
$$;
