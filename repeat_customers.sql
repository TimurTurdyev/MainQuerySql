-- Покупатели с повторными заказами: сколько заказов, на какую сумму, первый и последний заказ.
-- Гости склеиваются по email, поэтому в выборку попадают и незарегистрированные.
SET @statuses = '5,3';
SET @min_orders = 2;

SELECT LOWER(o.email)                              AS email,
       MAX(o.customer_id)                          AS customer_id,
       MAX(CONCAT(o.firstname, ' ', o.lastname))   AS name,
       COUNT(*)                                    AS orders,
       ROUND(SUM(o.total), 2)                      AS spent,
       MIN(o.date_added)                           AS first_order,
       MAX(o.date_added)                           AS last_order,
       DATEDIFF(NOW(), MAX(o.date_added))          AS days_since_last_order
FROM oc_order o
WHERE FIND_IN_SET(o.order_status_id, @statuses)
  AND o.email != ''
GROUP BY LOWER(o.email)
HAVING orders >= @min_orders
ORDER BY spent DESC;
