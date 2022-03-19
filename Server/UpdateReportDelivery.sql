SET SERVEROUTPUT ON;
SET VERIFY OFF;

----------------------       Package      -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE myPackage AS
	PROCEDURE updateDelivery(tSerial IN Report_Delivery.SlId%TYPE, tDate IN Report_Delivery.DeliveredDate%TYPE, tTime IN Report_Delivery.DeliveredTime%TYPE);
END myPackage;
/
----------------------     Package Body   -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY myPackage AS
	PROCEDURE updateDelivery(tSerial IN Report_Delivery.SlId%TYPE, tDate IN Report_Delivery.DeliveredDate%TYPE, tTime IN Report_Delivery.DeliveredTime%TYPE)
	IS 
		tempSlId NUMBER;
		temp NUMBER;
		NotAvailableEx EXCEPTION;
		
	BEGIN
		SELECT SlId into tempSlId from Report_Delivery WHERE SlId = tSerial; 
		
		IF tempSlId IS NOT NULL THEN
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number Found.');
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
			
			SELECT AvailabilityStatus into temp from Report_Delivery WHERE SlId = tSerial;
			
			IF NOT temp = 1 THEN
				RAISE NotAvailableEx;
			END IF;
			

			UPDATE Report_Delivery SET 
				DeliveredStatus = 1,
				DeliveredDate = tDate,
				DeliveredTime = tTime
			WHERE SlId = tempSlId;
		
		END IF;
	
	EXCEPTION
		WHEN NotAvailableEx THEN
			DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Report is not yet available for this Serial Number.');
			DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number you have entered is not found');
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
		
	END updateDelivery;
END myPackage;
/ 

----------------------          MAIN         -----------------------
clear screen;
ACCEPT X NUMBER PROMPT "Enter Patient's Serial Number to Update the Report Delivery Status: "
ACCEPT A PROMPT "Enter Report Delivery Date (DD-MM-YYYY): "
ACCEPT B PROMPT "Enter Report Delivery Time (hh:mm)[24h format]: "


DECLARE
	inputSerial Report_Delivery.SlId%TYPE := '&X';
	inputDate Report_Delivery.DeliveredDate%TYPE := '&A';
	inputTime Report_Delivery.DeliveredTime%TYPE := '&B';
	InvalidDateEx EXCEPTION;
	InvalidTimeEx EXCEPTION;

BEGIN
	IF NOT regexp_like (inputDate, '(0?[1-9]|[12][0-9]|3[01])[/ -](0?[1-9]|1[12])[/ -](19[0-9]{2}|[2][0-9][0-9]{2})') THEN
		RAISE InvalidDateEx;
	END IF;
	IF NOT regexp_like (inputTime, '^([0-1]?[0-9]|[2][0-3]):([0-5][0-9])$') THEN
		RAISE InvalidTimeEx;
	END IF;

	myPackage.updateDelivery(inputSerial,inputDate,inputTime);

EXCEPTION
	WHEN InvalidDateEx THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Date Format, should follow: (DD/MM/YYYY | D-MM-YYYY | D MM YYYY)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	WHEN InvalidTimeEx THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Time Format, should follow: (hh:mm)[24h format]');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');

END;
/
COMMIT;