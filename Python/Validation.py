import pandas as pd;

def validate_email(patient_df):
    email_pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    
    valid = patient_df[patient_df["email"].str.match(email_pattern, na=False)];
    invalid = patient_df[~patient_df["email"].str.match(email_pattern,na=False)];
    
    invalid.to_csv("../logs/invalid_email.csv",index=False);
    return valid ;

def validate_dates(appointments_df, treatments_df):
    if(appointments_df["appointment_date"].dtype != "datetime64[ns]"):
        appointments_df["appointment_date"] = pd.to_datetime(appointments_df["appointment_date"] , errors="coerce");
    if(treatments_df["treatment_date"].dtype != "datetime64[ns]"):
        treatments_df["treatment_date"] = pd.to_datetime(treatments_df["treatment_date"] , errors="coerce");

    merged = treatments_df.merge(appointments_df[["appointment_id","appointment_date"]], on="appointment_id", how="left");

    valid = merged[merged["treatment_date"] >= merged["appointment_date"]] ;
    invalid = merged[merged["treatment_date"] < merged["appointment_date"]] ;

    invalid.to_csv("../logs/invalid_dates.csv" , index=False);
    return valid.drop(columns=["appointment_date"]) ;

def validate_primary_keys(df, pk_column):
    valid = df[df[pk_column].notna()];
    invalid = df[df[pk_column].isna()];

    invalid.to_csv(f"../logs/missing_{pk_column}.csv",index=False);
    return valid;

def validate_duplicates(df, subset_cols, log_name):
    duplicates = df[df.duplicated(subset=subset_cols, keep=False)]
    duplicates.to_csv(f"../logs/duplicate_{log_name}.csv", index=False)

    clean_df = df.drop_duplicates(subset=subset_cols, keep="first")

    return clean_df;


def validate_cost(df,column_name,log_name):
    valid = df[df[column_name]>0];
    invalid = df[df[column_name]<=0];

    invalid.to_csv(f"../logs/invalid_{log_name}.csv",index=False);
    return valid ;


def validate_appointment_entities(appointment_df,patient_df,doctor_df):
    valid = appointment_df[
        (appointment_df["patient_id"].isin(patient_df["patient_id"])) & (appointment_df["doctor_id"].isin(doctor_df["doctor_id"]))
    ]
    invalid = appointment_df[~appointment_df.index.isin(valid.index)];
    invalid.to_csv("../logs/invalid_appointment_entities.csv",index=False);
    return valid;


def invalid_treatment_entities(df_treatments, df_appointments):
    valid = df_treatments[df_treatments["appointment_id"].isin(df_appointments["appointment_id"])] ;
    invalid = df_treatments[~df_treatments.index.isin(valid.index)] ;
    invalid.to_csv("../logs/invalid_treatment_entities.csv",index=False);
    return valid ;


def invalid_billing_entities(df_billings, df_treatments):
    valid = df_billings[df_billings["treatment_id"].isin(df_treatments["treatment_id"])];
    invalid = df_billings[~df_billings.index.isin(valid.index)];
    invalid.to_csv("../logs/invalid_billing_entities.csv", index=False);
    return valid ;