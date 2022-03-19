clear screen;

DROP TABLE Report_Delivery CASCADE CONSTRAINTS;

CREATE TABLE Report_Delivery(
    SlId NUMBER(6) NOT NULL,
    AvailabilityStatus NUMBER(2),
    DeliveredStatus NUMBER(2),
	DeliveredDate VARCHAR2(15),
    DeliveredTime VARCHAR2(15),
    PRIMARY KEY (SlId)
);


INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1000,1,1,'06-08-2021','12:23');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1001,1,1,'06-08-2021','13:52');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1002,1,1,'07-08-2021','10:11');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1003,1,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1004,0,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1005,1,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1006,1,1,'07-08-2021','15:35');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1007,1,1,'08-08-2021','10:01');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1008,0,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1009,1,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1010,1,1,'08-08-2021','10:52');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1011,1,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1012,0,0,NULL,NULL);
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1013,1,1,'08-08-2021','12:38');
INSERT INTO Report_Delivery(SlId,AvailabilityStatus,DeliveredStatus,DeliveredDate,DeliveredTime) 
					VALUES (1014,1,0,NULL,NULL);
					
commit;

