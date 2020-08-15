-- Удаляет закончившиеся акционные цены и скидки. Сначала SELECT показывает, что уйдет.
START TRANSACTION;

SELECT 'special' AS type, COUNT(*) AS expired FROM oc_product_special WHERE date_end != '0000-00-00' AND date_end < CURDATE()
UNION ALL
SELECT 'discount', COUNT(*) FROM oc_product_discount WHERE date_end != '0000-00-00' AND date_end < CURDATE();

DELETE FROM oc_product_special WHERE date_end != '0000-00-00' AND date_end < CURDATE();
DELETE FROM oc_product_discount WHERE date_end != '0000-00-00' AND date_end < CURDATE();

COMMIT;
