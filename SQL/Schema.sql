
USE HospitalETL ;

Create table Patients(
patient_id varchar(10) primary key,
first_name varchar(100),
last_name varchar(100),
gender varchar(1),
date_of_birth date,
contact_number int,
address varchar(100),
registration_date date,
insurance_provider varchar(100),
insurance_number varchar(20),
email varchar(100)
);

Create table Doctor(
doctor_id varchar(10) primary key,
first_name varchar(50),
last_name varchar(50),
specialization varchar(20),
phone_number int,
years_experience int,
hospital_branch varchar(30),
email varchar(50)
)

Create table Appointments(
appointment_id varchar(10) primary key,
patient_id varchar(10),
doctor_id varchar(10),
appointment_date date,
appointment_time time,
reason_for_visit varchar(20),
status varchar(30)

Foreign key (patient_id) references Patients(patient_id),
Foreign key (doctor_id) references Doctor(doctor_id)
);


Create table Treatments(
treatment_id varchar(10) primary key,
appointment_id varchar(10),
treatment_type varchar(20),
description varchar(50),
cost decimal(10,2),
treatment_date date,

Foreign key (appointment_id) references Appointments(appointment_id)
);


Create table Billing(
bill_id varchar(10) primary key,
treatment_id varchar(10) ,
bill_date date,
amount decimal(10,2),
payment_method varchar(20),
payment_status varchar(10),

Foreign key (treatment_id) references Treatments(treatment_id)
);