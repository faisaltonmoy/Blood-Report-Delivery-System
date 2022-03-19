SET SERVEROUTPUT ON;
SET VERIFY OFF;

----------------------       Package      -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE myPackage AS
	PROCEDURE updateSerial(tSerial IN Blood_Report.SlId%TYPE, tHm IN Blood_Report.Haemoglobin%TYPE, tESR IN Blood_Report.ESR%TYPE, tWBC IN Blood_Report.WBC%TYPE, 
	tRBC IN Blood_Report.RBC%TYPE, tPl IN Blood_Report.Platelets%TYPE, tDO IN Blood_Report.Outcome%TYPE);
END myPackage;
/
----------------------     Package Body   -----------------------
--------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY myPackage AS
	PROCEDURE updateSerial(tSerial IN Blood_Report.SlId%TYPE, tHm IN Blood_Report.Haemoglobin%TYPE, tESR IN Blood_Report.ESR%TYPE, tWBC IN Blood_Report.WBC%TYPE, 
	tRBC IN Blood_Report.RBC%TYPE, tPl IN Blood_Report.Platelets%TYPE, tDO IN Blood_Report.Outcome%TYPE);
	IS 
		tempSlId NUMBER;
		
	BEGIN
		SELECT SlId into tempSlId from Blood_Report WHERE SlId = tSerial;  --getting the serial number and storing into tempSlId
		
		IF tempSlId IS NOT NULL THEN
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number Found.');
			DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
			

			UPDATE Blood_Report SET 
				Haemoglobin = tHm,
				ESR = tESR,
				WBC = tWBC,
				RBC = tRBC,
				Platelets = tPl,
				Outcome = tDO
			WHERE SlId = tempSlId;
			
			--updating Report Availability from Report_Delivery table
			UPDATE Report_Delivery@server1 SET 
				AvailabilityStatus = 1
			WHERE SlId = tempSlId;
		
		END IF;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Serial Number you have entered is not found');
			DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
		
	END updateSerial;
END myPackage;
/ 

----------------------          MAIN         -----------------------
--------------------------------------------------------------------
clear screen;
ACCEPT X NUMBER PROMPT "Enter Patient's Serial Number to Update the Report: "
ACCEPT A NUMBER PROMPT "Enter Patient's Haemoglobin (g/dL): "
ACCEPT B NUMBER PROMPT "Enter Patient's ESR (mm 1st hr): "
ACCEPT C NUMBER PROMPT "Enter Patient's White Blood Cells (K/uL): "
ACCEPT D NUMBER PROMPT "Enter Patient's Red Blood Cells (M/uL): "
ACCEPT E NUMBER PROMPT "Enter Patient's Platelets (K/uL): "
ACCEPT F NUMBER PROMPT "Enter Whether the Patient has High Blood Pressure(Yes=1/No=0): "

DECLARE
	inputSerial NUMBER := '&X';
	inputHm 	NUMBER := '&A';
	inputESR 	NUMBER := '&B';
	inputWBC 	NUMBER := '&C';
	inputRBC 	NUMBER := '&D';
	inputPl 	NUMBER := '&E';
	inputDO 	NUMBER := '&F';
	InvalidinputHm EXCEPTION;
	InvalidinputESR EXCEPTION;
	InvalidinputWBC EXCEPTION;
	InvalidinputRBC EXCEPTION;
	InvalidinputPl EXCEPTION;
	InvalidinputDO EXCEPTION;

BEGIN
	IF inputHm < 7.5 OR inputHm > 15.5 THEN
		RAISE InvalidinputHm;
	END IF;
	IF inputESR < 10 OR inputESR > 300 THEN
		RAISE InvalidinputESR;
	END IF;
	IF inputWBC < 2.0 OR inputWBC > 15.0 THEN
		RAISE InvalidinputWBC;
	END IF;
	IF inputRBC < 2.0 OR inputRBC > 15.0 THEN
		RAISE InvalidinputRBC;
	END IF;
	IF inputPl < 40 OR inputPl > 600 THEN
		RAISE InvalidinputPl;
	END IF;
	IF NOT inputDO = 1 THEN
		IF NOT inputDO = 0 THEN
			RAISE InvalidinputDO;
		END IF;
	END IF;

	myPackage.updateSerial(inputSerial,inputHm,inputESR,inputWBC,inputRBC,inputPl,inputDO);
EXCEPTION
	WHEN InvalidinputHm THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Heamoglobin. (Range: 7.5-15.5)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	
	WHEN InvalidinputESR THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid ESR. (Range: 10-300)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	
	WHEN InvalidinputWBC THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid White Blood Cells. (Range: 2.0-15.0)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	
	WHEN InvalidinputRBC THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid White Blood Cells. (Range: 2.0-15.0)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	
	WHEN InvalidinputPl THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Platelets. (Range: 40-600)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
	
	WHEN InvalidinputDO THEN
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Blood outcome choice. (1 for YES; 0 FOR NO)');
		DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
COMMIT;