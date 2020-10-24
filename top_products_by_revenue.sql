-- Топ товаров по выручке за период: штуки, выручка и в скольких заказах встречался товар.
SET @date_from = '2020-01-01';
SET @date_to = '2020-12-31 23:59:59';
SET @statuses = '5,3';

SELECT op.product_id,
       op.name,
       op.model,
       SUM(op.quantity)                                AS quantity,
       ROUND(SUM(op.total), 2)                         AS revenue,
       COUNT(DISTINCT op.order_id)                     AS orders,
       ROUND(SUM(op.total) / SUM(op.quantity), 2)      AS average_price
FROM oc_order_product op
         JOIN oc_order o ON o.order_id = op.order_id
WHERE o.date_added BETWEEN @date_from AND @date_to
  AND FIND_IN_SET(o.order_status_id, @statuses)
GROUP BY op.product_id, op.name, op.model
ORDER BY revenue DESC
LIMIT 0, 50;
