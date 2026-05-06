Day 64 - Histogram of Users and Purchases (DataLemur)

Problem:
Based on their most recent transaction date, retrieve users along with
the number of products they bought.
Output the user's most recent transaction date, user ID, and the number
of products, sorted in chronological order by the transaction date.

Approach:
- Used a subquery to find each user's most recent transaction date
- Filtered records using tuple-based IN clause with (user_id, transaction_date)
- Counted products bought on that most recent date using COUNT(product_id)
- Grouped results by user_id and transaction_date
- Sorted in chronological order using ORDER BY transaction_date ASC

SQL Solution:
select
transaction_date,
user_id,
count(product_id) as purchase_count
from user_transactions
where (user_id, transaction_date) in (
select user_id, max(transaction_date)
from user_transactions
group by user_id
)
group by user_id, transaction_date
order by transaction_date asc;

Key Learning:
Tuple-based filtering with (user_id, transaction_date) IN subquery is cleaner
and more efficient than a JOIN for this type of most-recent-record problem.

Real-world Insight:
This type of analysis is used in:
- E-commerce purchase tracking
- Customer behaviour analysis
- Retail inventory and demand forecasting
Understanding users' most recent activity helps businesses personalise
recommendations and target re-engagement campaigns effectively.