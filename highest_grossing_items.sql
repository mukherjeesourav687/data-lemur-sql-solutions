Day 63 - Highest-Grossing Items (DataLemur)

Problem:
Identify the top two highest-grossing products within each category in the year 2022.
The output should include category, product, and total spend.

Approach:

• Created a CTE (product_totals) to calculate total spend per product
• Filtered data for the year 2022 using EXTRACT(YEAR FROM transaction_date)
• Grouped by category and product
• Used RANK() window function to rank products within each category
• Partitioned by category and ordered by total_spend in descending order
• Filtered top 2 products using rnk <= 2

SQL Solution:

WITH product_totals AS (
    SELECT
        category,
        product,
        SUM(spend) AS total_spend
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
),

ranked_products AS (
    SELECT
        category,
        product,
        total_spend,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_spend DESC
        ) AS rnk
    FROM product_totals
)

SELECT
    category,
    product,
    total_spend
FROM ranked_products
WHERE rnk <= 2;

Key Learning:

Window functions like RANK() help in solving top-N problems efficiently within groups.
Also learned how to structure queries cleanly using multiple CTEs.

Real-world Insight:

This type of analysis is used in:
• E-commerce sales tracking
• Product performance analysis
• Revenue optimisation strategies

Identifying top-performing products helps businesses focus on what drives revenue.