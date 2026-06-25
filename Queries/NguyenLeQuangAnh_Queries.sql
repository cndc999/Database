select building_code, name, year_built
from building
where year_built < 1970
order by year_built desc;	

select room_id, capacity
from storage_room
where capacity > 150
order by capacity desc;

select Room_ID, Seating_Capacity, Projector
from Classroom
where Projector = 'Yes' and Seating_Capacity >= 60;

insert into  Staff (Staff_ID, Name, DoB, Phone, Ins_Code)
values ('002.2020.0050', 'Tran Van Khoa', '1988-05-20', '0915240000', 'SEEE');
select * 
from Staff
where Staff_ID = '002.2020.0050';

select * 
from Staff
where ins_code = 'SEEE' and  DoB < '1980-01-01';

select room_id, room_name, building_code
from room
where status = 'Available' and building_code = 'C1';

select l.repair_cost, d.type
from device d
join Maintenance_Logs m on d.device_id = m.device_id
join log l on m.Maint_ID = l.Maint_ID
where l.repair_cost > 100;


select c.room_id, c.seating_capacity, r.room_name, b.name
from classroom c
join room r on c.room_id = r.room_id
join building b on r.building_code = b.building_code
where c.projector = 'Yes';


select d.type, v.contact_info, s.warranty_policy
from device d 
join supply s on d.device_id = s.device_id
join vendors_supplier v on v.vendor_id = s.vendor_id
where d.type like  '% Remote'
and s.warranty_policy = '36 months';


select s.name, l.lecturer_id, d.type, t.status
from staff s
join lecturer l on s.staff_id = l.lecturer_id
join transactions t on t.lecturer_id = l.lecturer_id
join includes i on t.transactions_id = i.transactions_id
join device d on d.device_id = i.device_id
where t.status = 'Overdue';

select d.device_id, d.type, r.room_name, d.status, b.name
from device d
join room r on d.room_id = r.room_id
join building b on r.building_code = b.building_code
where d.status = 'Faulty' 
and d.type = 'AC Remote';

select s.name, s.phone, i.institute_name
from staff s
join institute i on s.ins_code = i.ins_code
where s.ins_code = 'SEEE'
order by s.name asc;


select c.room_id, c.seating_capacity, b.name as building_name
from classroom c
join room r  on c.room_id = r.room_id
join building b on r.building_code = b.building_code
where c.seating_capacity > (select avg(seating_capacity) from classroom);


select d.device_id, d.type, l.repair_cost
from device d
join maintenance_logs m on d.device_id = m.device_id
join log l on m.maint_id = l.maint_id
where l.repair_cost = (select max(repair_cost) from log);

select d.type, sum(l.repair_cost) as total_cost
from device d
join maintenance_logs m on d.device_id = m.device_id
join log l on m.maint_id = l.maint_id
group by d.type
having sum(l.repair_cost) > 300
order by total_cost desc;

select d.type, count(*) as borrow_count
from includes i
join device d on i.device_id = d.device_id
group by d.type
having borrow_count >4;





