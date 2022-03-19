SET SERVEROUTPUT ON;
SET VERIFY OFF;

----------------------       Package      -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE myPackage AS
	PROCEDURE deleteSerial(tSerial IN Patient_Info.SlId%TYPE);
END myPackage;
/
----------------------     Package Body   -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY myPackage AS
	PROCEDURE deleteSerial(tSerial IN Patient_Info.SlId%TYPE)
	IS 
		tempSlId NUMBER;
		
	BEGIN
		SELECT SlId into tempSlId from Patient_Info WHERE SlId = tSerial;
		
		IF tempSlId IS NOT NULL THEN
			DELETE FROM Patient_Info WHERE SlId = tempSlId;
			DELETE FROM Report_Delivery WHERE SlId = tempSlId;
			DELETE FROM Blood_Report@site1 WHERE SlId = tempSlId;
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number ' || tempSlId || ' has been deleted.');
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');		
		END IF;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number you have entered is not found');
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
			
	END deleteSerial;
END myPackage;
/ 

clear screen;
ACCEPT X NUMBER PROMPT "Enter Patient's Serial Number to Delete: "

DECLARE
	inputSerial Patient_Info.SlId%TYPE := '&X';
	
BEGIN
	myPackage.deleteSerial(inputSerial);

END;
/
COMMIT;