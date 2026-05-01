-- Problem: 3-Topping Pizzas
-- Platform: DataLemur
-- Difficulty: Hard

-- Approach:
-- 1. Generate all unique combinations of 3 toppings using self joins
-- 2. Ensure no repetition and maintain alphabetical order (p1 < p2 < p3)
-- 3. Calculate total cost by summing ingredient costs
-- 4. Concatenate topping names into required format
-- 5. Sort by total_cost DESC, then toppings ASC

SELECT 
    CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
    p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
FROM pizza_toppings p1
JOIN pizza_toppings p2 
    ON p1.topping_name < p2.topping_name
JOIN pizza_toppings p3 
    ON p2.topping_name < p3.topping_name
ORDER BY total_cost DESC, p1.topping_name, p2.topping_name, p3.topping_name;