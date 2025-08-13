-- Таблица Customers
CREATE TABLE Customers (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	age INT,
	country VARCHAR(50)
);

-- Таблица Orders
CREATE TABLE Orders (
 	order_id INT PRIMARY KEY,
 	item VARCHAR(50),
 	amount INT,
 	customer_id INT REFERENCES Customers(customer_id)
);

-- Таблица Shippings
CREATE TABLE Shippings (
 shipping_id INT PRIMARY KEY,
 status VARCHAR(20),
 customer_id INT REFERENCES Customers(customer_id)
);

-- Вставка данных
INSERT INTO Customers (customer_id, first_name, last_name, age, country)
VALUES
(1, 'John', 'Doe', 31, 'USA'),
(2, 'Robert', 'Luna', 22, 'USA'),
(3, 'David', 'Robinson', 22, 'UK'),
(4, 'John', 'Reinhardt', 25, 'UK'),
(5, 'Betty', 'Doe', 28, 'UAE'),
(6, 'Alice', 'Smith', 35, 'USA'),
(7, 'Michael', 'Brown', 40, 'UK'),
(8, 'Sarah', 'Davis', 29, 'UAE'),
(9, 'Tom', 'White', 31, 'USA'),
(10, 'Emma', 'Green', 27, 'UK');

INSERT INTO Orders (order_id, item, amount, customer_id) VALUES
(1, 'Keyboard', 400, 4),
(2, 'Mouse', 300, 4),
(3, 'Monitor', 12000, 3),
(4, 'Keyboard', 400, 1),
(5, 'Mousepad', 250, 2),
(6, 'Monitor', 10000, 6),
(7, 'Keyboard', 450, 6),
(8, 'Mouse', 350, 7),
(9, 'Monitor', 11000, 9),
(10, 'Mousepad', 300, 10);

INSERT INTO Shippings (shipping_id, status, customer_id) VALUES
(1, 'Pending', 2),
(2, 'Pending', 4),
(3, 'Delivered', 3),
(4, 'Pending', 5),
(5, 'Delivered', 1),
(6, 'Delivered', 6),
(7, 'Pending', 7),
(8, 'Delivered', 9),
(9, 'Pending', 8),
(10, 'Delivered', 10);

-- Представление: part_1 task_1
-- Найдите всех клиентов из страны 'USA', которым больше 25 лет
CREATE VIEW p1_task_1 AS
SELECT * 
FROM 
	Customers 
WHERE 
	country = 'USA' AND age > 25;

-- Представление:part_1 task_2
-- Выведите все заказы, у которых сумма (amount) больше 1000.
CREATE VIEW p1_task_2 AS
SELECT * 
FROM 
	Orders 
WHERE 
	amount > 1000;

-- Представление: part_2 task_1
-- Получите список заказов вместе с именем клиента, который сделал заказ
CREATE VIEW p2_task_1 AS
SELECT 
	c.first_name, 
	c.last_name, 
	o.item, 
	o.amount
FROM 
	Customers c
INNER JOIN 
	Orders o ON c.customer_id = o.customer_id; 

-- Представление: part_2 task_2
-- Выведите список доставок со статусом и именем клиента.
CREATE VIEW p2_task_2 AS
SELECT 
  	s.status,
  	c.first_name,
  	c.last_name
FROM 
	Shippings s
JOIN 
	Customers c ON s.customer_id = c.customer_id;

-- Представление: part_3 task_1
-- Подсчитайте количество клиентов в каждой стране.
CREATE VIEW p3_task_1 AS
SELECT 
	country, 
	count(*) AS count
FROM 
	Customers
GROUP BY 
	country;

-- Представление: part_3 task_2
-- Посчитайте общее количество заказов и среднюю сумму по каждому товару
CREATE VIEW p3_task_2 As
SELECT 
	item, 
	count(*) AS order_count, 
	AVG(amount) AS average_amount
FROM 
	Orders
GROUP BY 
	item;

-- Представление: part_4 task_1
-- Выведите список клиентов, отсортированный по возрасту по убыванию
CREATE VIEW p4_task_1 as
SELECT 
	first_name, 
	last_name, 
	age
FROM 
	Customers 
ORDER BY 
	age DESC;

-- Представление: part_5 task_1
-- Найдите всех клиентов, которые сделали заказ с максимальной суммой.
CREATE VIEW p5_task_1 AS
SELECT 
	c.first_name, 
	c.last_name, 
	o.amount
FROM 
	Customers c
JOIN 
	Orders o ON c.customer_id = o.customer_id
WHERE 
	o.amount = (
  		SELECT 
  			MAX(amount) 
  		FROM 
  			Orders
);

-- Представление: part_6 task_1
-- Для каждого заказа добавьте колонку с суммой всех заказов этого клиента (используя оконную функцию).
CREATE VIEW p6_task_1 as
SELECT 
  	o.order_id,
  	o.item,
  	o.amount,
  	c.customer_id,
  	SUM(o.amount) 
  	OVER (PARTITION BY o.customer_id) AS total_amount_by_customer
FROM 
	Orders o
JOIN 
	Customers c ON o.customer_id = c.customer_id
ORDER BY 
	order_id ASC;

-- Представление: part_7 task_1
/*
Найдите клиентов, которые:
1. Сделали хотя бы 2 заказа (любых),
2. Имеют хотя бы одну доставку со статусом 'Delivered'.
Для каждого такого клиента выведите:
● full_name (имя + фамилия),
● общее количество заказов,
● общую сумму заказов,
● страну проживания.
*/
CREATE VIEW p7_task_1 as
SELECT 
 	CONCAT(c.first_name, ' ', c.last_name) AS full_name,
  	COUNT(o.order_id) AS total_orders,
  	SUM(o.amount) AS total_amount,
  	c.country
FROM 
	Customers c
JOIN 
	Orders o ON c.customer_id = o.customer_id
WHERE 
	c.customer_id IN (
		SELECT DISTINCT 
			s.customer_id
  		FROM 
  			Shippings s
  		WHERE 
  			s.status = 'Delivered'
)
GROUP BY 
	c.customer_id, 
	c.first_name, 
	c.last_name, 
	c.country
HAVING 
	COUNT(o.order_id) >= 2;