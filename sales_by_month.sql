-- Заказы, выручка и средний чек по месяцам. @statuses - id статусов, которые считаются продажей.
SET @date_from = '2020-01-01';
SET @statuses = '5,3';

SELECT DATE_FORMAT(o.date_added, '%Y-%m') AS month,
       COUNT(*)                           AS orders,
       ROUND(SUM(o.total), 2)             AS revenue,
       ROUND(AVG(o.total), 2)             AS average_check,
       COUNT(DISTINCT o.email)            AS customers
FROM oc_order o
WHERE o.date_added >= @date_from
  AND FIND_IN_SET(o.order_status_id, @statuses)
GROUP BY DATE_FORMAT(o.date_added, '%Y-%m')
ORDER BY month;
