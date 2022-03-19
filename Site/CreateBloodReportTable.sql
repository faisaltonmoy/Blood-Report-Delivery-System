clear screen;

DROP TABLE Blood_Report CASCADE CONSTRAINTS;

CREATE TABLE Blood_Report(
    SlId NUMBER(6) NOT NULL,
	Haemoglobin FLOAT,
    ESR NUMBER(4),
    WBC FLOAT,
    RBC FLOAT,
	Platelets NUMBER(4),
	Outcome NUMBER(2),
    PRIMARY KEY (SlId)
);

--preinputted values
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome) 
					VALUES (1000, 12.3, 86, 6.6, 4.7, 306, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1001, 11.1, 50, 6.2, 4.01, 142, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1002 14.3, 56, 6.6, 5.3, 470, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1003, 10.2, 120, 5.6, 4.5, 167, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1004,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1005, 7.3, 200, 5.7, 4.8, 160, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1006, 10.3, 68, 4.6, 4.6, 310, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1007, 10.9, 75, 7.6, 4.2, 227, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1008,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1009, 11.5, 57, 4.5, 5.6, 280, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1010, 12.7, 139, 5.6, 5.9, 308, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1011, 13.5, 55, 5.6, 5.7, 410, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1012,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1013, 10.9, 49, 5.5, 5.4, 455, 0);
INSERT INTO Blood_Report(SlId,Haemoglobin,ESR,WBC,RBC,Platelets,Outcome)  
					VALUES (1014, 8.6, 239, 5.6, 4.7, 331, 0);

commit;

