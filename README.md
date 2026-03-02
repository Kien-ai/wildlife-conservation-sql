# 🐘🌿 Wildlife Conservation Database (SQL Project)

## 🌟 Overview
A relational **SQL database** for wildlife conservation in **Central Africa**, tracking animals, rangers, GPS movements, and poaching incidents. Includes **analytical queries** and a **Poaching Risk Score model**.

## 🗄️ Tables
- **protected_areas** – National parks & reserves  
- **animals** – Wildlife species & status  
- **rangers** – Ranger info & patrols  
- **gps_tracking** – Animal location data  
- **poaching_incidents** – Recorded illegal activities  

## 📊 Key Analysis
- Identify high-risk parks by incident count  
- Calculate poaching risk scores  
- Track animal movements via GPS  

## 🌍 Countries Represented
🇨🇲 Cameroon | 🇬🇦 Gabon | 🇨🇬 Republic of the Congo | 🇨🇫 Central African Republic  

🖌️ ER Diagram

Shows relationships between protected areas, animals, rangers, GPS tracking, and poaching incidents.

🛠️ Technologies Used

MySQL: Database creation & queries

SQL: Data analysis & risk scoring

Git & GitHub: Version control & portfolio showcase

Markdown: Project documentation

🚀 How to Run This Project

1️⃣ Clone the repository:

git clone https://github.com/Kien-ai/wildlife-conservation-sql.git

2️⃣ Import the schema:

source schema/create_tables.sql;

3️⃣ Insert sample data:

source data/sample_data.sql;

4️⃣ Run analytical queries:

source analysis/poaching_risk_analysis.sql;

🌱 Future Improvements

Integrate real-time GPS tracking APIs

Build a dashboard with Python or Power BI

Develop ML models for predicting poaching risk

Add geospatial analysis of animal movement

👨‍💻 Author

Kien Florence – Passionate about AI & Data Science for Wildlife Conservation
✨ Let’s protect our wildlife
