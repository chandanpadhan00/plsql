SELECT 
  CASE 
    WHEN INSTR(CONC_STR_VAL_R, '|') > 0 THEN 
      SUBSTR(CONC_STR_VAL_R, 1, INSTR(CONC_STR_VAL_R, '|') - 1) || ' / ' ||
      SUBSTR(CONC_STR_VAL_R, INSTR(CONC_STR_VAL_R, '/', 1, 1) + 1, INSTR(CONC_STR_VAL_R, '|', 1, 2) - INSTR(CONC_STR_VAL_R, '/', 1, 1) - 1)
    ELSE 
      CONC_STR_VAL_R
  END AS result
FROM your_table;