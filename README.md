# Nykaa Beauty Products – Customer & Product Insights

This project analyzes real-world beauty product data from Nykaa to understand **brand performance**, **customer behavior**, and **pricing patterns** using **SQL**, **Python**, and **Power BI**.

---

## Objective

To help Nykaa's business and marketing teams answer key questions such as:
- Which brands and products are most loved by customers?
- How does pricing impact product ratings?
- Are verified buyers more satisfied than others?
- Are discounts boosting engagement or hurting margins?
- Is brand loyalty visible in customer behavior?

---

## Project Structure

| File | Description |
|------|-------------|
| `nyka.ipynb` | Python notebook used to clean and split the dataset |
| `products_table.csv` | Cleaned product information |
| `reviews_table.csv` | Cleaned review data |
| `1. Creating Database and Tables.sql` | SQL script to create relational tables |
| `2. Data Exploration And finding Insights.sql` | SQL queries to generate insights |
| `nyka_project.pbix` | Power BI dashboard with visualized insights |

---

## Tools Used

- **SQL (MySQL)** – data querying and analysis
- **Power BI** – dashboard and visual storytelling
- **Python (pandas)** – initial data cleaning and structuring

---

## Key Analysis Areas

### 1. Dataset Overview

- **Total Products**: 295  
- **Total Reviews**: ~60,000  
- **Verified Buyer %**: ~79%  
- **Discounted Products**: ~78%  
- **Average Product Rating**: 4.41 

---

### 2. Business Insights

#### Top Brands by Performance
- **Kay Beauty** – Highest-rated brand (Avg 4.7 stars)
- **Nykaa Cosmetics** – Most reviewed brand (~17,000 reviews)
- **Herbal Essences** – High ratings & heavy discounts (~32.7% avg)

#### Verified Buyer Impact
- Verified buyers gave **slightly higher ratings** than non-verified ones.
- Adds trust and authenticity to review credibility.

#### Price vs Rating
- Mid-range products (₹500–₹999) received the **highest average ratings (4.06)**.
- Premium-priced items didn’t necessarily get better reviews.
  
#### Discount Analysis
- 78% of products had MRP > Selling Price
- Avg discount = **24.67%**
- Top discounting brands: *Herbal Essences*, *Nykaa Naturals*, *Kay Beauty*

#### Brand Loyalty
- Identified customers who reviewed **multiple products from the same brand** — indicating loyalty.
- Example: *Priyanka Prakash* reviewed 19+ products from *Herbal Essences*

---

## Power BI Dashboard Highlights

- KPI cards: Products, Reviews, Avg Rating, Verified %, Discounts
- Bar Charts: Top Brands by Products / Reviews
- Donut/Stacked Charts: Rating Distribution, Verified Buyers
- Price Bands vs Avg Ratings
- Top Discounted Brands
- Monthly Trends for Ratings & Review Counts

---

## Business Value

This project helps Nykaa:
- Optimize its product mix and pricing strategies
- Focus marketing on top-performing and loyal brands
- Promote verified reviews and understand discount ROI
- Improve decision-making with data-backed storytelling

---

## Folder Summary
Nykaa-Beauty-Product-Analysis/
- nyka.ipynb
- products_table.csv
- reviews_table.csv
- '1. Creating Database and Tables.sql'
- '2. Data Exploration And finding Insights.sql'
- nyka_project.pbix
- README.md
