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
  date_of_joning date,
  gender char,
  super_id int,
  FOREIGN KEY (super_id) REFERENCES EMPLOYEE(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE HOURLY_PAID(
  e_id int PRIMARY KEY,
  pay_scale int,
  hours_of_work int,
  date_of_work date,
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
  PRIMARY KEY(p_id,c_id),
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
  PRIMARY KEY(r_id,s_id),
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
  no_on_line int,
  l_no int,
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