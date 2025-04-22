-- eCommerce Relational Database Schema for MariaDB

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- -----------------------------
-- CUSTOMERS
-- -----------------------------
CREATE TABLE customers (
    customer_id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name           VARCHAR(100) NOT NULL,
    email               VARCHAR(100) UNIQUE NOT NULL,
    phone               VARCHAR(20),
    country             VARCHAR(50),
    state               VARCHAR(50),
    city                VARCHAR(50),
    address             TEXT,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- -----------------------------
-- PRODUCTS
-- -----------------------------
CREATE TABLE products (
    product_id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    description         TEXT,
    category_id         INT,
    price               DECIMAL(10,2) NOT NULL,
    stock_quantity      INT DEFAULT 0,
    is_active           BOOLEAN DEFAULT TRUE,
    created_at          DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- -----------------------------
-- CATEGORIES
-- -----------------------------
CREATE TABLE categories (
    category_id         INT AUTO_INCREMENT PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    description         TEXT
);

-- -----------------------------
-- ORDERS
-- -----------------------------
CREATE TABLE orders (
    order_id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id         BIGINT NOT NULL,
    order_status        ENUM('PENDING', 'PAID', 'SHIPPED', 'DELIVERED', 'CANCELLED', 'RETURNED') DEFAULT 'PENDING',
    order_date          DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount        DECIMAL(12, 2),
    payment_method      VARCHAR(50),
    shipping_address    TEXT,
    is_online_order     BOOLEAN DEFAULT TRUE,
    updated_at          DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- -----------------------------
-- ORDER ITEMS
-- -----------------------------
CREATE TABLE order_items (
    order_item_id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id            BIGINT,
    product_id          BIGINT,
    quantity            INT,
    unit_price          DECIMAL(10,2),
    subtotal            DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- -----------------------------
-- PAYMENTS
-- -----------------------------
CREATE TABLE payments (
    payment_id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id            BIGINT,
    payment_date        DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount              DECIMAL(12,2),
    method              VARCHAR(50),
    status              ENUM('SUCCESS', 'FAILED', 'PENDING'),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- -----------------------------
-- SHIPMENTS
-- -----------------------------
CREATE TABLE shipments (
    shipment_id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id            BIGINT,
    tracking_number     VARCHAR(100),
    carrier             VARCHAR(50),
    shipped_date        DATETIME,
    delivered_date      DATETIME,
    status              ENUM('PREPARING', 'IN_TRANSIT', 'DELIVERED', 'FAILED'),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- -----------------------------
-- REVIEWS
-- -----------------------------
CREATE TABLE product_reviews (
    review_id           BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id         BIGINT,
    product_id          BIGINT,
    rating              TINYINT CHECK (rating BETWEEN 1 AND 5),
    review_text         TEXT,
    review_date         DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
