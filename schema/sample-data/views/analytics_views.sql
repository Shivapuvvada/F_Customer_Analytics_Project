-- Total monthly sales
CREATE VIEW monthly_sales_summary AS
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  COUNT(order_id) AS total_orders,
  SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month;

-- Best-selling products
CREATE VIEW top_products AS
SELECT 
  p.name,
  SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_units_sold DESC
LIMIT 10;
