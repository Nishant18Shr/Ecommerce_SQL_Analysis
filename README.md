# Ecommerce_SQL_Analysis
SQL-based analysis of an e-commerce dataset to uncover insights on customer behavior, product performance, and sales trends.
# 🛒 E-commerce Sales Analysis (SQL Case Study)

## 📌 Overview
This project focuses on analyzing an e-commerce dataset using SQL to extract meaningful insights related to customer behavior, sales trends, and product performance.

## 🎯 Objective
- To analyze customer distribution and engagement  
- To identify high-performing products and categories  
- To evaluate sales trends over time  
- To derive actionable business insights  

## 🛠️ Tools Used
- SQL (MySQL)  
- Database Design  
- Data Analysis using Queries  

## 📂 Dataset Description
The dataset consists of the following tables:
- `customers` → Customer details and locations  
- `orders` → Order transactions and dates  
- `orderdetails` → Product-level order information  
- `products` → Product details and categories  

## 📊 Key Analysis Performed

### 1. Customer Distribution Analysis
- Identified top cities with highest customer base  
- Found that **Delhi, Chennai, Jaipur** have the highest customers  

### 2. Customer Engagement Analysis
- Observed relationship between number of orders and customers  
- Found that **customer count decreases as order frequency increases**  
- Majority customers are **Occasional Shoppers**

### 3. Product Performance Analysis
- Identified products with highest revenue  
- Product with **ID 1 generates highest revenue** (avg qty = 2)  
- **Electronics** category has highest demand  

### 4. Sales Trend Analysis
- Sales showed fluctuations across months  
- Largest decline observed in **February 2024**  
- No consistent growth trend between March–August  

### 5. Order Value Analysis
- Highest increase in average order value observed in **December**  

### 6. Inventory & Demand Analysis
- Product with ID **7 has highest turnover rate**  
- Some products are purchased by less than 40% customers  
- Indicates **low visibility or poor marketing**

### 7. Customer Growth Analysis
- Customer acquisition trend shows **downward growth**  
- Suggests need for better marketing strategies  

### 8. Peak Sales Periods
- Highest sales observed in **September and December**  
- These months require:
  - Increased inventory  
  - Higher staffing  

## 💡 Key Insights
- Customer base is concentrated in a few key cities  
- Most customers are low-frequency buyers  
- Electronics is the most popular category  
- Sales trends are inconsistent, indicating market fluctuations  
- Some products underperform due to low visibility  
- Peak sales periods require operational planning  

## 📂 Files Included
- `EcommerceCaseStudy.sql` → Contains all SQL queries and analysis  

## 🚀 Conclusion
This project demonstrates strong SQL skills including data querying, aggregation, joins, CTEs, and business analysis. It highlights how raw transactional data can be transformed into actionable insights for business decision-making.
