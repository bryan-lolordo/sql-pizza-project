SELECT 
	o.order_id,
	i.item_price,
	o.quantity,
	i.item_cat,
	i.item_name,
	o.created_at,
	ad.delivery_address1,
	ad.delivery_address2,
	ad.delivery_city,
	ad.delivery_zipcode,
	o.delivery
FROM 
	orders AS o
LEFT JOIN item AS i ON o.item_id = i.item_id
LEFT JOIN address AS ad ON o.add_id = ad.add_id;


SELECT 
	s1.item_name,
	s1.ing_id,
	s1.ing_name,
	s1.ing_weight,
	s1.ing_price,
	s1.order_quantity,
	s1.recipe_quantity,
	s1.order_quantity*s1.recipe_quantity AS ordered_weight,
	s1.ing_price/s1.ing_weight AS unit_cost,
	(s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) AS ingredient_cost
FROM 
(SELECT
	o.item_id,
	i.sku,
	i.item_name,
	r.ing_id,
	ing.ing_name,
	r.quantity AS recipe_quantity,
	sum(o.quantity) AS order_quantity,
	ing.ing_weight,
	ing.ing_price
FROM orders AS o
	LEFT JOIN item AS i ON o.item_id = i.item_id
	LEFT JOIN recipe AS r ON i.sku = r.recipe_id
	LEFT JOIN ingredient AS ing ON ing.ing_id = r.ing_id
GROUP BY 
	o.item_id, 
	i.sku, 
	i.item_name,
	r.ing_id,
	r.quantity,
	ing.ing_name,
	ing.ing_weight,
	ing.ing_price) AS s1
	
