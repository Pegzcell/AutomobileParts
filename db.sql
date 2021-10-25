DROP DATABASE IF EXISTS AUTOMOBILE_PARTS; 

-- Database Schema

CREATE DATABASE AUTOMOBILE_PARTS;                              
USE AUTOMOBILE_PARTS;  

CREATE TABLE EMPLOYEE (
  id int PRIMARY KEY,
  fname varchar(200),
  mname varchar(200),
  lname varchar(200),
  age int,
  line1 varchar(200),
  city varchar(200),
  state varchar(200),
  zip varchar(200),
  role varchar(200),
  date_of_joining date,
  gender char,
  super_id int,
  FOREIGN KEY (super_id) REFERENCES EMPLOYEE(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HOURLY_PAID(
  e_id int,
  date_of_work date,
  pay_scale int,
  hours_of_work int,
  PRIMARY KEY (e_id, date_of_work),
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE(id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE SALARIED(
  e_id int PRIMARY KEY,
  salary int,
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE(id) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE DEPENDENTS (
  e_id int,
  name varchar(200), 
  gender char,
  relationship varchar(200),
  PRIMARY KEY(e_id, name),
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SKILLS(
  e_id int , 
  skill varchar(200),
  PRIMARY KEY(e_id,skill),
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PHNO(
  e_id int ,
  phno varchar(13),
  PRIMARY KEY(e_id,phno),
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRODUCT(
  num int PRIMARY KEY,
  type varchar(200),
  model varchar(200),
  stock int,
  price int
);

CREATE TABLE CLIENT(
  id int PRIMARY KEY,
  name varchar(200),
  email varchar(200),
  phone varchar(13),
  line1 varchar(200),
  city varchar(200),
  state varchar(200),
  zip varchar(200)
);

CREATE TABLE PURCHASE(
  p_id int ,
  c_id int ,
  date_of_purchase date,
  quantity int,
  PRIMARY KEY(p_id,c_id,date_of_purchase),
  FOREIGN KEY (p_id) REFERENCES PRODUCT (num) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (c_id) REFERENCES CLIENT (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE RAW_MATERIAL (
  id int PRIMARY KEY,
  name varchar(200),
  quantity int,
  price int
);

CREATE TABLE SUPPLIER (
  id int PRIMARY KEY,
  name varchar(200),
  email varchar(200),
  phone varchar(13),
  line1 varchar(200),
  city varchar(200),
  state varchar(200),
  zip varchar(200)
);

CREATE TABLE SUPPLY(
  r_id int ,
  s_id int ,
  date_of_purchase date,
  quantity int,
  PRIMARY KEY(r_id,s_id,date_of_purchase),
  FOREIGN KEY (r_id) REFERENCES RAW_MATERIAL (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (s_id) REFERENCES SUPPLIER (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ASSEMBLY_LINE (
  num int PRIMARY KEY,
  parts_no int,
  max_emp int,
  hours_active int
);

CREATE TABLE MACHINE(
  l_no int,
  no_on_line int,
  cost int,
  power_consumed int,
  func varchar(200),
  PRIMARY KEY(l_no,no_on_line),
  FOREIGN KEY (l_no) REFERENCES ASSEMBLY_LINE (num) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRODUCTION(
  p_no int,
  r_id int,
  e_id int, 
  l_no int,
  PRIMARY KEY(p_no,r_id,e_id),
  FOREIGN KEY (p_no) REFERENCES PRODUCT (num) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (r_id) REFERENCES RAW_MATERIAL (id) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (e_id) REFERENCES EMPLOYEE (id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (l_no) REFERENCES ASSEMBLY_LINE (num) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Database State

INSERT INTO EMPLOYEE VALUES
(1,"Mandy", "D", "Collins",41,"682 Clay Lick Road","Englewood", "Alabama",80110,"Manager",'2008-11-11',"F",NULL);
INSERT INTO EMPLOYEE VALUES
(2,"David","N", "Hayden",21,"2589 Marcus Street","Huntsville","Alabama",35801,"Manager",'2008-11-11',"M",NULL);
INSERT INTO EMPLOYEE VALUES
(3,"Henry","P","Vavra",34,"1551 Gateway Road","Portland","Oregon",97214,"Labourer",'2015-09-21',"M",1);
INSERT INTO EMPLOYEE VALUES
(4,"Ghanshyam","Manoj", "GUpta",61,"1056 Elkview Drive","Huntsville","Alabama",87801,"Technician",'2015-05-19',"M",1);
INSERT INTO EMPLOYEE VALUES
(5,"Dabina","N", "Verma",52,"3622 Post Avenue","Rothsay","Minnesota",30801,"Labourer",'2012-04-18',"M",2);
INSERT INTO EMPLOYEE VALUES
(6,"Sheilah","P", "Vavra",29,"1835 Poplar Street","	Cicero","Illinois",13801,"Labourer",'2013-12-17',"M",2);
INSERT INTO EMPLOYEE VALUES
(7,"Ram","Narayan", "Tiwari",26,"Kings Street","Cicero","Illineos",90801,"Labourer",'2020-05-16',"M",1);
INSERT INTO EMPLOYEE VALUES
(8,"Amanda","K","Williams",41,"Queens Avenue","Huntsville","Alabama",56801,"Engineer",'2016-08-15',"F",2);
INSERT INTO EMPLOYEE VALUES
(9,"Shyam","N", "Hayden",31,"1195 Dye Street","Mesa","Arizona",98801,"Technician",'2017-09-14',"M",2);
INSERT INTO EMPLOYEE VALUES
(10,"Emma","K", "Williams",41,"4614 Woodstock Drive","LA","California",36701,"Technician",'2018-11-13',"F",1);


INSERT INTO HOURLY_PAID VALUES
(5,'2020-09-23', 50,5);
INSERT INTO HOURLY_PAID VALUES
(6,'2020-08-23',50,6);
INSERT INTO HOURLY_PAID VALUES
(7,'2020-09-13',50,6);
INSERT INTO HOURLY_PAID VALUES
(9,'2020-09-13',50,7);
INSERT INTO HOURLY_PAID VALUES
(8,'2020-09-23',70,5);


INSERT INTO SALARIED VALUES
(1,50000);
INSERT INTO SALARIED VALUES
(2,30000);
INSERT INTO SALARIED VALUES
(3,40000);
INSERT INTO SALARIED VALUES
(4,50000);
INSERT INTO SALARIED VALUES
(10,20000);


INSERT INTO DEPENDENTS VALUES
(1,"Anny","F","Daughter");
INSERT INTO DEPENDENTS VALUES
(3,"Aron","M","Son");
INSERT INTO DEPENDENTS VALUES
(3,"Raju","M","Spouse");
INSERT INTO DEPENDENTS VALUES
(10,"Ram","M","Spouse");

INSERT INTO SKILLS VALUES
(1,"Typing speed");
INSERT INTO SKILLS VALUES
(4,"Leadership");

INSERT INTO PHNO VALUES
(1,"9872080508");
INSERT INTO PHNO VALUES
(4,"9875038275");
INSERT INTO PHNO VALUES
(4,"9975238275");
INSERT INTO PHNO VALUES
(3,"8976738275");
INSERT INTO PHNO VALUES
(7,"6776738275");
INSERT INTO PHNO VALUES
(10,"8976712345");
INSERT INTO PHNO VALUES
(2,"6786738275");


INSERT INTO PRODUCT VALUES
(1234,"tyre","MF-69",500,200);
INSERT INTO PRODUCT VALUES
(4321,"headlights","MN-500",400,900);
INSERT INTO PRODUCT VALUES
(1267,"breaks","LW-609",400,1000);
INSERT INTO PRODUCT VALUES
(1209,"gears","MF-800",200,100);
INSERT INTO PRODUCT VALUES
(9834,"transmission","MF-09",800,500);
INSERT INTO PRODUCT VALUES
(9600,"car seat","KL-099",100,2500);



INSERT INTO CLIENT VALUES
(2,"Tata motors","tata@gmail.com","9163524619", "86 Bombardier Way","ARDSLEY ON HUDSON","California", 10503);
INSERT INTO CLIENT VALUES
(4,"Bajaj","bajaj@gmail.com","8907524619","861 Parks Way","LA","California", 90105);
INSERT INTO CLIENT VALUES
(6,"Tesla","tesla@gmail.com","9417344619","KIngs Avenue","Cencinie","California", 67803);


INSERT INTO PURCHASE VALUES
(1234,2,'2021-10-24',1000);
INSERT INTO PURCHASE VALUES
(4321,2,'2021-10-20',800);
INSERT INTO PURCHASE VALUES
(1209,4,'2021-10-14',500);
INSERT INTO PURCHASE VALUES
(9834,6,'2021-10-19',100);

INSERT INTO RAW_MATERIAL VALUES
(9870,"Steel",1500,1000);
INSERT INTO RAW_MATERIAL VALUES
(8790,"Rubber",1200,800);
INSERT INTO RAW_MATERIAL VALUES
(1230,"Plastic",500,900);
INSERT INTO RAW_MATERIAL VALUES
(6780,"Leather",1400,500);




INSERT INTO SUPPLIER VALUES
(3,"Ambuja Steels","ambujaaa@gmail.com","9163524619","86 Bombardier Way","ARDSLEY ON HUDSON","California", 10503);
INSERT INTO SUPPLIER VALUES
(9,"Virat Co-operation","viratr@gmail.com","8907524619","861 Parks Way","LA","California", 90105);
INSERT INTO SUPPLIER VALUES
(6,"Jeorge's","axc@gmail.com","9417344619","KIngs Avenue","Cencinie","California", 67803);

INSERT INTO SUPPLY VALUES
(9870,3,'2021-10-24',1000);
INSERT INTO SUPPLY VALUES
(8790,9,'2021-10-20',800);
INSERT INTO SUPPLY VALUES
(1230,6,'2021-10-14',500);
INSERT INTO SUPPLY VALUES
(6780,9,'2021-10-19',100);

INSERT INTO ASSEMBLY_LINE VALUES
(1,9,10,8);
INSERT INTO ASSEMBLY_LINE VALUES
(2,7,20,8);
INSERT INTO ASSEMBLY_LINE VALUES
(3,25,30,8);
INSERT INTO ASSEMBLY_LINE VALUES
(4,15,17,8);

INSERT INTO MACHINE VALUES
(1,1,3456,123,"welding");
INSERT INTO MACHINE VALUES
(2,1,676,123,"joining");
INSERT INTO MACHINE VALUES
(1,2,3546,46,"machining");
INSERT INTO MACHINE VALUES
(2,3,34536,465,"fixing");
INSERT INTO MACHINE VALUES
(1,4,7464600,765,"welding");
INSERT INTO MACHINE VALUES
(1,3,5600,466,"cleaning");
INSERT INTO MACHINE VALUES
(2,2,65000,4666,"welding");