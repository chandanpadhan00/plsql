SELECT 
  CASE 
    -- Condition 1: Both |TermA and |TermB present
    WHEN INSTR(PRSTN_STR_VAL_R, '|') > 0 AND INSTR(PRSTN_STR_VAL_R, '/') > 0 THEN 
      SUBSTR(PRSTN_STR_VAL_R, 1, INSTR(PRSTN_STR_VAL_R, '|') - 1) || ' / ' ||
      SUBSTR(PRSTN_STR_VAL_R, INSTR(PRSTN_STR_VAL_R, '/') + 2)
    
    -- Condition 2: Only |TermA is present, no |TermB
    WHEN INSTR(PRSTN_STR_VAL_R, '|') > 0 THEN
      SUBSTR(PRSTN_STR_VAL_R, 1, INSTR(PRSTN_STR_VAL_R, '|') - 1) || ' / ' || 
      SUBSTR(PRSTN_STR_VAL_R, INSTR(PRSTN_STR_VAL_R, '|', 1, 1) + 1)

    -- Condition 3: No pipes, return as is
    ELSE 
      PRSTN_STR_VAL_R
  END AS result
FROM your_table;