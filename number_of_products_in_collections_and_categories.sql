SELECT COUNT(p.product_id) AS total
FROM (
         SELECT DISTINCT p.product_id
         FROM (
                  SELECT *
                  FROM oc_category_path
                  WHERE path_id = 17
              ) AS c
                  LEFT JOIN oc_product_to_category AS p2c
                            ON c.category_id = p2c.category_id
                  JOIN oc_product AS p
                       ON p2c.product_id = p.product_id
         WHERE p.status = 1
           AND p.isbn = 'product'
     ) p
WHERE p.product_id NOT IN (
    SELECT DISTINCT opc.item_id
    FROM (
             SELECT *
             FROM oc_category_path
             WHERE path_id = 17
         ) AS c
             LEFT JOIN oc_product_to_category AS p2c
                       ON c.category_id = p2c.category_id
             LEFT JOIN oc_product AS p
                       ON p2c.product_id = p.product_id
             LEFT JOIN oc_product_combination AS opc
                       ON p.product_id = opc.product_id
    WHERE p.status = 1
      AND p.isbn = 'combination'
)
UNION
SELECT COUNT(DISTINCT opc.item_id) AS total
FROM (
         SELECT *
         FROM oc_category_path
         WHERE path_id = 17
     ) AS c
         LEFT JOIN oc_product_to_category AS p2c
                   ON c.category_id = p2c.category_id
         LEFT JOIN oc_product AS p
                   ON p2c.product_id = p.product_id
         LEFT JOIN oc_product_combination AS opc
                   ON p.product_id = opc.product_id
WHERE p.status = 1
  AND p.isbn = 'combination'
