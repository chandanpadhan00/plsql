SELECT 
    CASE 
        -- Case 1: Pattern with two numbers between pipes (|) 
        WHEN PRSTN_STR_LW_LMT_R LIKE '%|% / %|%' THEN 
            REGEXP_REPLACE(PRSTN_STR_LW_LMT_R, '\|[0-9]+(\s/\s)\|[0-9]+', '\1')

        -- Case 2: Pattern with one number between pipes (|) before the slash
        WHEN PRSTN_STR_LW_LMT_R LIKE '%|% / %' THEN 
            REGEXP_REPLACE(PRSTN_STR_LW_LMT_R, '\|[0-9]+(\s/\s)', '\1')
        
        -- Else, keep the value as is
        ELSE 
            PRSTN_STR_LW_LMT_R
    END AS PRSTN_STR_LW_LMT_R_Modified
FROM your_table_name;