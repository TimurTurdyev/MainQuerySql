-- Сколько товаров в категории @root_category и ее подкатегориях: отдельно вне коллекций и отдельно внутри коллекций.
SET @root_category = 17;

SELECT
    (
        SELECT COUNT(DISTINCT p.product_id)
        FROM oc_category_path cp
                 JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
                 JOIN oc_product p ON p.product_id = p2c.product_id
        WHERE cp.path_id = @root_category
          AND p.status = 1
          AND p.isbn = 'product'
          AND NOT EXISTS (
                SELECT 1
                FROM oc_category_path ccp
                         JOIN oc_product_to_category cp2c ON cp2c.category_id = ccp.category_id
                         JOIN oc_product collection ON collection.product_id = cp2c.product_id
                         JOIN oc_product_combination pc ON pc.product_id = collection.product_id
                WHERE ccp.path_id = @root_category
                  AND collection.status = 1
                  AND collection.isbn = 'combination'
                  AND pc.item_id = p.product_id
            )
    ) AS products_outside_collections,
    (
        SELECT COUNT(DISTINCT pc.item_id)
        FROM oc_category_path cp
                 JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
                 JOIN oc_product collection ON collection.product_id = p2c.product_id
                 JOIN oc_product_combination pc ON pc.product_id = collection.product_id
        WHERE cp.path_id = @root_category
          AND collection.status = 1
          AND collection.isbn = 'combination'
    ) AS products_in_collections;
