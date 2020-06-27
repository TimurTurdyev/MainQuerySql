-- Выключает все товары категории @category_id вместе с подкатегориями. Товар выключается,
-- даже если он лежит еще и в другой категории.
SET @category_id = 17;

START TRANSACTION;

UPDATE oc_product p
    JOIN (
        SELECT DISTINCT p2c.product_id
        FROM oc_category_path cp
                 JOIN oc_product_to_category p2c ON p2c.category_id = cp.category_id
        WHERE cp.path_id = @category_id
    ) tree ON tree.product_id = p.product_id
SET p.status = 0,
    p.date_modified = NOW()
WHERE p.status = 1;

SELECT ROW_COUNT() AS disabled;

COMMIT;
