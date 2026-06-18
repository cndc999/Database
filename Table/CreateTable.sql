CREATE DATABASE device_mgmt CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE device_mgmt;

-- ============================ SCHEMA =================================

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
