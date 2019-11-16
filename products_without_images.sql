-- Включенные товары без главной картинки и без дополнительных фото.
SET @language_id = 1;

SELECT p.product_id, p.model, p.sku, pd.name
FROM oc_product p
         JOIN oc_product_description pd ON pd.product_id = p.product_id AND pd.language_id = @language_id
WHERE p.status = 1
  AND (p.image IS NULL OR p.image = '' OR p.image = 'no_image.png')
  AND NOT EXISTS (SELECT 1 FROM oc_product_image pi WHERE pi.product_id = p.product_id)
ORDER BY p.product_id;
