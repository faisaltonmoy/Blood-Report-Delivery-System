CREATE OR REPLACE TRIGGER Patient_Info_trigger
AFTER INSERT OR UPDATE ON Patient_Info

DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------');
	DBMS_OUTPUT.PUT_LINE('Patient Info Table updated');
	DBMS_OUTPUT.PUT_LINE('--------------------------');
END;
/

CREATE OR REPLACE TRIGGER Report_Delivery_trigger
AFTER INSERT OR UPDATE ON Report_Delivery

DECLARE

BEGIN
    DBMS_OUTPUT.PUT_LINE('-----------------------------');
	DBMS_OUTPUT.PUT_LINE('Report Delivery Table updated');
	DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/