-- Sample inserts

-- Categories
INSERT INTO categories (name) VALUES ('Electronics'), ('Books'), ('Home & Kitchen');

-- Customers
INSERT INTO customers (full_name, email, phone, country, state, city, address)
VALUES 
('Alice Smith', 'alice@example.com', '1234567890', 'USA', 'California', 'San Francisco', '123 4th St');

-- Products
INSERT INTO products (name, description, category_id, price, stock_quantity)
VALUES 
('Bluetooth Speaker', 'Portable speaker with 10hr battery', 1, 49.99, 100),
('Cookbook', '100 easy recipes', 2, 15.99, 200);

-- Orders
INSERT INTO orders (customer_id, order_status, total_amount, payment_method, shipping_address)
VALUES 
(1, 'PAID', 65.98, 'Credit Card', '123 4th St, San Francisco');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
VALUES 
(1, 1, 1, 49.99, 49.99),
(1, 2, 1, 15.99, 15.99);
