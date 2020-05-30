-- Включенные товары с вычитанием со склада, у которых закончился остаток, и их опции с нулевым остатком.
SET @language_id = 1;

SELECT p.product_id, pd.name, p.quantity, NULL AS option_value, NULL AS option_quantity
FROM oc_product p
         JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = @language_id
WHERE p.status = 1
  AND p.subtract = 1
  AND p.quantity <= 0

UNION ALL

SELECT p.product_id, pd.name, p.quantity, ovd.name, pov.quantity
FROM oc_product_option_value pov
         JOIN oc_product p ON p.product_id = pov.product_id
         JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = @language_id
         LEFT JOIN oc_option_value_description ovd ON ovd.option_value_id = pov.option_value_id AND ovd.language_id = @language_id
WHERE p.status = 1
  AND pov.subtract = 1
  AND pov.quantity <= 0

ORDER BY product_id, option_value;
