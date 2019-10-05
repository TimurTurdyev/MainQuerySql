START TRANSACTION;

UPDATE oc_product A
    INNER JOIN (
        SELECT P.product_id,
               P.price + (P.price / 100 * 5)           AS price,
               P.base_price + (P.base_price / 100 * 5) AS base_price
        FROM oc_product_group PG
                 JOIN oc_product P ON P.product_id = PG.product_id
        WHERE PG.group_id = 20
        GROUP BY P.product_id
    ) AS B
SET A.base_price = B.base_price
WHERE A.product_id = B.product_id;

UPDATE oc_product_option_value A
    INNER JOIN (
        SELECT OPOV.product_option_value_id,
               OPOV.base_price + (OPOV.base_price / 100 * 5) AS base_price
        FROM oc_product_group PG
                 LEFT JOIN oc_product_option_value OPOV ON PG.product_id = OPOV.product_id
        WHERE PG.group_id = 20
          AND OPOV.product_option_value_id IS NOT NULL
          AND currency_id != 0
    ) AS B
SET A.base_price = B.base_price
WHERE A.product_option_value_id = B.product_option_value_id;

UPDATE oc_product_option_value A
    INNER JOIN (
        SELECT OPOV.product_option_value_id,
               OPOV.price + (OPOV.price / 100 * 5) as price
        FROM oc_product_group PG
                 LEFT JOIN oc_product_option_value OPOV ON PG.product_id = OPOV.product_id
        WHERE PG.group_id = 20
          AND OPOV.product_option_value_id IS NOT NULL
          AND currency_id = 0
    ) AS B
SET A.price = B.price
WHERE A.product_option_value_id = B.product_option_value_id;

COMMIT;