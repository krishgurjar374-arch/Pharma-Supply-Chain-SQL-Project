# 📌 PROJECT OVERVIEW

The **Pharma Supply Chain SQL Analytics Project** is a practical data analytics project developed using **Microsoft SQL Server** to analyze pharmaceutical supply chain operations.

The project transforms supply-chain data into meaningful business insights across:

- 💊 Pharmaceutical Products
- 🏭 Production & Manufacturing
- 📦 Inventory Management
- 🤝 Supplier Performance
- 🧪 Quality Control
- 🚚 Orders & Shipments
- 💰 Costs & Revenue
- 👥 Customer Performance
- ⏳ Batch Expiry & Shelf Life

The objective is to demonstrate how SQL can be used to solve **real-world supply chain and business intelligence problems**.

---

# 🎯 PROJECT OBJECTIVES

The project focuses on:

- Analyzing pharmaceutical production
- Monitoring inventory and batch expiry
- Identifying potentially dead stock
- Evaluating supplier performance
- Analyzing material costs
- Identifying high-cost suppliers
- Measuring customer revenue
- Comparing orders and shipments
- Monitoring quality-control compliance
- Calculating product-level QC pass rates
- Ranking customers by revenue
- Calculating plant-wise production trends
- Identifying inventory with high shelf-life consumption

---

# 🧰 TECHNOLOGIES & TOOLS

| Technology | Purpose |
|---|---|
| 🗄️ **Microsoft SQL Server** | Database management & query execution |
| 💻 **SQL Server Management Studio (SSMS)** | SQL development & analysis |
| 📊 **SQL** | Data analysis & business logic |
| 📑 **Microsoft PowerPoint** | Project presentation |

---

# 🗂️ DATABASE ANALYSIS AREAS

The project analyzes multiple stages of the pharmaceutical supply chain.

### 💊 PRODUCT ANALYSIS

Analysis of pharmaceutical products including:

- Product information
- Product categories
- Production quantities
- Product performance
- Product-related costs

### 🏭 PRODUCTION & MANUFACTURING

Analysis of:

- Production batches
- Production quantities
- Manufacturing plants
- Production trends
- Manufacturing activity

### 📦 INVENTORY MANAGEMENT

Analysis of:

- Inventory quantities
- Batch availability
- Unsold inventory
- Dead stock
- Shelf-life consumption
- Expiry risk

### 🤝 SUPPLIER ANALYSIS

Analysis of:

- Supplier contribution
- Material categories
- Supplier diversification
- Average material cost
- High-cost suppliers

### 🧪 QUALITY CONTROL

Analysis of:

- QC records
- Batch quality status
- QC pass rates
- Missing QC records
- Product quality performance

### 🚚 LOGISTICS & ORDERS

Analysis of:

- Sales orders
- Order quantities
- Shipments
- Order-shipment matching
- Logistics activity

### 💰 COST & REVENUE

Analysis of:

- Material costs
- Product revenue
- Customer revenue
- Supplier costs
- Financial performance

---

# 📊 KEY SQL ANALYSIS

## 1️⃣ UPCOMING BATCH EXPIRY ANALYSIS ⏳

Identifies pharmaceutical batches that are scheduled to expire within the next **90 days**.

### Business Purpose

Helps supply-chain teams:

- Monitor expiry risk
- Prioritize inventory
- Reduce product wastage
- Improve stock rotation

---

## 2️⃣ PRODUCTION QUANTITY BY PRODUCT 🏭

Calculates total production quantities for each pharmaceutical product.

Uses aggregation such as:

```sql
SUM(quantity_produced)
```

This helps identify high-volume products and production patterns.

---

## 3️⃣ AVERAGE MATERIAL COST BY SUPPLIER 💰

Analyzes average raw-material costs across:

- Suppliers
- Material categories

This helps identify cost differences and potential procurement opportunities.

---

## 4️⃣ SUPPLIER DIVERSIFICATION ANALYSIS 🤝

Calculates the number of distinct materials supplied by each supplier.

```sql
COUNT(DISTINCT material_name)
```

### Business Purpose

Helps understand:

- Supplier contribution
- Material diversity
- Supplier dependency
- Procurement structure

---

## 5️⃣ CUSTOMER REVENUE ANALYSIS 💵

Calculates customer-level revenue based on:

```text
Quantity Ordered × Unit Price
```

This helps identify high-value customers and revenue contribution.

---

## 6️⃣ DEAD STOCK IDENTIFICATION ⚠️

Identifies production batches that were produced but have **never been sold**.

This can help detect:

- Slow-moving inventory
- Unsold batches
- Potential dead stock
- Inventory carrying risk

---

## 7️⃣ QUALITY CONTROL COMPLIANCE 🧪

Identifies production batches that do not have corresponding quality-control records.

### Business Purpose

This analysis can help identify:

- Missing QC records
- Potential compliance issues
- Data-recording gaps
- Batches requiring further review

---

## 8️⃣ ORDERS VS SHIPMENTS AUDIT 🚚

Uses a **FULL OUTER JOIN** to compare orders with shipment records.

This can identify:

- Orders without shipments
- Shipments without matching orders
- Potential operational inconsistencies

---

## 9️⃣ HIGH-COST SUPPLIER ANALYSIS 💰

Identifies suppliers whose average material cost exceeds:

### ₹10,000

This can support:

- Supplier comparison
- Procurement review
- Cost optimization
- Supplier negotiations

---

## 🔟 PRODUCT QC PASS-RATE ANALYSIS 🧪

Uses **CTEs and CASE expressions** to calculate QC pass rates by product.

Quality categories:

| QC Pass Rate | Classification |
|---:|---|
| ≥ 95% | 🟢 Excellent |
| ≥ 85% | 🟡 Acceptable |
| < 85% | 🔴 Need Review |

This demonstrates practical SQL business logic using:

- CTEs
- CASE
- Aggregations
- Conditional calculations

---

## 1️⃣1️⃣ CUSTOMER REVENUE RANKING 📈

Uses SQL **Window Functions** to rank customers by revenue within their respective state.

Example technique:

```sql
RANK() OVER (
    PARTITION BY state
    ORDER BY revenue DESC
)
```

This enables regional customer-performance comparison.

---

## 1️⃣2️⃣ PLANT PRODUCTION RUNNING TOTAL 🏭

Calculates production trends by plant and month using SQL Window Functions.

This provides:

- Monthly production
- Plant-level production
- Running production totals

---

## 1️⃣3️⃣ SHELF-LIFE RISK ANALYSIS ⏰

Identifies batches that have consumed more than **70% of their shelf life** while inventory is still available.

This helps identify:

- Aging inventory
- Expiry risk
- Inventory prioritization
- Potential wastage

---

# 🧠 SQL CONCEPTS DEMONSTRATED

### Basic SQL

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`

### Aggregate Functions

- `SUM()`
- `AVG()`
- `COUNT()`
- `COUNT(DISTINCT)`
- `MIN()`
- `MAX()`

### Joins

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `FULL OUTER JOIN`

### Advanced SQL

- Common Table Expressions (CTEs)
- `CASE`
- Window Functions
- `RANK()`
- `PARTITION BY`
- Running Totals
- Date Functions
- `DATEDIFF()`
- `DATEADD()`
- `GETDATE()`
- `FORMAT()`
- `DATEFROMPARTS()`

---

# 🔍 BUSINESS QUESTIONS

The project addresses questions such as:

| # | Business Question |
|---:|---|
| 01 | Which pharmaceutical batches will expire soon? |
| 02 | Which production batches have never been sold? |
| 03 | Which batches have missing QC records? |
| 04 | Which products have lower QC pass rates? |
| 05 | Which suppliers provide the largest variety of materials? |
| 06 | Which suppliers have high average material costs? |
| 07 | Which customers generate the highest revenue? |
| 08 | Who are the top customers within each state? |
| 09 | Are orders and shipments properly matched? |
| 10 | Which products have the highest production volume? |
| 11 | What is the running production output by plant? |
| 12 | Which inventory batches have consumed more than 70% of their shelf life? |

---

# 🔄 PROJECT WORKFLOW

```text
                    RAW SUPPLY CHAIN DATA
                              │
                              ▼
                       DATA EXPLORATION
                              │
                              ▼
                         SQL ANALYSIS
                              │
               ┌──────────────┼──────────────┐
               ▼              ▼              ▼
          Production      Inventory      Suppliers
               │              │              │
               └──────────────┼──────────────┘
                              ▼
                       QUALITY CONTROL
                              │
                              ▼
                       SALES & CUSTOMERS
                              │
                              ▼
                      ORDERS & SHIPMENTS
                              │
                              ▼
                       KPI CALCULATIONS
                              │
                              ▼
                       BUSINESS INSIGHTS
```

---

# 📁 PROJECT STRUCTURE

```text
Pharma-Supply-Chain-SQL-Project/
│
├── 📄 README.md
│
├── 🗄️ Pharma_Supply_Chain_SQL_Project.sql
│
└── 📊 PPT/
    └── Pharma_Supply_Chain_Presentation.pptx
```

### 🗄️ SQL FILE

**`Pharma_Supply_Chain_SQL_Project.sql`**

Contains the SQL queries used for:

- Data analysis
- Production analysis
- Inventory analysis
- Supplier analysis
- Revenue analysis
- Quality-control analysis
- Logistics auditing
- Advanced SQL calculations

### 📊 PRESENTATION

The **PPT** folder contains the presentation summarizing the project analysis, methodology, findings, and insights.

---

# 📈 ANALYTICAL AREAS

```text
💊 Product Analytics
🏭 Production Analytics
📦 Inventory Analytics
🤝 Supplier Analytics
🧪 Quality Analytics
🚚 Logistics Analytics
💰 Cost Analytics
💵 Revenue Analytics
👥 Customer Analytics
⏳ Expiry & Shelf-Life Analytics
```

---

# 🚀 FUTURE ENHANCEMENTS

The project can be extended into a complete pharmaceutical supply-chain analytics solution by adding:

### 📊 Power BI

- Interactive supply-chain dashboard
- KPI cards
- Supplier dashboards
- Inventory dashboards
- Production dashboards
- Logistics dashboards

### 🤖 Machine Learning

- Demand forecasting
- Inventory prediction
- Expiry-risk prediction
- Supplier performance prediction
- Product demand forecasting

### ⚡ Automation

- Automated KPI reporting
- Scheduled SQL reports
- Automated expiry alerts
- Inventory risk notifications
- Automated Power BI refresh

---

# 💼 SKILLS DEMONSTRATED

```text
SQL
Microsoft SQL Server
SSMS
Data Analysis
Data Aggregation
Data Cleaning
Joins
CTEs
Window Functions
KPI Analysis
Business Intelligence
Supply Chain Analytics
Inventory Analytics
Supplier Analytics
Quality Analytics
Revenue Analytics
Logistics Analytics
```

---

# 👤 PROJECT AUTHOR

## Krish Gurjar

**Pharma Supply Chain SQL Analytics Project**

🔗 **GitHub Profile:**  
https://github.com/krishgurjar374-arch

---

# ⭐ PROJECT

If you find this project useful or interesting, consider giving the repository a ⭐ on GitHub.

---

## 💊 Turning Pharmaceutical Supply Chain Data into Business Insights with SQL.

**© 2026 Krish Gurjar | Pharma Supply Chain SQL Analytics**
