6 QUERIES FROM 1 RELATION

-- 1
select * from Building 
where Year_Built between 1970 and 2000 
  and Location = 'Zone C';
-- 2
select Device_ID, Type, Status, Room_ID 
from Device 
where Status in ('Faulty', 'Retired') 
  and Room_ID between 'R001' and 'R010';
-- 3
select * from Institute 
where Establishment_Year < 1960 
  and Institute_Name like '%Engineering%';
-- 4
select Vendor_ID, Contact_Info 
from Vendors_Supplier 
where Contact_Info like '%024-3001%' 
   or Contact_Info like '%024-3002%';
-- 5
select Staff_ID, Name, DoB, Phone 
from Staff 
where DoB >= '1980-01-01' and DoB <= '1989-12-31';
-- 6
select Transactions_ID, Lecturer_ID, Status, Borrow_Time 
from Transactions 
where Status in ('Overdue', 'Borrowed') 
  and Borrow_Time between '2025-01-01 00:00:00' and '2025-06-30 23:59:59';


6 QUERIES FROM MULTIPLE RELATIONS USING JOIN 

-- 7 
select d.Device_ID, d.Type, d.Status, r.Room_Name, b.Name as Building_Name
from Device d
join Room r on d.Room_ID = r.Room_ID
join Building b on r.Building_Code = b.Building_Code;

-- 8 
select l.Lecturer_ID, s.Name, l.Degree, l.Specialization, i.Institute_Name
from Lecturer l
join Staff s on l.Lecturer_ID = s.Staff_ID
join Institute i on s.Ins_Code = i.Ins_Code;

-- 9 
select d.Device_ID, d.Type, l.Fault_Description, l.Repair_Cost, l.Status as log_status
from Log l
join Maintenance_Logs m on l.Maint_ID = m.Maint_ID
join Device d on m.Device_ID = d.Device_ID
where l.Status = 'In Progress';

-- 10 
select s.Name as Staff_Name, so.Role, r.Room_Name, b.Name as Building_Name
from Staff_Office so
join Staff s on so.StaffOffice_ID = s.Staff_ID
join Room r on so.Room_ID = r.Room_ID
join Building b on r.Building_Code = b.Building_Code;

-- 11 
select s.Name as Lecturer_Name, d.Type as Device_Type, t.Status as Transaction_Status, t.Borrow_Time, r.Room_Name
from Transactions t
join Lecturer l on t.Lecturer_ID = l.Lecturer_ID
join Staff s on l.Lecturer_ID = s.Staff_ID
join Includes i on t.Transactions_ID = i.Transactions_ID
join Device d on i.Device_ID = d.Device_ID
join Room r on d.Room_ID = r.Room_ID;

-- 12 
select d.Device_ID, d.Type, v.Contact_Info, sp.Warranty_Policy, sp.Quantity, r.Room_Name
from Supply sp
join Vendors_Supplier v on sp.Vendor_ID = v.Vendor_ID
join Device d on sp.Device_ID = d.Device_ID
join Room r on d.Room_ID = r.Room_ID;






2 QUERIES WITH NESTED QUERIES 

-- 13
select Device_ID, Type, Status 
from Device 
where Device_ID not in (
    select distinct i.Device_ID 
    from Includes i
    join Transactions t on i.Transactions_ID = t.Transactions_ID
    where t.Status = 'Overdue');

-- 14
select d.Device_ID, d.Type, r.Room_Name, l.Fault_Description, l.Repair_Cost
from Device d
join Room r on d.Room_ID = r.Room_ID
join Maintenance_Logs m on d.Device_ID = m.Device_ID
join Log l on m.Maint_ID = l.Maint_ID
where l.Repair_Cost > (
    select avg(Repair_Cost) 
    from Log);



2 QUERIES WITH GROUP BY ... HAVING ... AND AGGREGATE FUNCTION 

-- 15
select c.Room_ID, sum(l.Repair_Cost) as Total_Room_Repair_Cost
from Classroom c
join Device d on c.Room_ID = d.Room_ID
join Maintenance_Logs m on d.Device_ID = m.Device_ID
join Log l on m.Maint_ID = l.Maint_ID
group by c.Room_ID
having sum(l.Repair_Cost) > 100.00
order by Total_Room_Repair_Cost desc;

-- 16
select v.Vendor_ID, v.Contact_Info, count(d.Device_ID) as Current_Faulty_Count
from Vendors_Supplier v
join Supply sp on v.Vendor_ID = sp.Vendor_ID
join Device d on sp.Device_ID = d.Device_ID
where d.Status = 'Faulty'
group by v.Vendor_ID, v.Contact_Info
having count(d.Device_ID) >= 1
order by Current_Faulty_Count desc;

