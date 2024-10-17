SELECT 
    CASE 
        WHEN PRSTN_STR_LW_LMT_R LIKE '%|% / %|%' THEN 
            REGEXP_REPLACE(PRSTN_STR_LW_LMT_R, '([a-zA-Z]+)\|[0-9]+(\s/\s[a-zA-Z]+)\|[0-9]+', '\1\2')
        WHEN PRSTN_STR_LW_LMT_R LIKE '%|% / %' THEN 
            REGEXP_REPLACE(PRSTN_STR_LW_LMT_R, '([a-zA-Z]+)\|[0-9]+(\s/\s[a-zA-Z]+)', '\1\2')
        ELSE 
            PRSTN_STR_LW_LMT_R -- Keep the value as it is for other cases
    END AS PRSTN_STR_LW_LMT_R_Modified
FROM your_table_name;