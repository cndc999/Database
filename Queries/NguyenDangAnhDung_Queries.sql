-- 6 QUERIES FROM 1 RELATION --

select * from device
where Status = 'Faulty';

select * from building
where Year_Built > 2000;

select * from classroom
where Seating_Capacity < 50;

select count(Ins_Code) from institute
where Location = 'C7';

select * from lecturer
where degree = 'PhD';

select * from log
where repair_cost > 200;

-- 6 QUERIES FROM MULTIPLE RELATIONS USING JOIN --

SELECT d.Device_ID, d.Type, d.Status, r.Room_Name 
FROM Device d 
JOIN Room r ON d.Room_ID = r.Room_ID;

SELECT t.Transactions_ID, t.Status, t.Borrow_Time, l.Lecturer_ID, l.Specialization 
FROM Transactions t 
JOIN Lecturer l ON t.Lecturer_ID = l.Lecturer_ID;

SELECT ml.Device_ID, l.Log_ID, l.Fault_Description, l.Status 
FROM Log l 
JOIN Maintenance_Logs ml ON l.Maint_ID = ml.Maint_ID;

SELECT s.Device_ID, v.Vendor_ID, v.Contact_Info, s.Warranty_Policy 
FROM Supply s 
JOIN Vendors_Supplier v ON s.Vendor_ID = v.Vendor_ID;

SELECT r.Room_ID, r.Room_Name, b.Name AS Building_Name, b.Location 
FROM Room r 
JOIN Building b ON r.Building_Code = b.Building_Code;

SELECT s.Staff_ID, s.Name, s.Phone, i.Institute_Name 
FROM Staff s 
JOIN Institute i ON s.Ins_Code = i.Ins_Code;




2 QUERIES WITH NESTED QUERIES 

SELECT * FROM Log 
WHERE Repair_Cost >= ALL (
    SELECT Repair_Cost 
    FROM Log
);
 
SELECT * FROM Classroom 
WHERE Seating_Capacity > (
    SELECT AVG(Seating_Capacity) 
    FROM Classroom
);

-- 2 QUERIES WITH GROUP BY ... HAVING ... AND AGGREGATE FUNCTION --

SELECT Type, COUNT(*) AS Total_Quantity
FROM Device 
GROUP BY Type 
HAVING COUNT(*) >= 3;

SELECT Status, SUM(Repair_Cost) AS Total_Budget_Spent
FROM Log 
GROUP BY Status 
HAVING SUM(Repair_Cost) > 500.0;

