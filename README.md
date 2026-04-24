# Healthcare Data ETL Pipeline + Cost Analytics System.

A production-style ETL pipeline that processes hospital data, performs validation, and generates cost and operational insights using SQL analytics.

## Problem Statement

Healthcare data is typically scattered across multiple systems such as patient records, appointments, treatments, and billing systems.

In raw form, the data is:

- Inconsistent
- Unvalidated
- Hard to analyze directly
- Prone to duplication and missing relationships

This project simulates a real-world healthcare data system and builds a complete ETL pipeline to clean, validate, store, and analyze hospital data efficiently.

## System Architecture

Raw CSV Files

&darr;

ETL Pipeline

&darr;

Data Validation

&darr;

MySQL Database

&darr;

SQL Analytics

&darr;

Insights \ Reports

## Tech Stack

- Python (ETL + Validation)
- Pandas (Data Processing)
- MySQL (Database)
- SQL (Analytics Queries)
- Logging (Pipeline monitoring)

## Dataset

This project uses a simulated hospital dataset consisting of:

- patients(patient_id) → Primary entity
- doctors(doctor_id)
- appointments(appointment_id, patient_id, doctor_id)
- treatments(treatment_id, appointment_id)
- billing(bill_id, treatment_id)

Each dataset is connected via relational keys forming a complete healthcare workflow.

## ETL Pipeline

### 1. Extract

Raw CSV files are loaded using Pandas.

### 2. Transform

- Missing & duplicate values handeling
- Data type corrections relation to sql
- Business rule validation
- Building pipelines

### 3. Load

Cleaned data is inserted into MySQL database with proper constraints and loggings.

## Data Validation Rules

- Cost must be greater than 0
- Appointment date must be valid
- Every treatment must be linked to a valid appointment
- Every billing record must reference a valid treatment
- No duplicate primary keys allowed

## Key Features

- End-to-end ETL pipeline
- Data validation layer with business rules
- Incremental processing support
- Logging system for pipeline monitoring
- Relational database design with constraints
- SQL-based cost and operational analytics

## How to Run

1. Clone repository
2. Install dependencies:
   pip install pandas mysql-connector-python
3. Run ETL pipeline:
   python etl.py
4. Run SQL queries from /sql folder
