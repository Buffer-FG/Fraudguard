import pandas as pd
from ensemble import predict_user_risk

# Load data with identifiers
df = pd.read_csv("Dataset/Base_with_graph_features.csv")

# Drop unwanted columns but keep identifier + useful ones
df = df.drop(columns=['employment_status', 'housing_status', 'payment_type', 'fraud_bool'], errors='ignore')

required_fields = ['device_os', 'source', 'email', 'phone_number', 'device_id', 'ip_address']
df = df.dropna(subset=required_fields)

if "user_id" not in df.columns:
    df["user_id"] = df.index
#sample_raw = pd.DataFrame([{
#    "income": 15000,
#    "name_email_similarity": 0.12,
#    "prev_address_months_count": 1,
#    "current_address_months_count": 1,
#    "customer_age": 19,
#    "days_since_request": 0,
#    "intended_balcon_amount": 80000,
#    "zip_count_4w": 12,
#    "velocity_6h": 8.5,
#    "velocity_24h": 15.2,
#    "velocity_4w": 50.3,
#    "bank_branch_count_8w": 0,
#    "date_of_birth_distinct_emails_4w": 6,
#    "credit_risk_score": 300,
#    "email_is_free": 1,
#    "phone_home_valid": 0,
#    "phone_mobile_valid": 1,
#    "bank_months_count": 2,
#    "has_other_cards": 0,
#    "proposed_credit_limit": 90000,
#    "foreign_request": 1,
#    "session_length_in_minutes": 3,
#    "keep_alive_session": 0,
#    "device_distinct_emails_8w": 9,
#    "device_fraud_count": 3,
#    "month": 7,
#    "device_os": "other",
#    "source": "INTERNET",
#    "email": "user1467@mailinator.com",
#    "phone_number": "0000000000",
#    "device_id": "device_zz999",
#    "ip_address": "192.168.200.1"
#}])

sample_raw = df.iloc[[45]]
#sample_raw["num_connections"] = 5
#sample_raw["num_shared_identifiers"] = 3
#sample_raw["fraud_neighbors"] = 2
#sample_raw["fraud_ratio_neighbors"] = 0.4
#sample_raw["component_size"] = 12

result = predict_user_risk(sample_raw)

print("Prediction Result:")
for key, value in result.items():
    print(f"{key}: {value}")
