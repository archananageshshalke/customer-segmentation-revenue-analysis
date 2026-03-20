# Customer Segmentation & Revenue Analysis

## 📌 Project Overview
This project focuses on analyzing customer behavior and revenue patterns using SQL. The objective is to identify high-value customers, analyze sales trends, and generate meaningful business insights.

---

## 🛠 Tools & Technologies
- SQL (SQLite)
- Excel (for dataset preparation)

---

## 📂 Dataset
The dataset consists of the following files:
- Seg_customers.csv
- Seg_orders.csv
- Seg_products.csv
- Seg_order_items.csv

These datasets are connected using common keys such as customer_id, order_id, and product_id.

---

## 📊 Analysis Performed
- Customer order analysis
- Revenue calculation using quantity and price
- Monthly revenue trends
- Top customers based on revenue
- Top products based on revenue
- Customer segmentation (High, Medium, Low value)
- Revenue contribution by customer segments

---

## 💡 Business Insights

### Insight 1
Medium-value customers contribute the highest overall revenue (~1.46M), indicating a strong mid-tier customer base. The business should focus on converting these customers into high-value customers through targeted strategies.

### Insight 2
May 2024 generated the highest monthly revenue (~270K), indicating peak sales performance during this period. Similar strategies can be applied in other months to maintain consistent revenue growth.

### Insight 3
Top-performing products (Product 16, 14, and 6) generate the highest revenue, indicating strong demand. These products should be prioritized for inventory management and marketing strategies.

---

## 📁 Project Structure
- Seg_customers.csv → Customer dataset
- Seg_orders.csv → Orders dataset
- Seg_products.csv → Products dataset
- Seg_order_items.csv → Order items dataset (used for revenue calculation)
- sales_analysis_queries.sql → SQL queries used for analysis

---

## 🚀 Conclusion
This project demonstrates how SQL can be used to analyze business data, uncover insights, and support data-driven decision-making.
