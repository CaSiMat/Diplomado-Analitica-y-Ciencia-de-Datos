--CASO PRACTICO SQL--


SELECT * FROM menu_items;

--1 .- Realizar consultas para contestar las siguientes preguntas--
-- a) Encontrar el número de artículos en el menú--
-- R= El menu tiene 32 articulos diferentes--

SELECT count (DISTINCT menu_item_id)
FROM menu_items;


--b)¿Cuál es el artículo menos caro y el más caro en el menú?--
-- R= El articulo menos caro es edamame y el mas caro es shrimp Scampi--

SELECT item_name, price 
FROM menu_items
ORDER BY price ASC
LIMIT 1;


SELECT item_name, price 
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- c) ¿Cuántos platos americanos hay en el menú?--
-- R= Hay 6 platos americanos en el menú--

SELECT *FROM menu_items
WHERE category='American';

SELECT COUNT (menu_items)
FROM menu_items
WHERE category='American';

-- d) ¿Cuál es el precio promedio de los platos?--
-- El precio promedio de los platos es $13.29--

SELECT ROUND (AVG (PRICE),2)
FROM menu_items;

--2.-Explorar la tabla “order_details” para conocer los datos que han sido recolectados.--

SELECT * FROM order_details;

-- a)¿Cuántos pedidos únicos se realizaron en total?--
-- R= Se realizaron 12234 pedidos unicos en total

SELECT COUNT (DISTINCT order_details_id)
FROM order_details;


-- b)¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?--

SELECT order_id, COUNT (item_id)
FROM order_details
GROUP BY order_id
ORDER BY COUNT (item_id) DESC
LIMIT 5;


-- c)¿Cuándo se realizó el primer pedido y el último pedido?
-- El primer pedido se hizo el 2023-01-01 y el ultimo pedido se hizo el 2023-03-31 a las 22:15:48

SELECT * FROM Order_details
ORDER BY order_date ASC, order_time ASC
LIMIT 1;


SELECT * FROM Order_details
ORDER BY order_date DESC, order_time DESC
LIMIT 1;

--d)¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?--
-- Entre el '2023-01-01' y el '2023-01-05' se hicieron 702 ordenes.

SELECT COUNT (order_date)
FROM order_details
WHERE order_date BETWEEN '2023-01-01'AND '2023-01-05';


--3.- Realizar un left join entre entre order_details y menu_items con el identificador--
--item_id(tabla order_details) y menu_item_id(tabla menu_items).---

SELECT * FROM Order_details
LEFT JOIN menu_items ON Order_details.item_id = menu_items.menu_item_id;

-------------------------------------------------------------

CREATE TABLE Menu_Items_and_Order_details_Join AS
SELECT *
FROM Order_details
LEFT JOIN menu_items ON Order_details.item_id = menu_items.menu_item_id;


SELECT * FROM Menu_Items_and_Order_details_Join


SELECT COUNT (DISTINCT category)
FROM Menu_Items_and_Order_details_Join


SELECT category, SUM(price) AS total_ventas
FROM Menu_Items_and_Order_details_Join
WHERE category IS NOT NULL
GROUP BY category
ORDER BY total_ventas DESC;


SELECT order_date, SUM(price) AS total_sales
FROM Menu_Items_and_Order_details_Join
WHERE price IS NOT NULL
GROUP BY order_date
ORDER BY total_sales DESC
LIMIT 5;

SELECT order_id, SUM(price) AS total_ventas
FROM Menu_Items_and_Order_details_Join
WHERE price IS NOT NULL
GROUP BY order_id
ORDER BY total_ventas DESC;

SELECT (item_name),COUNT (item_name) AS total_item
FROM Menu_Items_and_Order_details_Join
WHERE item_name IS NOT NULL
GROUP BY item_name
ORDER BY total_item DESC
LIMIT 3;

SELECT (item_name),COUNT (item_name) AS total_item
FROM Menu_Items_and_Order_details_Join
WHERE item_name IS NOT NULL
GROUP BY item_name
ORDER BY total_item ASC
LIMIT 3;