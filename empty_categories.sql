-- Включенные категории, в которых вместе с подкатегориями нет ни одного включенного товара.
SET @language_id = 1;

SELECT c.category_id, cd.name, c.parent_id
FROM oc_category c
         JOIN oc_category_description cd ON cd.category_id = c.category_id AND cd.language_id = @language_id
WHERE c.status = 1
  AND NOT EXISTS (
        SELECT 1
        FROM oc_category_path cp
                 JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
                 JOIN oc_product p ON p.product_id = p2c.product_id
        WHERE cp.path_id = c.category_id
          AND p.status = 1
    )
ORDER BY c.parent_id, c.sort_order, cd.name;
