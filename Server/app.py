from flask import Flask, request, jsonify
import pandas as pd
from ensemble import predict_user_risk
from fake_profile import generate_fake_profile
from graph_feature import load_graph, get_connected_users

app = Flask(__name__)


G = load_graph("models/user_graph.gpickle")

try:
    df = pd.read_csv("Dataset/Base_with_graph_features.csv")
    df = df.drop(columns=["fraud_bool"], errors="ignore")
    df = df.dropna(subset=["device_os", "source", "email", "phone_number", "device_id", "ip_address"])
except Exception as e:
    print("Error loading dataset:", e)
    df = pd.DataFrame() 

@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()

        if not data or "data" not in data:
            return jsonify({"error": "Missing 'data' field"}), 400

        email = data["data"].get("email")
        if not email:
            return jsonify({"error": "Missing 'email' field in data"}), 400

      
        user_row = df[df["email"] == email]

        if user_row.empty:
            return jsonify({"error": f"No data found for email: {email}"}), 404

     
        user_df = user_row.iloc[[0]]  

        result = predict_user_risk(user_df)

        if not isinstance(result, dict):
            return jsonify({"error": "Model did not return a dictionary"}), 500

        return jsonify(result)

    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/users', methods=['GET'])
def get_summary():
    try:
        top_risky = df.sample(min(len(df), 100)).copy()
        top_risky["score"] = top_risky.apply(lambda x: predict_user_risk(pd.DataFrame([x]))["ensemble_score"], axis=1)
        top5 = top_risky.sort_values("score", ascending=False).head(5)
        preview = top5[["email", "score"]].reset_index(drop=True).to_dict(orient="records")
        return jsonify({"total_users": len(df), "top_risky_users": preview})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/user_profile/<user_id>', methods=['GET'])
def get_user_profile(user_id):
    try:
        return jsonify(generate_fake_profile(user_id))
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/fraud_cluster/<user_id>', methods=['GET'])
def fraud_cluster(user_id):
    try:
        connected = get_connected_users(user_id, G)
        return jsonify({"connected_users": connected})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
