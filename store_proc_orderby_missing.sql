CREATE OR REPLACE PROCEDURE new_check_table_existence
(
  p_table_list IN VARCHAR2
)
IS
  TYPE table_list_type IS TABLE OF VARCHAR2(100);
  v_table_list table_list_type := table_list_type();
  v_table_exists NUMBER;
  
  -- Define types for storing results
  TYPE result_record IS RECORD (
    table_name VARCHAR2(100),
    exists_flag BOOLEAN
  );
  TYPE result_table_type IS TABLE OF result_record;
  v_results result_table_type := result_table_type();
  
  -- Variables for counting
  v_missing_count NUMBER := 0;
  v_existing_count NUMBER := 0;
  
  -- Function to split the input string into a table
  FUNCTION string_to_table(p_string IN VARCHAR2, p_delimiter IN VARCHAR2 DEFAULT ',')
  RETURN table_list_type
  IS
    v_table table_list_type := table_list_type();
    v_start NUMBER := 1;
    v_index NUMBER;
  BEGIN
    LOOP
      v_index := INSTR(p_string, p_delimiter, v_start);
      IF v_index = 0 THEN
        v_table.EXTEND;
        v_table(v_table.COUNT) := TRIM(SUBSTR(p_string, v_start));
        EXIT;
      ELSE
        v_table.EXTEND;
        v_table(v_table.COUNT) := TRIM(SUBSTR(p_string, v_start, v_index - v_start));
        v_start := v_index + 1;
      END IF;
    END LOOP;
    RETURN v_table;
  END string_to_table;

BEGIN
  -- Convert input string to table
  v_table_list := string_to_table(p_table_list);
  v_results.EXTEND(v_table_list.COUNT);
  
  -- First, gather all results
  FOR i IN 1..v_table_list.COUNT LOOP
    SELECT COUNT(*) INTO v_table_exists
    FROM user_tables
    WHERE table_name = UPPER(v_table_list(i));
    
    v_results(i).table_name := v_table_list(i);
    v_results(i).exists_flag := (v_table_exists > 0);
    
    -- Count missing and existing tables
    IF v_table_exists > 0 THEN
      v_existing_count := v_existing_count + 1;
    ELSE
      v_missing_count := v_missing_count + 1;
    END IF;
  END LOOP;
  
  -- Output results
  DBMS_OUTPUT.PUT_LINE('Table Existence Report');
  DBMS_OUTPUT.PUT_LINE('------------------------');
  DBMS_OUTPUT.PUT_LINE('Total tables checked: ' || v_table_list.COUNT);
  DBMS_OUTPUT.PUT_LINE('Missing Tables: ' || v_missing_count);
  DBMS_OUTPUT.PUT_LINE('Existing Tables: ' || v_existing_count);
  DBMS_OUTPUT.PUT_LINE('------------------------');
  
  IF v_missing_count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('List of Missing Tables:');
    DBMS_OUTPUT.PUT_LINE('------------------------');
    -- Print missing tables
    FOR i IN 1..v_results.COUNT LOOP
      IF NOT v_results(i).exists_flag THEN
        DBMS_OUTPUT.PUT_LINE(v_results(i).table_name);
      END IF;
    END LOOP;
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('------------------------');
  DBMS_OUTPUT.PUT_LINE('List of Existing Tables:');
  DBMS_OUTPUT.PUT_LINE('------------------------');
  
  -- Then, print existing tables
  FOR i IN 1..v_results.COUNT LOOP
    IF v_results(i).exists_flag THEN
      DBMS_OUTPUT.PUT_LINE(v_results(i).table_name);
    END IF;
  END LOOP;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END new_check_table_existence;
/
