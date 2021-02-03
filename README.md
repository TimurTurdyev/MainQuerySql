# Просто быстрые решения, в короткий промежуток времени

SQL для OpenCart 2.x / ocStore, MySQL 5.6-5.7. Параметры в начале файла в `SET @...`, таблицы с префиксом `oc_`.

Отчеты:

- `products_without_images.sql` - товары без картинок
- `products_without_category.sql` - товары без категории
- `duplicate_sku_and_model.sql` - повторы артикулов и моделей
- `empty_categories.sql` - пустые категории
- `out_of_stock_enabled.sql` - включенные товары с нулевым остатком
- `products_without_seo_url.sql` - товары и категории без ЧПУ
- `duplicate_seo_url.sql` - повторы ЧПУ
- `sales_by_month.sql` - продажи по месяцам
- `top_products_by_revenue.sql` - топ товаров по выручке
- `repeat_customers.sql` - повторные покупатели
- `number_of_products_in_collections_and_categories.sql` - сколько товаров в категории и в коллекциях

Правят базу:

- `price_update.sql` - поднять цены группы на процент
- `cleanup_expired_specials.sql` - убрать старые акции и скидки
- `disable_products_in_category.sql` - выключить товары категории
