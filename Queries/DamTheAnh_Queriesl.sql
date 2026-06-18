USE device_mgmt;

SELECT Staff_ID, Name, Phone, DoB
FROM Staff
WHERE Staff_ID = '002.2012.0061';

SELECT Staff_ID, Name, DoB, Phone
FROM Staff
WHERE DoB > '1985-01-01'
ORDER BY DoB DESC;

SELECT Lecturer_ID, Specialization, Degree
FROM Lecturer
WHERE Degree IN ('Professor', 'Associate Professor', 'PhD')
ORDER BY Degree;

SELECT Lecturer_ID, Specialization, Degree
FROM Lecturer
WHERE Specialization LIKE '%Security%' OR Specialization LIKE '%Cryptography%';

SELECT StaffOffice_ID, Role, Shift, Room_ID
FROM Staff_Office
WHERE Shift = 'Morning';

SELECT Vendor_ID, Contact_Info
FROM Vendors_Supplier
ORDER BY Vendor_ID;


SELECT s.Staff_ID, s.Name, s.DoB, s.Phone, l.Specialization, l.Degree
FROM Lecturer l
JOIN Staff s ON l.Lecturer_ID = s.Staff_ID
ORDER BY s.Name;

SELECT s.Staff_ID, s.Name, s.Phone, so.Role, so.Shift
FROM Staff_Office so
JOIN Staff s ON so.StaffOffice_ID = s.Staff_ID
ORDER BY s.Name;

-- B3. [User Management] Staff together with the institute (school/faculty) they belong to
SELECT s.Staff_ID, s.Name, i.Institute_Name, i.Location
FROM Staff s
JOIN Institute i ON s.Ins_Code = i.Ins_Code
ORDER BY i.Institute_Name;

SELECT so.StaffOffice_ID, s.Name, so.Role, so.Shift, r.Room_Name, b.Name AS Building_Name, b.Location
FROM Staff_Office so
JOIN Staff s ON so.StaffOffice_ID = s.Staff_ID
JOIN Room r ON so.Room_ID = r.Room_ID
JOIN Building b ON r.Building_Code = b.Building_Code
ORDER BY b.Name;

SELECT l.Lecturer_ID, s.Name, s.Phone, t.Transactions_ID, t.Borrow_Time, t.Status
FROM Transactions t
JOIN Lecturer l ON t.Lecturer_ID = l.Lecturer_ID
JOIN Staff s ON l.Lecturer_ID = s.Staff_ID
WHERE t.Status = 'Overdue';

SELECT v.Vendor_ID, v.Contact_Info, d.Device_ID, d.Type, sp.Warranty_Policy, sp.Quantity
FROM Vendors_Supplier v
JOIN Supply sp ON v.Vendor_ID = sp.Vendor_ID
JOIN Device d ON sp.Device_ID = d.Device_ID
ORDER BY v.Vendor_ID;

SELECT s.Name, l.Degree, l.Specialization
FROM Lecturer l
JOIN Staff s ON l.Lecturer_ID = s.Staff_ID
WHERE l.Lecturer_ID IN (
    SELECT Lecturer_ID 
    FROM Transactions 
    WHERE Status = 'Returned'
) 
AND l.Degree IN ('MSc', 'Bachelor');

SELECT d.Device_ID, d.Type, d.Status, d.Room_ID
FROM Device d
WHERE d.Room_ID IN (
    SELECT Room_ID 
    FROM Classroom 
    WHERE Seating_Capacity > 80
);


SELECT Degree, COUNT(*) AS Lecturer_Count
FROM Lecturer
GROUP BY Degree
HAVING COUNT(*) > 1
ORDER BY Lecturer_Count DESC;

SELECT sp.Vendor_ID, v.Contact_Info, SUM(sp.Quantity) AS Total_Quantity_Supplied
FROM Supply sp
JOIN Vendors_Supplier v ON sp.Vendor_ID = v.Vendor_ID
GROUP BY sp.Vendor_ID, v.Contact_Info
HAVING SUM(sp.Quantity) > 20
ORDER BY Total_Quantity_Supplied DESC;