SELECT
   *
FROM
    company_dim
LIMIT 10;

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_catalog = 'data_jobs';


PRAGMA show_tables_expanded;