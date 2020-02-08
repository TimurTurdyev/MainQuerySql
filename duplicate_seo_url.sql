-- Одинаковые ЧПУ у разных страниц: такие адреса открывают не ту страницу, что ожидается.
SELECT ua.keyword, COUNT(*) AS pages, GROUP_CONCAT(ua.query ORDER BY ua.query SEPARATOR ', ') AS queries
FROM oc_url_alias ua
WHERE ua.keyword != ''
GROUP BY ua.keyword
HAVING pages > 1
ORDER BY pages DESC, ua.keyword;
