-- Артикулы и модели, которые повторяются у нескольких товаров.
SELECT 'sku' AS field, p.sku AS value, COUNT(*) AS products, GROUP_CONCAT(p.product_id ORDER BY p.product_id) AS product_ids
FROM oc_product p
WHERE p.sku != ''
GROUP BY p.sku
HAVING products > 1

UNION ALL

SELECT 'model', p.model, COUNT(*), GROUP_CONCAT(p.product_id ORDER BY p.product_id)
FROM oc_product p
WHERE p.model != ''
GROUP BY p.model
HAVING COUNT(*) > 1

ORDER BY field, products DESC;
