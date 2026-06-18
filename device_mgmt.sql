CREATE DATABASE device_mgmt CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE device_mgmt;


CREATE TABLE Institute (
    Ins_Code            VARCHAR(10)  PRIMARY KEY,
    Location            VARCHAR(100),
    Institute_Name      VARCHAR(150) NOT NULL,
    Establishment_Year  INT
);

CREATE TABLE Building (
    Building_Code  VARCHAR(10)  PRIMARY KEY,
    Location       VARCHAR(100),
    Name           VARCHAR(100),
    Year_Built     INT
);

CREATE TABLE Vendors_Supplier (
    Vendor_ID     VARCHAR(10)  PRIMARY KEY,
    Contact_Info  VARCHAR(150)
);

CREATE TABLE Department (
    Dep_Name      VARCHAR(100) PRIMARY KEY,
    Location      VARCHAR(100),
    Office_Phone  VARCHAR(20),
    Ins_Code      VARCHAR(10),
    FOREIGN KEY (Ins_Code) REFERENCES Institute(Ins_Code)
);

CREATE TABLE Staff (
    Staff_ID  VARCHAR(20)  PRIMARY KEY,
    Name      VARCHAR(100) NOT NULL,
    DoB       DATE,
    Phone     VARCHAR(20),
    Ins_Code  VARCHAR(10),
    FOREIGN KEY (Ins_Code) REFERENCES Institute(Ins_Code)
);

CREATE TABLE Room (
    Room_ID        VARCHAR(10)  PRIMARY KEY,
    Room_Name      VARCHAR(100),
    Status         VARCHAR(30),
    Building_Code  VARCHAR(10),
    FOREIGN KEY (Building_Code) REFERENCES Building(Building_Code)
);

CREATE TABLE Storage_Room (
    Room_ID         VARCHAR(10) PRIMARY KEY,
    Capacity        INT,
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Classroom (
    Room_ID          VARCHAR(10) PRIMARY KEY,
    Seating_Capacity INT,
    Projector        VARCHAR(3),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Lecturer (
    Lecturer_ID    VARCHAR(20) PRIMARY KEY,
    Specialization VARCHAR(100),
    Degree         VARCHAR(50),
    FOREIGN KEY (Lecturer_ID) REFERENCES Staff(Staff_ID)
);

CREATE TABLE Staff_Office (
    StaffOffice_ID VARCHAR(20) PRIMARY KEY,
    Role           VARCHAR(50),
    Shift          VARCHAR(30),
    Room_ID        VARCHAR(10),
    FOREIGN KEY (StaffOffice_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Room_ID)  REFERENCES Room(Room_ID)
);

CREATE TABLE Device (
    Device_ID  VARCHAR(10) PRIMARY KEY,
    Type       VARCHAR(50),
    Status     VARCHAR(30),
    Room_ID    VARCHAR(10),
    FOREIGN KEY (Room_ID) REFERENCES Room(Room_ID)
);

CREATE TABLE Maintenance_Logs (
    Maint_ID   VARCHAR(10) PRIMARY KEY,
    Device_ID  VARCHAR(10),
    FOREIGN KEY (Device_ID) REFERENCES Device(Device_ID)
);

CREATE TABLE Log (
    Log_ID            VARCHAR(10) PRIMARY KEY,
    Status            VARCHAR(30),
    Fault_Description VARCHAR(200),
    Repair_Cost       DECIMAL(10,2),
    Maint_ID          VARCHAR(10),
    FOREIGN KEY (Maint_ID) REFERENCES Maintenance_Logs(Maint_ID)
);

CREATE TABLE Supply (
    Device_ID       VARCHAR(10),
    Vendor_ID       VARCHAR(10),
    Warranty_Policy VARCHAR(100),
    Quantity        INT,
    PRIMARY KEY (Device_ID, Vendor_ID),
    FOREIGN KEY (Device_ID) REFERENCES Device(Device_ID),
    FOREIGN KEY (Vendor_ID) REFERENCES Vendors_Supplier(Vendor_ID)
);

CREATE TABLE Transactions (
    Transactions_ID VARCHAR(10) PRIMARY KEY,
    Lecturer_ID     VARCHAR(20),
    Status          VARCHAR(30),
    Borrow_Time     DATETIME, 
    Return_Time     DATETIME, 
    FOREIGN KEY (Lecturer_ID) REFERENCES Lecturer(Lecturer_ID)
);

CREATE TABLE Includes (
    Device_ID       VARCHAR(10),
    Transactions_ID VARCHAR(10),
    PRIMARY KEY (Device_ID, Transactions_ID),
    FOREIGN KEY (Device_ID)       REFERENCES Device(Device_ID),
    FOREIGN KEY (Transactions_ID) REFERENCES Transactions(Transactions_ID)
);



-- Institute --
INSERT INTO Institute (Ins_Code, Location, Institute_Name, Establishment_Year) VALUES
('SEEE', 'C7', 'School of Electrical and Electronic Engineering', 1956),
('SOICT', 'B1', 'School of Information and Communications Technology', 1995),
('SME', 'C7', 'School of Mechanical Engineering', 1956),
('SCLS', 'C4', 'School of Chemistry and Life Sciences', 1957),
('SMSE', 'C10', 'School of Materials Science and Engineering', 1956),
('SEM', 'C9', 'School of Economics and Management', 1956),
('FAMI', 'D3', 'Faculty of Applied Mathematics and Informatics', 1956),
('SEP', 'C10', 'Faculty of Engineering Physics', 1956),
('FL', 'C7', 'Faculty of Foreign Languages', 2022),
('FED', 'C7', 'Faculty of Education Science and Technology', 2007),
('GDTC', 'NTD', 'Faculty of Physical Education', 1999),
('BKSC', 'B1', 'Bach Khoa Cyber Security Center', 2015),
('QPAN', 'B7', 'Faculty of National Defense and Security Education ', 1956),
('SIE', 'D7', 'School of International Education', 1992),
('FPT', 'C7', 'Faculty of Political Theory', 2002),
('VJIIST', 'TQB', 'Vietnam – Japan International Institute for Science of Technology ', 2014),
('INAPRO', 'C4', 'Institute for Research and Development of Natural Products ', 2004),
('NAVIS', 'TQB', 'International Collaboration Center for R&D on Satellite Navigation Technology ', 2010),
('IET', 'C9', 'Institute of Energy Technology', 2000),
('CCE', 'D6', 'Center for Continuing Education', 2023);


-- Building --
INSERT INTO Building (Building_Code, Location, Name, Year_Built) VALUES
('C1', 'Dai Co Viet', 'Administration', 1960),
('C2', 'Zone C', 'Main Auditorium', 1964),
('C3', 'Zone C', 'Lecture Hall', 1968),
('C3B', 'Zone C', 'Language Testing Center', 1972),
('C4', 'Zone C', 'School of Biotechnology and Food Technology', 1976),
('C5', 'Zone C', 'Materials Eng. & Textile-Leather-Fashion', 1980),
('C6', 'Zone C', 'School of Transportation Engineering', 1984),
('C7', 'Zone C', 'Electrical-Electronic & Mechanical Engineering', 1988),
('C9', 'Zone C', 'School of Economics', 1992),
('C10', 'Zone C', 'Materials & Environmental Science', 1996),
('C10B', 'Zone C', 'ITIMS Building', 2000),
('D2A', 'Zone D', 'Rubber Science & Technology Center', 2004),
('D3', 'Zone D', 'Lecture Hall', 2008),
('D35', 'Zone D', 'Lecture Hall', 2012),
('D4', 'Zone D', 'School of Foreign Languages', 2016),
('D5', 'Zone D', 'Lecture Hall', 1960),
('D6', 'Zone D', 'Lecture Hall', 1964),
('D7', 'Zone D', 'Lecture Hall', 1968),
('D8', 'Zone D', 'Advanced Classroom & Research Building', 1972),
('D9', 'Zone D', 'Lecture Hall', 1976),
('TQB', 'Central', 'Ta Quang Buu Library', 2006),
('ALU', 'Central', 'BK Alumni', 1976);

-- Vendors_Supplier --
INSERT INTO Vendors_Supplier (Vendor_ID, Contact_Info) VALUES
('V001', 'sales@dell.com / 024-3000-1000'),
('V002', 'sales@hp.com / 024-3001-1001'),
('V003', 'sales@lenovo.com / 024-3002-1002'),
('V004', 'sales@asus.com / 024-3003-1003'),
('V005', 'sales@acer.com / 024-3004-1004'),
('V006', 'sales@viewsonic.com / 024-3005-1005'),
('V007', 'sales@epson.com / 024-3006-1006'),
('V008', 'sales@canon.com / 024-3007-1007'),
('V009', 'sales@logitech.com / 024-3008-1008'),
('V010', 'sales@samsung.com / 024-3009-1009'),
('V011', 'sales@lg.com / 024-3010-1010'),
('V012', 'sales@benq.com / 024-3011-1011'),
('V013', 'sales@microsoft.com / 024-3012-1012'),
('V014', 'sales@cisco.com / 024-3013-1013'),
('V015', 'sales@tp-link.com / 024-3014-1014'),
('V016', 'sales@brother.com / 024-3015-1015'),
('V017', 'sales@xerox.com / 024-3016-1016'),
('V018', 'sales@panasonic.com / 024-3017-1017'),
('V019', 'sales@sony.com / 024-3018-1018'),
('V020', 'sales@philips.com / 024-3019-1019');

-- Department --
INSERT INTO Department (Dep_Name, Location, Office_Phone, Ins_Code) VALUES
('Electrical Engineering', 'C7', '024-6000', 'SEEE'),
('Automation Engineering', 'C7', '024-6001', 'SEEE'),
('Communication Engineering', 'C7', '024-6002', 'SEEE'),
('Electronics', 'C7', '024-6003', 'SEEE'),
('Bach Khoa Cyber Security Center', 'B1', '024-6004', 'SOICT'),
('Computer Engineering', 'B1', '024-6005', 'SOICT'),
('Computer Science', 'B1', '024-6006', 'SOICT'),
('Computer Center', 'B1', '024-6007', 'SOICT'),
('Innovation Center', 'B1', '024-6008', 'SOICT'),
('NAVIS Center', 'Floor 2, D7 Building', '024-6009', 'NAVIS'),
('BK AI', 'B1', '024-6010', 'SOICT'),
('Mechatronics', 'C7', '024-6011', 'SME'),
('M & M Engineering', 'C10', '024-6012', 'SME'),
('Thermal Energy', 'C10', '024-6013', 'SME'),
('Vehicle & Energy Conversion', 'C7', '024-6014', 'SME'),
('Chemistry', 'C4', '024-6015', 'SCLS'),
('Chemical Engineering', 'C4', '024-6016', 'SCLS'),
('Food Engineering', 'C4', '024-6017', 'SCLS'),
('Bio Engineering', 'C4', '024-6018', 'SCLS'),
('Materials Engineering', 'C10', '024-6019', 'SMSE'),
('Applied Chemical Materials', 'C10', '024-6020', 'SMSE'),
('Electronics Materials & Devices', 'C10', '024-6021', 'SMSE');

-- Staff --
INSERT INTO Staff (Staff_ID, Name, DoB, Phone, Ins_Code) VALUES
('002.2012.0061', 'Nguyen Dinh Van', '1985-12-15', '0912004620', 'SEEE'),
('002.2012.0034', 'Do Thi Ngoc Diep', '1985-02-12', '0910131071', 'SEEE'),
('002.2025.0089', 'Bui Hanh Trang', '2003-08-03', '0910262142', 'SEEE'),
('002.004.00025', 'Hoang Phuong Chi', '1980-04-18', '0910393213', 'SEEE'),
('002.004.00529', 'Pham Van Tien', '1979-11-05', '0910524284', 'SEEE'),
('002.2025.0088', 'Nguyen Thu Huong', '2003-06-16', '0910655355', 'SEEE'),
('002.1990.0007', 'Tran Ngoc Khue', '1965-07-07', '0910786426', 'FAMI'),
('002.1995.0008', 'Vu Thi Bich Tuyen', '1970-08-08', '0910917497', 'FAMI'),
('002.2000.0009', 'Vu Ngoc Tuoc', '1975-09-09', '0911048568', 'SEP'),
('002.2005.0010', 'Luong Minh Hanh', '1980-10-10', '0911179639', 'FPT'),
('002.2010.0011', 'Luu Quang Trung', '1985-11-11', '0911310710', 'SEEE'),
('002.2015.0012', 'Vu Xuan Hien', '1990-12-12', '0911441781', 'SEP'),
('002.1990.0013', 'Nguyen Van Duc', '1965-01-13', '0911572852', 'SEEE'),
('002.1995.0014', 'Vu Hai', '1970-02-14', '0911703923', 'SEEE'),
('002.2000.0015', 'Hoang Van Nam', '1975-03-15', '0911834994', 'IET'),
('002.2005.0016', 'Nguyen Thi Mai', '1980-04-16', '0911966065', 'SOICT'),
('002.2010.0017', 'Trinh Ngoc Phuc', '1985-05-17', '0912097136', 'FED'),
('002.2015.0018', 'Do Tuan Anh', '1990-06-18', '0912228207', 'GDTC'),
('002.1990.0019', 'Phan Thanh Binh', '1965-07-19', '0912359278', 'IET'),
('002.1995.0020', 'Luong Trung Quan', '1970-08-20', '0912490349', 'CCE'),
('002.2000.0021', 'Nguyen Van An', '1975-09-21', '0912621420', 'SEEE'),
('002.2005.0022', 'Tran Minh Hung', '1980-10-22', '0912752491', 'SOICT'),
('002.2010.0023', 'Le Thanh Son', '1985-11-23', '0912883562', 'SME'),
('002.2015.0024', 'Pham Anh Binh', '1990-12-24', '0913014633', 'SCLS'),
('002.1990.0025', 'Hoang Gia Khanh', '1965-01-25', '0913145704', 'SMSE'),
('002.1995.0026', 'Vu Phuong Thao', '1970-02-26', '0913276775', 'SEM'),
('002.2000.0027', 'Dang Xuan Cuong', '1975-03-27', '0913407846', 'FAMI'),
('002.2005.0028', 'Bui Thi Long', '1980-04-01', '0913538917', 'SEP'),
('002.2010.0029', 'Do Quang Uyen', '1985-05-02', '0913669988', 'VJIIST'),
('002.2015.0030', 'Ngo Hong Dung', '1990-06-03', '0913801059', 'NAVIS'),
('002.1990.0031', 'Nguyen Hoang Long', '1965-07-04', '0913932130', 'SEEE'),
('002.1995.0032', 'Tran Thi Lan', '1970-08-05', '0914063201', 'SOICT'),
('002.2000.0033', 'Le Van Thanh', '1975-09-06', '0914194272', 'FAMI'),
('002.2005.0034', 'Pham Quoc Bao', '1980-10-07', '0914325343', 'SME'),
('002.2010.0035', 'Hoang Minh Duc', '1985-11-08', '0914456414', 'IET'),
('002.2015.0036', 'Vu Thi Hoa', '1990-12-09', '0914587485', 'SEP'),
('002.1990.0037', 'Dang Van Hung', '1965-01-10', '0914718556', 'CCE'),
('002.1995.0038', 'Bui Thi Thu', '1970-02-11', '0914849627', 'SEM'),
('002.2000.0039', 'Ngo Quang Minh', '1975-03-12', '0914980698', 'FED'),
('002.2005.0040', 'Do Thi Ngan', '1980-04-13', '0915111769', 'NAVIS');


-- Room --
INSERT INTO Room (Room_ID, Room_Name, Status, Building_Code) VALUES
('R001', 'Classroom 300', 'Available', 'C1'),
('R002', 'Classroom 301', 'In Use', 'C2'),
('R003', 'Classroom 302', 'Under Maintenance', 'C3'),
('R004', 'Classroom 303', 'Closed', 'C3B'),
('R005', 'Classroom 304', 'Available', 'C4'),
('R006', 'Classroom 305', 'In Use', 'C5'),
('R007', 'Classroom 306', 'Under Maintenance', 'C6'),
('R008', 'Classroom 307', 'Closed', 'C7'),
('R009', 'Classroom 308', 'Available', 'C9'),
('R010', 'Classroom 309', 'In Use', 'C10'),
('R011', 'Classroom 310', 'Under Maintenance', 'C10B'),
('R012', 'Classroom 311', 'Closed', 'D2A'),
('R013', 'Classroom 312', 'Available', 'D3'),
('R014', 'Classroom 313', 'In Use', 'D35'),
('R015', 'Classroom 314', 'Under Maintenance', 'D4'),
('R016', 'Classroom 315', 'Closed', 'D5'),
('R017', 'Classroom 316', 'Available', 'D6'),
('R018', 'Classroom 317', 'In Use', 'D7'),
('R019', 'Classroom 318', 'Under Maintenance', 'D8'),
('R020', 'Classroom 319', 'Closed', 'D9'),
('R021', 'Storage 100', 'Available', 'TQB'),
('R022', 'Storage 101', 'In Use', 'ALU'),
('R023', 'Storage 102', 'Under Maintenance', 'C1'),
('R024', 'Storage 103', 'Closed', 'C2'),
('R025', 'Storage 104', 'Available', 'C3'),
('R026', 'Storage 105', 'In Use', 'C3B'),
('R027', 'Storage 106', 'Under Maintenance', 'C4'),
('R028', 'Storage 107', 'Closed', 'C5'),
('R029', 'Storage 108', 'Available', 'C6'),
('R030', 'Storage 109', 'In Use', 'C7'),
('R031', 'Storage 110', 'Under Maintenance', 'C9'),
('R032', 'Storage 111', 'Closed', 'C10'),
('R033', 'Storage 112', 'Available', 'C10B'),
('R034', 'Storage 113', 'In Use', 'D2A'),
('R035', 'Storage 114', 'Under Maintenance', 'D3'),
('R036', 'Storage 115', 'Closed', 'D35'),
('R037', 'Storage 116', 'Available', 'D4'),
('R038', 'Storage 117', 'In Use', 'D5'),
('R039', 'Storage 118', 'Under Maintenance', 'D6'),
('R040', 'Storage 119', 'Closed', 'D7');


-- Classroom --
INSERT INTO Classroom (Room_ID, Seating_Capacity, Projector) VALUES
('R001', 40, 'Yes'),
('R002', 45, 'No'),
('R003', 50, 'Yes'),
('R004', 55, 'No'),
('R005', 60, 'Yes'),
('R006', 65, 'No'),
('R007', 70, 'Yes'),
('R008', 75, 'No'),
('R009', 80, 'Yes'),
('R010', 85, 'No'),
('R011', 90, 'Yes'),
('R012', 95, 'No'),
('R013', 100, 'Yes'),
('R014', 105, 'No'),
('R015', 110, 'Yes'),
('R016', 115, 'No'),
('R017', 40, 'Yes'),
('R018', 45, 'No'),
('R019', 50, 'Yes'),
('R020', 55, 'No');

-- Storage_Room --
INSERT INTO Storage_Room (Room_ID, Capacity) VALUES
('R021', 120),
('R022', 80),
('R023', 200),
('R024', 60),
('R025', 150),
('R026', 95),
('R027', 300),
('R028', 75),
('R029', 250),
('R030', 110),
('R031', 180),
('R032', 90),
('R033', 220),
('R034', 130),
('R035', 100),
('R036', 160),
('R037', 85),
('R038', 240),
('R039', 70),
('R040', 140);

-- Lecturer --

INSERT INTO Lecturer (Lecturer_ID, Specialization, Degree) VALUES ('002.2012.0061', 'Computer Networks', 'PhD'),
('002.2012.0034', 'Machine Learning', 'PhD'),
('002.2025.0089', 'Database Systems', 'Bachelor'),
('002.004.00025', 'Embedded Systems', 'Associate Professor'),
 ('002.004.00529', 'Signal Processing', 'Associate Professor'),
('002.2025.0088', 'Software Architecture', 'Bachelor'),
('002.1990.0007', 'Computer Vision', 'Professor'),
('002.1995.0008', 'Control Theory', 'Professor'),
('002.2000.0009', 'Power Electronics', 'Associate Professor'),
('002.2005.0010', 'Cryptography', 'Associate Professor'),
('002.2010.0011', 'Data Mining', 'PhD'),
('002.2015.0012', 'Operating Systems', 'MSc'),
('002.1990.0013', 'Robotics', 'Professor'),
('002.1995.0014', 'Thermodynamics', 'Professor'),
('002.2000.0015', 'Material Physics', 'Associate Professor'),
('002.2005.0016', 'Cloud Computing', 'Associate Professor'),
('002.2010.0017', 'Compiler Design', 'PhD'),
('002.2015.0018', 'Wireless Networks', 'MSc'),
('002.1990.0019', 'Cyber Security', 'Professor'),
('002.1995.0020', 'Numerical Analysis', 'Professor');

-- Staff_Office --
INSERT INTO Staff_Office (StaffOffice_ID, Role, Shift, Room_ID) VALUES
('002.2000.0021', 'Lab Technician', 'Morning', 'R021'), 
('002.2005.0022', 'Office Clerk', 'Afternoon', 'R022'), 
('002.2010.0023', 'Equipment Manager', 'Evening', 'R023'), 
('002.2015.0024', 'Department Secretary', 'Full-day', 'R024'), 
('002.1990.0025', 'IT Support', 'Morning', 'R025'), 
('002.1995.0026', 'Lab Technician', 'Afternoon', 'R026'), 
('002.2000.0027', 'Office Clerk', 'Evening', 'R027'), 
('002.2005.0028', 'Equipment Manager', 'Full-day', 'R028'), 
('002.2010.0029', 'Department Secretary', 'Morning', 'R029'), 
('002.2015.0030', 'IT Support', 'Afternoon', 'R030'), 
('002.1990.0031', 'Lab Technician', 'Evening', 'R031'), 
('002.1995.0032', 'Office Clerk', 'Full-day', 'R032'), 
('002.2000.0033', 'Equipment Manager', 'Morning', 'R033'), 
('002.2005.0034', 'Department Secretary', 'Afternoon', 'R034'), 
('002.2010.0035', 'IT Support', 'Evening', 'R035'), 
('002.2015.0036', 'Lab Technician', 'Full-day', 'R036'), 
('002.1990.0037', 'Office Clerk', 'Morning', 'R037'), 
('002.1995.0038', 'Equipment Manager', 'Afternoon', 'R038'), 
('002.2000.0039', 'Department Secretary', 'Evening', 'R039'), 
('002.2005.0040', 'IT Support', 'Full-day', 'R040');



-- Device --
INSERT INTO Device (Device_ID, Type, Status, Room_ID) VALUES
('D001', 'Projector Remote', 'Working', 'R001'),
('D002', 'Power Strip', 'Faulty', 'R002'),
('D003', 'AC Remote', 'Borrowed', 'R003'),
('D004', 'Microphone', 'Retired', 'R004'),
('D005', 'Power Strip', 'Working', 'R005'),
('D006', 'AC Remote', 'Faulty', 'R006'),
('D007', 'Microphone', 'Borrowed', 'R007'),
('D008', 'Projector Remote', 'Retired', 'R008'),
('D009', 'Power Strip', 'Working', 'R009'),
('D010', 'AC Remote', 'Faulty', 'R010'),
('D011', 'Microphone', 'Borrowed', 'R011'),
('D012', 'Projector Remote', 'Retired', 'R012'),
('D013', 'Power Strip', 'Working', 'R013'),
('D014', 'AC Remote', 'Faulty', 'R014'),
('D015', 'Microphone', 'Borrowed', 'R015'),
('D016', 'Projector Remote', 'Retired', 'R016'),
('D017', 'Power Strip', 'Working', 'R017'),
('D018', 'AC Remote', 'Faulty', 'R018'),
('D019', 'Microphone', 'Borrowed', 'R019'),
('D020', 'Projector Remote', 'Retired', 'R020');

-- Maintenance_Logs (20 records)
INSERT INTO Maintenance_Logs (Maint_ID, Device_ID) VALUES
('M001', 'D001'),
('M002', 'D002'),
('M003', 'D003'),
('M004', 'D004'),
('M005', 'D005'),
('M006', 'D006'),
('M007', 'D007'),
('M008', 'D008'),
('M009', 'D009'),
('M010', 'D010'),
('M011', 'D011'),
('M012', 'D012'),
('M013', 'D013'),
('M014', 'D014'),
('M015', 'D015'),
('M016', 'D016'),
('M017', 'D017'),
('M018', 'D018'),
('M019', 'D019'),
('M020', 'D020');

-- Log --
INSERT INTO Log (Log_ID, Status, Fault_Description, Repair_Cost, Maint_ID) VALUES
('L001', 'Open',        'Buttons not responding',     20.0,  'M001'),
('L002', 'In Progress', 'Burnt socket slot',          57.5,  'M002'),
('L003', 'Resolved',    'Faded LCD screen',           95.0,  'M003'),
('L004', 'Closed',      'Static noise and humming',   132.5, 'M004'),
('L005', 'Open',        'Broken power switch',        170.0, 'M005'),
('L006', 'In Progress', 'No IR signal output',        207.5, 'M006'),
('L007', 'Resolved',    'Broken power button',        245.0, 'M007'),
('L008', 'Closed',      'Broken laser pointer',       282.5, 'M008'),
('L009', 'Open',        'Loose plug connection',      320.0, 'M009'),
('L010', 'In Progress', 'Corroded battery contacts',  357.5, 'M010'),
('L011', 'Resolved',    'Weak wireless signal',       395.0, 'M011'),
('L012', 'Closed',      'Signal transmission error',  432.5, 'M012'),
('L013', 'Open',        'Short circuit on board',     470.0, 'M013'),
('L014', 'In Progress', 'Stuck control keys',         507.5, 'M014'),
('L015', 'Resolved',    'Battery compartment broken', 45.0,  'M015'),
('L016', 'Closed',      'Cracked plastic casing',     82.5,  'M016'),
('L017', 'Open',        'Indicator light broken',     120.0, 'M017'),
('L018', 'In Progress', 'Screen cracked',             157.5, 'M018'),
('L019', 'Resolved',    'Audio distortion',           195.0, 'M019'),
('L020', 'Closed',      'Battery leak damage',        232.5, 'M020');
    
-- Supply --
INSERT INTO Supply (Device_ID, Vendor_ID, Warranty_Policy, Quantity) VALUES
('D001', 'V001', '12 Months', 1),
('D002', 'V002', '24 Months', 4),
('D003', 'V003', '36 Months', 7),
('D004', 'V004', '6 Months', 10),
('D005', 'V005', 'Lifetime', 13),
('D006', 'V006', '12 Months', 16),
('D007', 'V007', '24 Months', 19),
('D008', 'V008', '36 Months', 22),
('D009', 'V009', '6 Months', 25),
('D010', 'V010', 'Lifetime', 28),
('D011', 'V011', '12 Months', 31),
('D012', 'V012', '24 Months', 34),
('D013', 'V013', '36 Months', 37),
('D014', 'V014', '6 Months', 40),
('D015', 'V015', 'Lifetime', 43),
('D016', 'V016', '12 Months', 46),
('D017', 'V017', '24 Months', 49),
('D018', 'V018', '36 Months', 2),
('D019', 'V019', '6 Months', 5),
('D020', 'V020', 'Lifetime', 8);

-- Transactions --
INSERT INTO Transactions (Transactions_ID, Lecturer_ID, Status, Borrow_Time, Return_Time) VALUES
('T001', '002.2012.0061', 'Borrowed', '2025-01-01 07:30:00', '2025-01-01 11:30:00'),
('T002', '002.2012.0034', 'Returned', '2025-02-02 08:00:00', '2025-02-02 11:00:00'),
('T003', '002.2025.0089', 'Overdue', '2025-03-03 13:15:00', '2025-03-03 17:00:00'),
('T004', '002.004.00025', 'Reserved', '2025-04-04 09:00:00', '2025-04-04 12:00:00'),
('T005', '002.004.00529', 'Borrowed', '2025-05-05 14:00:00', '2025-05-05 16:30:00'),
('T006', '002.2025.0088', 'Returned', '2025-06-06 08:30:00', '2025-06-06 10:30:00'),
('T007', '002.1990.0007', 'Overdue', '2025-07-07 07:00:00', '2025-07-07 11:00:00'),
('T008', '002.1995.0008', 'Reserved', '2025-08-08 13:00:00', '2025-08-08 15:00:00'),
('T009', '002.2000.0009', 'Borrowed', '2025-09-09 09:30:00', '2025-09-09 11:45:00'),
('T010', '002.2005.0010', 'Returned', '2025-10-10 15:00:00', '2025-10-10 17:00:00'),
('T011', '002.2010.0011', 'Overdue', '2025-11-11 08:15:00', '2025-11-11 11:15:00'),
('T012', '002.2015.0012', 'Reserved', '2025-12-12 10:00:00', '2025-12-12 12:00:00'),
('T013', '002.1990.0013', 'Borrowed', '2025-01-13 13:30:00', '2025-01-13 15:30:00'),
('T014', '002.1995.0014', 'Returned', '2025-02-14 07:45:00', '2025-02-14 09:45:00'),
('T015', '002.2000.0015', 'Overdue', '2025-03-15 14:15:00', '2025-03-15 16:45:00'),
('T016', '002.2005.0016', 'Reserved', '2025-04-16 08:00:00', '2025-04-16 11:00:00'),
('T017', '002.2010.0017', 'Borrowed', '2025-05-17 09:15:00', '2025-05-17 12:15:00'),
('T018', '002.2015.0018', 'Returned', '2025-06-18 13:00:00', '2025-06-18 16:00:00'),
('T019', '002.1990.0019', 'Overdue', '2025-07-19 08:30:00', '2025-07-19 11:30:00'),
('T020', '002.1995.0020', 'Reserved', '2025-08-20 14:30:00', '2025-08-20 17:00:00');


-- Includes --
INSERT INTO Includes (Device_ID, Transactions_ID) VALUES
('D001', 'T001'),
('D002', 'T002'),
('D003', 'T003'),
('D004', 'T004'),
('D005', 'T005'),
('D006', 'T006'),
('D007', 'T007'),
('D008', 'T008'),
('D009', 'T009'),
('D010', 'T010'),
('D011', 'T011'),
('D012', 'T012'),
('D013', 'T013'),
('D014', 'T014'),
('D015', 'T015'),
('D016', 'T016'),
('D017', 'T017'),
('D018', 'T018'),
('D019', 'T019'),
('D020', 'T020');

