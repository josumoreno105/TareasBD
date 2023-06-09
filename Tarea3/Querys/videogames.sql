--Mostrar la lista de juegos con el genero

SELECT game.game_name, genre.genre_name
FROM dbo.game
JOIN dbo.genre ON game.genre_id = genre.id;

--Mostrar la lista de juegos que tiene cada Plataforma
SELECT game.game_name, platform.platform_name
FROM dbo.game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.id = game_platform.game_publisher_id
JOIN dbo.platform ON game_platform.platform_id = platform.id;

--Mostrar los juegos lanzados antes del año 2000
SELECT game.game_name, game_platform.release_year
FROM dbo.game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
WHERE game_platform.release_year < 2000;

--Mostrar los juegos mas vendidos en Europa
SELECT TOP(15) game.game_name, SUM(region_sales.num_sales) AS Total_Sales FROM game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
JOIN dbo.region_sales ON dbo.game_platform.id = dbo.region_sales.game_platform_id
GROUP BY game.game_name, game.id
ORDER BY Total_Sales DESC;

--Mostrar los juegos con ventas menores al 0.5 de la plataforma Wii durante la decada del 2000
SELECT game.game_name, game.id, SUM(region_sales.num_sales) AS Total_Sales FROM game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
JOIN dbo.platform ON game_platform.platform_id = platform.id
JOIN dbo.region_sales ON platform.id = region_sales.game_platform_id
WHERE platform.platform_name = 'Wii' AND region_sales.num_sales < 0.5
GROUP BY game.game_name, game.id;

--Mostrar la lista de juegos de PlayStation
SELECT game.game_name, platform.platform_name FROM game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
JOIN dbo.platform ON game_platform.platform_id = platform.id
WHERE platform.platform_name IN ('PS', 'PS2', 'PS3', 'PS4');

--Cuales son los 5 generos de juego que mas se venden en Europa
SELECT TOP(5) genre.genre_name, SUM(region_sales.num_sales) AS Total_Sales 
FROM game
JOIN genre ON game.genre_id = genre.id
JOIN game_publisher ON game.id = game_publisher.game_id
JOIN game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
JOIN region_sales ON game_platform.platform_id = region_sales.game_platform_id
GROUP BY genre.genre_name
ORDER BY Total_Sales DESC;

--Que editores tienen mejor presencia en el mercado de ventas de Norte America
SELECT TOP(5) publisher.publisher_name, SUM(region_sales.num_sales) as Total
FROM publisher
JOIN game_publisher ON publisher.id = game_publisher.publisher_id
JOIN game_platform ON game_publisher.id = game_platform.game_publisher_id
JOIN region_sales ON game_platform.platform_id = region_sales.game_platform_id
JOIN region ON region_sales.region_id = region.id
WHERE region.region_name = 'North America'
GROUP BY publisher.publisher_name
ORDER BY Total DESC;

--Que editor genera mas juegos de accion
SELECT TOP(1) publisher.publisher_name, COUNT(*) as Total
FROM publisher
JOIN game_publisher ON publisher.id = game_publisher.publisher_id
JOIN game ON game_publisher.game_id = game.id
JOIN genre ON game.genre_id = genre.id
WHERE genre.genre_name = 'Action'
GROUP BY publisher.publisher_name
ORDER BY Total DESC;

--Cantidad de juegos de estrategia desarrollados por Microsof
SELECT publisher.publisher_name, COUNT(*) as Total
FROM publisher
JOIN game_publisher ON publisher.id = game_publisher.publisher_id
JOIN game ON game_publisher.game_id = game.id
JOIN genre ON game.genre_id = genre.id
WHERE genre.genre_name = 'Strategy' AND publisher.publisher_name = 'Microsoft Game Studios'
GROUP BY publisher.publisher_name;