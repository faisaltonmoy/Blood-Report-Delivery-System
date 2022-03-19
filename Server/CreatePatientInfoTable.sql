clear screen;

DROP TABLE Patient_Info CASCADE CONSTRAINTS;

CREATE TABLE Patient_Info(
    SlId NUMBER(6) NOT NULL,
	Name VARCHAR2(25),
    Age NUMBER(3),
    Phone VARCHAR2(15),
    PRIMARY KEY (SlId)
);

--preinputted values
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1000,'Asif',28,'8801569856325');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1001,'Layla',27,'01524789636');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1002,'Salim Khan',35,'01699636523');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1003,'Fairouz',38,'+8801756369856');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1004,'Abid',46,'+8801759863695');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1005,'Tahmid',35,'01589636952');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1006,'Rukaiya',56,'01752523695');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1007,'Mofiz',24,'+8817896369852');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1008,'Abul',25,'008801789985632');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1009,'Kalam Khan',57,'01566635245');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1010,'Dulal',51,'01855542314');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1011,'Helal',47,'01966652351');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1012,'Rana',43,'01455563258');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1013,'Tafsir Hossain',42,'01688665252');
INSERT INTO Patient_Info(SlId,Name,Age,Phone) 
					VALUES (1014,'Rahim',28,'01655636563');

commit;