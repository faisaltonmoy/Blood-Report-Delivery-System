SET SERVEROUTPUT ON;
SET VERIFY OFF;

----------------------       Package      -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE myPackage AS
	PROCEDURE insertTables(tName IN Patient_Info.Name%TYPE, tAge IN Patient_Info.Age%TYPE, tPhone IN Patient_Info.Phone%TYPE);
END myPackage;
/
----------------------     Package Body   -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY myPackage AS
	PROCEDURE insertTables(tName IN Patient_Info.Name%TYPE, tAge IN Patient_Info.Age%TYPE, tPhone IN Patient_Info.Phone%TYPE)
	IS 
	tempSlId NUMBER;
	initSerial NUMBER := 1000;
	
	BEGIN
		SELECT max(SlId) into tempSlId from Patient_Info; 
		
		IF tempSlId IS NOT NULL THEN
			tempSlId := tempSlId + 1;
			INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (tempSlId,tName,tAge,tPhone);
			INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (tempSlId,0,0,NULL,NULL);
			INSERT INTO Blood_Report@site1 (SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome) 
					VALUES (tempSlId,NULL,NULL,NULL,NULL,NULL,NULL);		
		
		ELSIF tempSlId IS NULL THEN	
			INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (initSerial,tName,tAge,tPhone);
			INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (initSerial,0,0,NULL,NULL);
			INSERT INTO Blood_Report@site1 (SSlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome) 
					VALUES (initSerial,NULL,NULL,NULL,NULL,NULL,NULL);
			
		END IF;
			
	END insertTables;
END myPackage;
/ 

clear screen;
ACCEPT X PROMPT "Enter Patient's Name: "
ACCEPT Y NUMBER PROMPT "Enter Patient's Age: "
ACCEPT Z PROMPT "Enter Patient's Phone: "

DECLARE
	inputName Patient_Info.Name%TYPE := '&X';
	inputAge Patient_Info.Age%TYPE := &Y;
	inputPhone Patient_Info.Phone%TYPE := '&Z';
	InvalidNameEx EXCEPTION;
	InvalidAgeEx EXCEPTION;
	InvalidPhoneEx EXCEPTION;
	
BEGIN
	IF NOT regexp_like (inputName, '^[a-zA-Z .''-]+$') THEN
		RAISE InvalidNameEx;
	END IF; 
	
	IF inputAge < 1 OR inputAge > 100 THEN
		RAISE InvalidAgeEx;
	END IF;
	
	IF NOT regexp_like (inputPhone, '(^(\+8801|8801|01))[1|3-9]{1}(\d){8}$') THEN
		RAISE InvalidPhoneEx;
	END IF;
	
	
	myPackage.insertTables(inputName,inputAge,inputPhone);
	
	
	
EXCEPTION
	WHEN InvalidNameEx THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Patient Name.');
		DBMS_OUTPUT.PUT_LINE('Enter a valid Name, only contains character: a-z or A-Z');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	WHEN InvalidAgeEx THEN
		DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Patient Age.');
		DBMS_OUTPUT.PUT_LINE('Enter a valid Age(1-100)');
		DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	WHEN InvalidPhoneEx THEN
		DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Patient Phone Number.');
		DBMS_OUTPUT.PUT_LINE('Enter a valid Phone Number, starts with: 01 or 8801 or +8801');
		DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
	
END;
/
COMMIT;