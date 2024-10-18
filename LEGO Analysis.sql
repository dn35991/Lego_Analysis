/*
Which set uses the most of a specific colour bricks?
*/

-- Determines if the colour exists in the database
SELECT
	name AS "Colour"
FROM
	BrickColours
WHERE 
	name LIKE "%Lavender%";

-- Determines which set has the most of a specific colour	
SELECT
	C.name AS "Colour Name",
	S.name AS "Set Name",
	S.set_num AS "Set Number",
	S.year AS "Set Release Year",
	SUM(IParts.quantity) AS "Number of Bricks"
FROM
	Sets AS S
INNER JOIN
	Inventories AS I
ON
	S.set_num = I.set_num
INNER JOIN
	InventoryParts AS IParts
ON 
	I.id = IParts.inventory_id
INNER JOIN
	BrickColours AS C
ON
	IParts.color_id = C.id
WHERE 
	IParts.color_id =
	(SELECT
		id
	FROM
		BrickColours
	WHERE 
		name = "Lavender")
GROUP BY
	"Set Name"
ORDER BY
	"Number of Bricks" DESC
LIMIT 1;


/*
What are the top 5 themes that have the highest average parts per set?
*/

SELECT
	T.name AS "Theme",
	ROUND(AVG(S.num_parts), 0) AS "Average Number of Parts per Set"
FROM
	Themes AS T
INNER JOIN
	Sets AS S
ON
	T.id = S. theme_id
GROUP BY
	"Theme"
ORDER BY
	"Average Number of Parts per Set" DESC
LIMIT 5;


/*
Which sets have more pieces than the average set?
*/
	
SELECT 
	S.name AS "Set Name",
	S.set_num AS "Set Number",
	T.name AS "Theme Name",
	S.year AS "Release Year",
	S.num_parts AS "Number of Parts"
FROM
	Sets AS S
INNER JOIN
	Themes AS T
ON
	S.theme_id = T.id
WHERE
	S.num_parts &gt; 
	(SELECT
		AVG(num_parts)
	FROM 
		Sets)
ORDER BY
	"Number of Parts" DESC;


/*
What is the oldest set with the most number of red parts?
*/

SELECT	
	S.name AS "Set Name",
	S.year AS "Release Year",
	C.name AS "Colour",
	SUM(IParts.quantity) AS "Number of Parts"
FROM
	Sets AS S
INNER JOIN
	Inventories AS I
ON
	S.set_num = I.set_num
INNER JOIN
	InventoryParts AS IParts
ON
	I.id = IParts.inventory_id
INNER JOIN
	BrickColours AS C
ON
	IParts.color_id = C.id
WHERE 
	C.name = "Red"
GROUP BY
	"Set Name"
ORDER BY
	"Release Year" ASC
LIMIT 1;
