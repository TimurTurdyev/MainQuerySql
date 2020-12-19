-- Поднимает цены товаров группы @group_id на @percent процентов.
-- У товара меняется base_price, у опций - base_price для валютных опций и price для рублевых (currency_id = 0).
SET @group_id = 20;
SET @percent = 5;

START TRANSACTION;

UPDATE oc_product p
    JOIN (SELECT DISTINCT product_id FROM oc_product_group WHERE group_id = @group_id) pg ON pg.product_id = p.product_id
SET p.base_price = p.base_price + p.base_price / 100 * @percent;

UPDATE oc_product_option_value pov
    JOIN (SELECT DISTINCT product_id FROM oc_product_group WHERE group_id = @group_id) pg ON pg.product_id = pov.product_id
SET pov.base_price = pov.base_price + pov.base_price / 100 * @percent
WHERE pov.currency_id != 0;

UPDATE oc_product_option_value pov
    JOIN (SELECT DISTINCT product_id FROM oc_product_group WHERE group_id = @group_id) pg ON pg.product_id = pov.product_id
SET pov.price = pov.price + pov.price / 100 * @percent
WHERE pov.currency_id = 0;

COMMIT;
