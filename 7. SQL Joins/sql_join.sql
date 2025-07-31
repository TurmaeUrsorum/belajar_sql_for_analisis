-- Active: 1728529519693@@127.0.0.1@3306@sql_join

show TABLES

CREATE TABLE customers (
    customer_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO customers (customer_id, customer_name, email) VALUES
(1, 'John Doe', 'john.doe@example.com'),
(2, 'Jane Smith', 'jane.smith@example.com'),
(3, 'Bob Johnson', 'bob.johnson@example.com'),
(4, 'Alice Brown', 'alice.brown@example.com');



CREATE TABLE orders_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL
);

INSERT INTO orders_items (order_id, product_id, quantity) VALUES
(101, 1, 2),
(101, 3, 1),
(102, 2, 1),
(102, 4, 1),
(103, 5, 3),
(104, 2, 2),
(105, 1, 1),
(105, 3, 2);


CREATE TABLE orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO orders (order_id, customer_id, order_date) VALUES
(101, 1, '2024-02-25 08:00:00'),
(102, 2, '2024-02-25 09:30:00'),
(103, 3, '2024-02-26 10:15:00'),
(104, 1, '2024-02-26 12:45:00'),
(105, 4, '2024-02-27 14:20:00');


CREATE TABLE products (
    product_id INT NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price INT NOT NULL,
    category_id INT NOT NULL
);

INSERT INTO products (product_id, product_name, price, category_id) VALUES
(1, 'Laptop', 800, 1),
(2, 'Smartphone', 400, 2),
(3, 'Headphones', 50, 3),
(4, 'Tablet', 300, 1),
(5, 'Camera', 600, 4);


--1. Buatlah query dengan menggunakan subquery untuk mencari customer yang melakukan pembelian pertama pada tanggal 25-27 Februari 2024


SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE order_date BETWEEN '2024-02-25' AND '2024-02-27'
)

--2. Buatlah subquery untuk menampilkan order_id yang memiliki lebih dari 1 jenis produk.

SELECT * FROM orders

SELECT * FROM orders_items

SELECT order_id 
FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM orders_items
    GROUP BY order_id
    HAVING COUNT(*) > 1
);

--3 Buatlah subquery untuk menampilkan customer dengan total pembelanjaan (total price) paling banyak

SELECT * FROM customers

SELECT * FROM orders

SELECT * FROM orders_items

SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE order_id IN (
        SELECT order_id FROM orders_items
        GROUP BY order_id
        ORDER BY SUM(quantity) DESC
    )
);

--4 Buatlah subquery untuk menampilkan jenis produk yang memiliki harga 2x lipat lebih tinggi dari harga Smartphone.

SELECT * FROM products

SELECT product_name, price
FROM products
WHERE price > 2 * (
    SELECT price
    FROM products
    WHERE product_name = 'Smartphone'
);




