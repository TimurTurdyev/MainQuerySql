-- Товары, которые не привязаны ни к одной категории, и товары без главной категории.
SET @language_id = 1;

SELECT p.product_id,
       pd.name,
       p.status,
       COUNT(p2c.category_id)                   AS categories,
       IF(SUM(p2c.main_category = 1) > 0, 1, 0) AS has_main_category
FROM oc_product p
         JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = @language_id
         LEFT JOIN oc_product_to_category p2c ON p2c.product_id = p.product_id
GROUP BY p.product_id, pd.name, p.status
HAVING categories = 0 OR has_main_category = 0
ORDER BY categories, p.product_id;
