CREATE DATABASE project;
USE project;

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    brand_name VARCHAR(100),
    product_title TEXT,
    mrp FLOAT,
    price FLOAT,
    product_rating FLOAT,
    product_rating_count INT,
    product_tags TEXT
);

-- DROP TABLE products;
SELECT COUNT(*) FROM products; 


CREATE TABLE reviews (
    review_id BIGINT PRIMARY KEY,
    author VARCHAR(255),
    review_date DATETIME,
    review_rating FLOAT,
    is_a_buyer BOOLEAN,
    pro_user BOOLEAN,
    product_id BIGINT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- DROP TABLE reviews; 
SELECT COUNT(*) FROM reviews;









