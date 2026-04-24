select * from Patients;
select * from Treatments;
select * from Appointments;
select * from Doctor;
select * from Billing;

--AVG cost per treatment
select treatment_type,
AVG(cost) as average_cost
from Treatments 
group by treatment_type 
order by average_cost desc ;

--Total revenue per month
select YEAR(bill_date) as year, 
month(bill_date) as month, 
sum(amount) as tot_amt from Billing 
group by YEAR(bill_date), month(bill_date) ;

--Top revenue-generating treatments
select treatment_type, 
SUM(cost) as tot_cost
from Treatments
group by treatment_type
order by tot_cost desc ;

--Patients handled per doctor
select d.first_name,
count(distinct a.patient_id) as tot_patients
from Appointments
as a left join Doctor as d on a.doctor_id = d.doctor_id 
group by d.first_name 
order by tot_patients desc;

--Appointments per doctor
select d.first_name , 
count(a.appointment_id) as tot_appointments
from Appointments
as a left join Doctor as d on a.doctor_id = d.doctor_id
group by d.first_name
order by tot_appointments desc;

--Appointment cancellation & no-show rate
SELECT 
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*) AS cancellation_rate,
    count(case when status = 'No-show' then 1 end) * 100.0 / count(*) as no_show_rate
FROM Appointments;

--Revenue per doctor
SELECT 
    d.first_name,
    SUM(b.amount) AS revenue_generated
FROM Doctor d
JOIN Appointments a ON d.doctor_id = a.doctor_id
JOIN treatments t ON a.appointment_id = t.appointment_id
JOIN billing b ON t.treatment_id = b.treatment_id
GROUP BY d.first_name
ORDER BY revenue_generated DESC;