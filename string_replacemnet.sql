SELECT 
  CASE 
    WHEN REGEXP_LIKE(column_name, '^[^|]+\|[^/]+/[^|]+\|') THEN 
      REGEXP_SUBSTR(column_name, '^([^|]+)', 1, 1) || ' / ' || 
      REGEXP_SUBSTR(column_name, '/([^|]+)', 1, 1, NULL, 1)
    WHEN REGEXP_LIKE(column_name, '^[^|]+\|[^/]+/[^|]+$') THEN 
      REGEXP_SUBSTR(column_name, '^([^|]+)', 1, 1) || ' / ' || 
      REGEXP_SUBSTR(column_name, '/(.+)$', 1, 1, NULL, 1)
    WHEN REGEXP_LIKE(column_name, '^[^/]+/[^|]+\|') THEN
      REGEXP_SUBSTR(column_name, '^(.+)/', 1, 1, NULL, 1) || ' / ' ||
      REGEXP_SUBSTR(column_name, '/([^|]+)', 1, 1, NULL, 1)
    ELSE column_name
  END AS extracted_value
FROM your_table;