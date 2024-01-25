CREATE TABLE BBW_DEMO.EMPLOYEES (
    EMP_ID INT,
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50),
    PHONE_NUMBER VARCHAR2(40),
    ADDRESS VARCHAR2(100),
    IS_MANAGER CHAR(1),
    DEPARTMENT_CODE CHAR(1),
    COMMENTS CHAR(30)
);

---
--- Insert 5,000,000 random rows
BEGIN
    FOR i IN 1..5000000 LOOP
        INSERT INTO BBW_DEMO.employees (EMP_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, ADDRESS, IS_MANAGER, DEPARTMENT_CODE, COMMENTS)
        VALUES (
            i,
            DBMS_RANDOM.string('U', DBMS_RANDOM.value(1, 20)),
            DBMS_RANDOM.string('U', DBMS_RANDOM.value(1, 20)),
            TO_CHAR(DBMS_RANDOM.value(100000000, 999999999)),
            DBMS_RANDOM.string('U', DBMS_RANDOM.value(1, 100)),
            CASE WHEN DBMS_RANDOM.value(0, 1) < 0.5 THEN 'Y' ELSE 'N' END,
            CASE WHEN DBMS_RANDOM.value(0, 1) < 0.33 THEN 'A' WHEN DBMS_RANDOM.value(0, 1) < 0.67 THEN 'B' ELSE 'C' END,
            DBMS_RANDOM.string('U', DBMS_RANDOM.value(1, 30))
        );
    END LOOP;
    COMMIT;
END;

--------

DECLARE
  v_emp_id INT;
  v_first_name VARCHAR2(50);
  v_last_name VARCHAR2(50);
  v_phone_number VARCHAR2(40);
  v_address VARCHAR2(100);
  v_is_manager CHAR(1);
  v_department_code CHAR(1);
  v_comments CHAR(30);
BEGIN
  FOR i IN 1..50000000 LOOP
    -- Generate logic-based values
    v_emp_id := i;
    v_first_name := 'FirstName' || i;
    v_last_name := 'LastName' || i;
    v_phone_number := '123-456-789' || i;
    v_address := 'Address' || i;
    v_is_manager := CASE WHEN i <= 25000000 THEN 'Y' ELSE 'N' END;
    v_department_code := CASE WHEN i <= 25000000 THEN 'A' ELSE 'B' END;
    v_comments := 'Comments' || i;

    -- Generate random values
    -- Modify the logic to generate random values for each column
    -- Example for emp_id: v_emp_id := DBMS_RANDOM.VALUE(1, 100000);

    -- Insert statement
    INSERT INTO BBW_DEMO.EMPLOYEES (
      EMP_ID,
      FIRST_NAME,
      LAST_NAME,
      PHONE_NUMBER,
      ADDRESS,
      IS_MANAGER,
      DEPARTMENT_CODE,
      COMMENTS
    ) VALUES (
      v_emp_id,
      v_first_name,
      v_last_name,
      v_phone_number,
      v_address,
      v_is_manager,
      v_department_code,
      v_comments
    );

    -- Commit after a certain number of inserts (adjust as needed)
    IF MOD(i, 1000) = 0 THEN
      COMMIT;
    END IF;
  END LOOP;

  COMMIT; -- Commit any remaining changes
END;
