SELECT Log_ID, Status, Fault_Description, Repair_Cost
FROM Log
WHERE Repair_Cost > 200;

SELECT Ins_Code, Institute_Name, Establishment_Year
FROM Institute
WHERE Establishment_Year < 1960;

SELECT Room_ID, Seating_Capacity, Projector
FROM Classroom
WHERE Projector = 'Yes' AND Seating_Capacity >= 60;

INSERT INTO Staff (Staff_ID, Name, DoB, Phone, Ins_Code)
VALUES ('002.2020.0050', 'Tran Van Khoa', '1988-05-20', '0915240000', 'SEEE');
SELECT * FROM Staff WHERE Staff_ID = '002.2020.0050';

select * 
from Log
where repair_cost > 200;

select * 
from Staff
where ins_code = 'SEEE';

select l.repair_cost, d.type
from device d
join Maintenance_Logs m on d.device_id = m.device_id
join log l on m.Maint_ID = l.Maint_ID
where l.repair_cost > 100;

select s.name, s.ins_code, l.degree
from staff s
join lecturer l on s.staff_id = l.lecturer_id
where s.ins_code = 'SEEE';

select d.type, v.contact_info, s.warranty_policy
from device d 
join supply s on d.device_id = s.device_id
join vendors_supplier v on v.vendor_id = s.vendor_id
where d.type like  '% Remote';

select s.name, l.lecturer_id, d.type, t.status
from staff s
join lecturer l on s.staff_id = l.lecturer_id
join transactions t on t.lecturer_id = l.lecturer_id
join includes i on t.transactions_id = i.transactions_id
join device d on d.device_id = i.device_id;

select b.building_code, r.room_name, r.status, c.projector
from building b 
join room r on b.building_code = r.building_code
join classroom c on r.room_id = c.room_id
where r.status = 'Available' and c.projector = 'YES';


select log_id, fault_description, repair_cost
from log
where repair_cost = (select max(repair_cost) from log);

select staff_id, name, ins_code
from staff
where staff_id not in (select lecturer_id from lecturer);

select t.status, COUNT(*)
from lecturer l 
join transactions t on t.lecturer_id = l.lecturer_id
group by t.status;

select ins_code, COUNT(*)
from staff
group by ins_code
having COUNT(*) > 3;

SELECT Degree, COUNT(*) AS Lecturer_Count
FROM Lecturer
GROUP BY Degree
HAVING COUNT(*) > 1
ORDER BY Lecturer_Count DESC;