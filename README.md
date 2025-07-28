#  FraudGuard – AI-Powered Fraud Detection App

FraudGuard is an AI-powered synthetic identity fraud detection app built for the *UCO Bank Hackathon 2025*. It leverages machine learning, graph analysis, and rule-based logic to uncover hidden fraud rings and accurately flag suspicious activity in financial systems. 

The mobile frontend is developed using *Flutter, while the backend uses **FastAPI* and a robust AI/ML stack. FraudGuard combines advanced data science with an intuitive interface to empower fraud analysts in detecting and managing financial fraud with speed and precision.

---

##  Features

###  Fraud Detection Engine
- *Ensemble Model*:
  - Random Forest
  - Isolation Forest
  - Rule-based heuristics
  - Graph-based fraud propagation detection

###  Graph-Based Link Analysis
- Connects users using identifiers like email, phone_number, ip_address, and device_id
- Detects hidden fraud rings and indirect links between suspicious users

###  Explainability
- Returns fraud score, fraud label, and reasons for flagging to build analyst trust

---

##  App Sections

### 1️ *Flagged Customers*
- View list of all flagged users
- Tap for detailed user profiles
- Options to *report* or *unreport* suspected accounts

### 2️ *Dashboard*
- Interactive graphs showing fraud trends for the last 30 days
- Visual analytics of detected anomalies, flagged accounts, and risk scores

### 3️ *ConnectSafe*
- Discover network-based connections between flagged accounts
- Visual graph representations of identity linkages and fraud clusters

---

##  Tech Stack

###  Backend
- *Language*: Python
- *Framework*: FastAPI
- *ML Models*: scikit-learn (Random Forest, Isolation Forest)
- *Graph Analysis*: NetworkX
- *Data Handling*: Pandas, NumPy
- *Serialization*: joblib, pickle

###  Frontend
- *Framework*: Flutter (Dart)
- *Platform*: Android/iOS compatible

---

##  Project Structure
```bash
fraudguard/
 Client ---> Fraudguard_admin (Frontend )
Server (Backend)
```

---

##  Contributors

This project was developed by:

- *Anshika Gupta*
- *Gunn Gupta*
- *Subhoshri Pal*
- *Diya Ghosh*

As part of the *UCO Bank Hackathon 2025*.

---

##  License

This project is licensed under the *MIT License* – see the LICENSE file for details.

---
