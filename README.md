# 🌿 Vegetable Pricing & Replenishment Optimization Model

This project aims to build a **data-driven vegetable pricing and replenishment optimization system**. It leverages **statistical analysis, time series forecasting, and intelligent optimization algorithms** to predict sales and maximize profits for multiple categories of vegetable products sold in supermarkets.

---

## 🎯 Project Background & Objectives

In fresh food retail, vegetables generally have a short shelf life, and their appearance deteriorates over time. Most products cannot be sold the next day if unsold on the day of arrival. Therefore, supermarkets typically replenish vegetables daily based on historical sales and demand patterns.

Given the wide variety of vegetables from different origins and the fact that wholesale transactions occur in the early hours (around 3:00–4:00 AM), supermarkets must make replenishment decisions without precise knowledge of specific products and purchase prices. Pricing is usually based on a **cost-plus pricing** approach, with discounts applied to damaged or unsightly goods.

Reliable market demand analysis is crucial for both replenishment and pricing decisions.  
From the demand side, vegetable sales often exhibit a relationship with time.  
From the supply side, vegetable variety is abundant between April and October, and limited shelf space makes it essential to optimize the sales mix.

Based on three historical sales datasets, this project designs and implements a complete **forecast + optimization** workflow to address the following key problems:

- 🥬 **Problem 1**: Identify and analyze distribution patterns and interrelationships between sales volumes across vegetable categories and individual products.
- 🔮 **Problem 2**: Considering category-level replenishment planning, analyze the relationship between total sales volume and cost-plus pricing for each category, and determine daily replenishment volumes and pricing strategies for the upcoming week (July 1–7, 2023) to maximize supermarket revenue.
- 🧠 **Problem 3**: With limited shelf space, plan individual product replenishment while ensuring the total number of available SKUs is between 27–33, and each product meets a minimum display quantity of 2.5 kg. Based on available products from June 24–30, 2023, provide replenishment quantities and pricing strategies for July 1 that maximize revenue while meeting category-level demand.

---

## 📦 Dataset Description

We use four real-world transactional Excel datasets (“Attachment 1–4”):

| Data Source | Filename      | Key Fields | Scale |
|-------------|--------------|-----------|-------|
| Product Attributes | Attachment1.xlsx | SKU code, product name, category code, category name | 250 SKUs |
| Sales & Pricing | Attachment2.xlsx | Date, sales timestamp, SKU code, sales volume (kg), sales price (CNY/kg), sales type, discount flag | Multi-date × multi-product |
| Wholesale Prices | Attachment3.xlsx | Date, SKU code, wholesale price | Over 1 year of records |
| Loss Rate | Attachment4.xlsx | SKU code, product name, loss rate | 250 SKUs |

All datasets are merged on the primary key `(SKU code + date)` to form a complete transaction table with price, sales, and category attributes, stored locally as `merged_final`.

---

## 🧾 Sample Data Format

The merged `merged_final` table integrates product attributes, sales records, wholesale prices, and loss rates, providing a comprehensive dataset for analysis and modeling.

Example (for product “泡泡椒（精品）” / Premium Chili Pepper):

| Date       | Sales Time     | SKU Code         | Volume (kg) | Price (CNY/kg) | Type   | Discount | Product Name  | Category | Wholesale Price (CNY/kg) | Revenue (CNY) |
|------------|---------------|-----------------|-------------|----------------|--------|----------|---------------|----------|--------------------------|---------------|
| 2020-07-01 | 09:15:07.924  | 102900005117056  | 0.396       | 7.6            | Sales  | No       | Premium Chili | Chili    | 4.32                     | 3.0096        |
| 2020-07-01 | 09:17:33.905  | 102900005117056  | 0.409       | 7.6            | Sales  | No       | Premium Chili | Chili    | 4.32                     | 3.1084        |
| ...        | ...           | ...              | ...         | ...            | ...    | ...      | ...           | ...      | ...                      | ...           |

> Note: Revenue = Volume × Price (CNY).

---

## 🧰 Environment Setup

- Python >= 3.10
- Recommended: Conda or venv for environment management
- Dependencies listed in `requirements.txt`, including:
  - `pandas`, `numpy`, `matplotlib`, `seaborn`
  - `scikit-learn`, `statsmodels`, `prophet`
  - `cvxpy`, `deap` (for optimization tasks)

---

## 📈 Data Processing & Modeling

### 🧹 Data Cleaning & Preprocessing
- Sales normalization, forward-fill for missing values, outlier removal
- Category hierarchy mapping to individual SKUs
- Sliding window construction for time series features

### 🔍 Exploratory Data Analysis
- Pearson correlation heatmaps for price vs. sales
- Top-N category & product sales trends
- Stacked bar plots for inter-category sales comparisons

### ⏳ Time Series Forecasting
- **ARIMA**: Short-term sales forecasting
- **Prophet**: Long-term trends with holiday and weekly effects

### 🧮 Optimization Modeling

| Goal | Method |
|------|--------|
| Category-level pricing | Simulated Annealing for markup rates |
| Product selection | Genetic Algorithm for profit share optimization |
| Fine-grained replenishment | Mixed Integer Quadratic Programming (MIQP) |
| Cost-profit constraints | Expressed using `cvxpy` |

---

## 📊 Key Results

### 🔮 Prophet Forecast Example
<img src="figures/prophet_forecast_example.png" width="600"/>

- Blue line: actual sales  
- Black line: model forecast  
- Clear holiday spikes and weekly cycles observed.

### 🧠 Sample Optimization Output

| Product   | Cost Price | Suggested Price | Predicted Sales | Profit Contribution |
|-----------|-----------|-----------------|-----------------|---------------------|
| Broccoli  | 4.2 CNY   | 6.8 CNY         | 98 kg           | 254.8 CNY           |
| Carrot    | 2.3 CNY   | 3.6 CNY         | 120 kg          | 156 CNY             |

> Simulated annealing optimizes markup combined with demand forecasts for maximum profit.

---

## 🗂️ Project Structure

| Directory / File    | Description |
|---------------------|-------------|
| `notebooks/`        | Jupyter Notebooks for analysis & modeling |
| `src/`              | Core function modules (modeling, optimization) |
| `data/`             | Raw and preprocessed datasets |
| `figures/`          | Auto-generated visualizations |
| `reports/`          | Model reports and deliverables |
| `requirements.txt`  | Python dependencies |

---

## 🧱 Module Overview

| Module File         | Function | Key Techniques |
|---------------------|----------|----------------|
| `data_cleaning.py`  | Data cleaning & merging | Missing value imputation, outlier removal |
| `eda_analysis.py`   | Exploratory analysis    | Heatmaps, stacked bar charts |
| `arima_model.py`    | ARIMA forecasting       | statsmodels |
| `prophet_model.py`  | Demand forecasting      | fbprophet |
| `optimizer.py`      | Pricing optimization    | Simulated Annealing, Genetic Algorithm |
| `pricing_miqp.py`   | Replenishment planning  | MIQP |
| `plotting.py`       | Visualization utilities | matplotlib / seaborn |

---

## 🧬 Advantages & Innovations
- ✅ **Multi-source data fusion**: Integrates price, sales, and category info into a unified modeling pipeline.
- ✅ **Interpretable forecasts**: ARIMA + Prophet combination improves robustness.
- ✅ **Modular optimization output**: Category & SKU-level strategies for flexible application.
- ✅ **Rich visualization support**: End-to-end visual insights from trends to optimization.
- ✅ **Portable & scalable**: Clear structure for easy deployment and future iteration.

---

## 🔭 Future Work
- Integrate real-time sales streams for dynamic forecasting and replenishment.
- Incorporate weather and holiday data to improve prediction accuracy.
- Add inventory and loss constraints for higher practicality.
- Develop an interactive dashboard for operational deployment.

---

## 📜 License
This project is licensed under the MIT License. Academic exchange and non-commercial use are welcome.
