CREATE OR REPLACE TRIGGER Blood_Report_trigger
AFTER INSERT OR UPDATE ON Blood_Report

DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
	DBMS_OUTPUT.PUT_LINE('Blood Report Table updated');
	DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/