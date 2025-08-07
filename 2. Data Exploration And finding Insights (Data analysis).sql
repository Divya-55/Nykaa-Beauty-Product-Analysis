USE project;

-- Data Exploration
-- 1.  Total Number of Products & Total Number of Reviews
-- Total products
SELECT COUNT(*) AS total_products FROM products;
-- Total reviews
SELECT COUNT(*) AS total_reviews FROM reviews;

-- 2. Top 10 Brands with Most Products or Top 10 Brands by Number of Products
SELECT brand_name, COUNT(*) AS product_count
FROM products
GROUP BY brand_name
ORDER BY product_count DESC
LIMIT 10;
/*
 Insight #1:
Nykaa’s in-house brands dominate — 
Nykaa Cosmetics and Nykaa Naturals together contribute to 50%+ of the product catalog among top brands. 
This shows strong brand presence and internal push.
*/

-- 3. Top 10 Brands by Total Reviews
SELECT 
    p.brand_name, 
    COUNT(r.review_id) AS total_reviews
FROM reviews r
JOIN products p ON r.product_id = p.product_id
GROUP BY p.brand_name
ORDER BY total_reviews DESC
LIMIT 10;



/*
Insight #2:
Nykaa Cosmetics and Kay Beauty lead the chart — together contributing 30,000+ reviews.

These are Nykaa's in-house brands, suggesting:

Strong marketing push

More visibility on the platform

Possibly better pricing or availability

Other legacy brands like Lakme, Maybelline, and Herbal Essences also 
show strong customer engagement, but with noticeably lower counts.

This confirms a pattern: Nykaa promotes its own brands heavily,
 and they receive the most user attention.
*/

-- 4. Distribution of Review Ratings
SELECT 
    review_rating, 
    COUNT(*) AS review_count
FROM reviews
GROUP BY review_rating
ORDER BY review_rating DESC;


/*
Insight #3:
Almost 68% of all reviews are 5 stars, indicating very high customer satisfaction.

Less than 8% of users gave 1 or 2 stars — showing very few customers are dissatisfied.

This kind of distribution is common for beauty products where brand loyalty and 
subjective satisfaction play a strong role.
*/

-- 5. Verified Buyers vs Non-Verified
SELECT 
    is_a_buyer,
    COUNT(*) AS review_count
FROM reviews
GROUP BY is_a_buyer;

/*
 Insight #4:
Nearly 4 out of 5 reviews come from verified buyers.

This is a positive indicator of data trustworthiness.

Verified reviews are more credible and reflect authentic purchase experiences.
*/

--  6. Are There Products With No Reviews?
SELECT COUNT(*) AS products_without_reviews
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id FROM reviews
);


/*
Insight #5:
Every Product Has at Least One Review
Your data shows that no product is missing reviews.

This implies strong user engagement across the catalog.

No need to filter or drop any products due to lack of data.

🟢 This gives full coverage for product-level insights — all analyses will be statistically meaningful.
*/

-- Deeper Insights (Analytical Queries)
-- 7. Top 10 Products by Average Review Rating (Min 10 Reviews)
SELECT 
    p.product_title,
    ROUND(AVG(r.review_rating), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN products p ON r.product_id = p.product_id
GROUP BY r.product_id
HAVING total_reviews >= 10
ORDER BY avg_rating DESC, total_reviews DESC
LIMIT 10;

/*
Insight #7: Kay Beauty dominates top-rated products
All top 5 products with perfect 5.0 average ratings belong to Kay Beauty, 
each with 780+ reviews, indicating both popularity and high satisfaction.

Notable mentions:

Maybelline and Nykaa products also appear, but with slightly fewer reviews.

All products here have hundreds of reviews, showing that the high ratings are not flukes — 
they reflect consistent quality.

This strongly reinforces Kay Beauty’s reputation for customer-pleasing products and 
suggests high marketing or product quality alignment.
*/

-- 8. Top 5 Brands by Average Rating (Min 50 Reviews)
SELECT 
    p.brand_name,
    ROUND(AVG(r.review_rating), 2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN products p ON r.product_id = p.product_id
GROUP BY p.brand_name
HAVING total_reviews >= 50
ORDER BY avg_rating DESC
LIMIT 5;


/*
 Insight #8: Kay Beauty Leads in Customer Satisfaction
Among brands with at least 50 reviews:

⭐ Kay Beauty tops the list with an impressive 4.7 average rating across 13,635 reviews,
 showing consistently high satisfaction.

Nykaa Cosmetics and Herbal Essences follow with 4.46 and 4.33 average ratings respectively.

Established names like Lakme and Maybelline also maintain strong scores at 4.28 each.

This suggests that Kay Beauty isn’t just popular — it’s also trusted and well-received, 
outperforming even legacy brands in customer experience.
*/

-- 9) Price vs Rating Analysis
-- (Are expensive products getting better reviews?)
SELECT 
    CASE 
        WHEN price < 200 THEN '< ₹200'
        WHEN price BETWEEN 200 AND 499 THEN '₹200–₹499'
        WHEN price BETWEEN 500 AND 999 THEN '₹500–₹999'
        ELSE '₹1000+'
    END AS price_range,
    ROUND(AVG(product_rating), 2) AS avg_rating,
    COUNT(*) AS product_count
FROM products
GROUP BY price_range
ORDER BY FIELD(price_range, '< ₹200', '₹200–₹499', '₹500–₹999', '₹1000+');


/*
Insight #9: Higher-Priced Products Tend to Receive Better Ratings
Products priced between ₹500–₹999 received the highest average rating of 4.06, suggesting this price segment delivers the best value and customer satisfaction.

Lower-priced products (below ₹500) had average ratings below 4.0, indicating slightly lower perceived quality or satisfaction.

Interestingly, ultra-premium products (₹1000+) had a lower average rating of 3.97 than the mid-range — showing that high price doesn’t always guarantee higher satisfaction.

🧠 Takeaway: Mid-range products (₹500–₹999) may offer the sweet spot in terms of value vs. quality perception. Brands could focus their marketing and product strategy on this price band.
*/

-- 10) Do Verified Buyers Give Higher Ratings Than Others? or Average Rating by Verified vs Non-Verified Buyers
SELECT
    is_a_buyer,
    COUNT(*) AS total_reviews,
    ROUND(AVG(review_rating), 2) AS avg_rating
FROM reviews
GROUP BY is_a_buyer;


/*
 Insight 10:
Verified buyers tend to rate products slightly higher than non-verified ones.

This suggests that those who actually purchase the product are generally more satisfied, 
reinforcing the credibility and value of verified reviews.
*/ 

-- 11. Is Brand Loyalty visible? (Same brand repeatedly reviewed?)
--  Goal: Find authors who have reviewed 2 or more products from the same brand.
SELECT 
    r.author,
    p.brand_name,
    COUNT(DISTINCT r.product_id) AS products_reviewed
FROM 
    reviews r
JOIN 
    products p ON r.product_id = p.product_id
GROUP BY 
    r.author, p.brand_name
HAVING 
    COUNT(DISTINCT r.product_id) >= 2
ORDER BY 
    products_reviewed DESC LIMIT 10;
/*
✔️ Yes — for example, Priya Pawar reviewed 33 different Nykaa Naturals products, 
Priyanka Prakash reviewed 19 each from Nykaa Naturals and Herbal Essences, etc.
*/

-- 12. Is there a correlation between MRP & Price? (Discount patterns)

/*
 Insight #12: Is There a Correlation Between MRP & Price?
To determine if brands are offering discounts, we’ll check the relationship between mrp and price fields.

We'll compute:

Number of products where mrp > price (i.e., discounted)

Average discount %

Brands with the highest average discount
*/

-- How many products are discounted?
 SELECT 
    COUNT(*) AS discounted_products
FROM products
WHERE mrp > price;


--  What is the average discount percentage across all products?
SELECT ROUND(AVG((mrp - price) / mrp * 100), 2) AS avg_discount_percent
FROM products
WHERE mrp > price;

-- Top 5 brands with highest average discount (only if discounted products exist)
SELECT 
    brand_name,
    COUNT(*) AS discounted_count,
    ROUND(AVG((mrp - price) / mrp * 100), 2) AS avg_discount_percent
FROM products
WHERE mrp > price
GROUP BY brand_name
ORDER BY avg_discount_percent DESC LIMIT 5;
/*
in doc
*/

