-- Товары и категории без ЧПУ. Для OpenCart 2.x таблица oc_url_alias, в 3.x она называется oc_seo_url
-- (там еще есть store_id и language_id).
SET @language_id = 1;

SELECT 'product' AS type, p.product_id AS id, pd.name
FROM oc_product p
         JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = @language_id
         LEFT JOIN oc_url_alias ua ON ua.query = CONCAT('product_id=', p.product_id)
WHERE p.status = 1
  AND ua.url_alias_id IS NULL

UNION ALL

SELECT 'category', c.category_id, cd.name
FROM oc_category c
         JOIN oc_category_description cd ON cd.category_id = c.category_id AND cd.language_id = @language_id
         LEFT JOIN oc_url_alias ua ON ua.query = CONCAT('category_id=', c.category_id)
WHERE c.status = 1
  AND ua.url_alias_id IS NULL

ORDER BY type, id;
