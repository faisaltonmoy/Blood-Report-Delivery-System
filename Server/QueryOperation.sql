SET SERVEROUTPUT ON;
SET VERIFY OFF;
SET linesize 300;
SET pagesize 200;

ACCEPT X NUMBER PROMPT "Enter your choice: "
ACCEPT Y NUMBER PROMPT "Enter patient's serial number: "

----------------------------------------------------------
CREATE OR REPLACE VIEW PatientInfoTable AS
	select * from Patient_Info;
	
----------------------------------------------------------
CREATE OR REPLACE VIEW ReportDeliveryTable AS
	select * from Report_Delivery;
	
----------------------------------------------------------
CREATE OR REPLACE VIEW ReportTable AS
	SELECT 
		A.SlId, A.AvailabilityStatus,B.Haemoglobin,B.ESR,B.WBC,B.RBC,B.Platelets,B.Outcome
	FROM 
		Report_Delivery A
	INNER JOIN 
		Blood_Report@site1 B ON A.SlId = B.SlId;

----------------------------------------------------------
CREATE OR REPLACE VIEW PendingReportDeliveryTable AS
	SELECT 
		A.SlId, A.Name
	FROM 
		Patient_Info A
	INNER JOIN 
		Report_Delivery B ON A.SlId = B.SlId
	WHERE 
		B.AvailabilityStatus = 1 AND B.DeliveredStatus = 0;


DECLARE
	inputChoice NUMBER := '&X';
	tSerial 	Patient_Info.SlId%TYPE := '&Y';
	
	--1
	tName 		Patient_Info.Name%TYPE;
	tAge 		Patient_Info.Age%TYPE;
	tPhone 		Patient_Info.Phone%TYPE;
	
	--2
	tAV		NUMBER;
	tGC 	NUMBER;
	tBP 	NUMBER;
	tSI 	NUMBER;
	tBMI 	NUMBER;
	tDPF 	NUMBER;
	tDO 	NUMBER;
	
	--3
	tDL		NUMBER;
	tDDT	Report_Delivery.DeliveredDate%TYPE;
	tDTM	Report_Delivery.DeliveredTime%TYPE;
	
	InvalidChoiceEx EXCEPTION;
	ReportNotAvailEx EXCEPTION;
	
BEGIN
	
	IF inputChoice < 1 OR inputChoice > 4 THEN
		RAISE InvalidChoiceEx;
	END IF; 
	

	IF inputChoice = 1 THEN
		select 
			Name , Age, Phone into tName , tAge, tPhone 
		from 
			PatientInfoTable 
		where SlId = tSerial;
		
		DBMS_OUTPUT.PUT_LINE('--------------------');
		DBMS_OUTPUT.PUT_LINE('Patient''s Information:');
		DBMS_OUTPUT.PUT_LINE(CHR(9));
		DBMS_OUTPUT.PUT_LINE('Name:'||CHR(9)||tName);
		DBMS_OUTPUT.PUT_LINE('Age:'||CHR(9)||tAge);
		DBMS_OUTPUT.PUT_LINE('Phone:'||CHR(9)||tPhone);
		DBMS_OUTPUT.PUT_LINE('--------------------');
	END IF; 


	IF inputChoice = 2 THEN
		select 
			AvailabilityStatus,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome into tAV,tGC,tBP,tSI,tBMI,tDPF,tDO
		from 
			ReportTable 
		where SlId = tSerial;
		
		IF tAV=0 THEN
			RAISE ReportNotAvailEx;
		END IF; 
		
		DBMS_OUTPUT.PUT_LINE('--------------------------------');
		DBMS_OUTPUT.PUT_LINE('Patient''s Diabetes Information:');
		DBMS_OUTPUT.PUT_LINE(CHR(9));
		DBMS_OUTPUT.PUT_LINE('Glucose Concentration: '||tGC);
		DBMS_OUTPUT.PUT_LINE('Blood Pressure (mm Hg): '||tBP);
		DBMS_OUTPUT.PUT_LINE('Serum Insulin (mu U/ml): '||tSI);
		DBMS_OUTPUT.PUT_LINE('Body Mass Index(BMI): '||tBMI);
		DBMS_OUTPUT.PUT_LINE('Diabetes Pedigree Function: '||tDPF);
		IF tDO = 0 THEN
			DBMS_OUTPUT.PUT_LINE('Does Patient have Diabetes?: '||'No');
		END IF; 
		IF tDO = 1 THEN
			DBMS_OUTPUT.PUT_LINE('Does Patient have Diabetes?: '||'Yes');
		END IF; 
		DBMS_OUTPUT.PUT_LINE('--------------------------------');
	END IF; 
	

	IF inputChoice = 3 THEN
		select 
			DeliveredStatus,DeliveredDate,DeliveredTime into tDL , tDDT, tDTM 
		from 
			ReportDeliveryTable 
		where SlId = tSerial;
		
		IF tDL = 0 THEN
			DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Report is not delivered to the patient yet');
			DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
		END IF; 
		IF tDL = 1 THEN
			DBMS_OUTPUT.PUT_LINE('--------------------------------------');
			DBMS_OUTPUT.PUT_LINE('The Report is delivered to the patient');
			DBMS_OUTPUT.PUT_LINE('Date: '||tDDT||' at '||tDTM);
			DBMS_OUTPUT.PUT_LINE('--------------------------------------');
		END IF;
	END IF; 
	

	IF inputChoice = 4 THEN
		DBMS_OUTPUT.PUT_LINE('----------------------------------------');
		DBMS_OUTPUT.PUT_LINE('The following Reports are yet to deliver');
		DBMS_OUTPUT.PUT_LINE('----------------------------------------');
		DBMS_OUTPUT.PUT_LINE('Serial Number'||CHR(9)||'Name');
		DBMS_OUTPUT.PUT_LINE('---------------------------------');
		
		FOR R IN (select * from PendingReportDeliveryTable) LOOP
			tSerial := R.SlId;
			tName := R.Name;
		
			DBMS_OUTPUT.PUT_LINE(tSerial||CHR(9)||CHR(9)||tName);
		END LOOP;
	END IF;
	

EXCEPTION
	WHEN InvalidChoiceEx THEN
		DBMS_OUTPUT.PUT_LINE('----------------------------------');
		DBMS_OUTPUT.PUT_LINE('Invalid Choice. Enter choice (1-4)');
		DBMS_OUTPUT.PUT_LINE('----------------------------------');
	WHEN ReportNotAvailEx THEN
		DBMS_OUTPUT.PUT_LINE('---------------------------');
		DBMS_OUTPUT.PUT_LINE('Report is not yet available');
		DBMS_OUTPUT.PUT_LINE('---------------------------');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('-----------------------------');
		DBMS_OUTPUT.PUT_LINE('Serial Number does not exist.');
		DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/

