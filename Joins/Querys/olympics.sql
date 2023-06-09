--Mostrar la lista de los ganadores de medalla de oro en eventos de Futbol, Baloncesto y Golf
SELECT p.full_name, s.sport_name
FROM person AS p
JOIN games_competitor AS gc ON p.id = gc.person_id
JOIN competitor_event AS ce ON gc.id = ce.competitor_id
JOIN event AS e ON ce.event_id = e.id
JOIN games AS g ON gc.games_id = g.id
JOIN medal AS m ON ce.medal_id = m.id
JOIN sport AS s ON e.sport_id = s.id
WHERE m.medal_name = 'Gold' 
  AND s.sport_name IN ('Football', 'Basketball', 'Golf');

--Cuales son los eventos que se jugaron en el año 2000
SELECT e.event_name, COUNT(*) AS event_count
FROM event AS e
JOIN competitor_event AS ce ON e.id = ce.event_id
JOIN games_competitor AS gc ON ce.competitor_id = gc.id
JOIN games AS g ON gc.games_id = g.id
WHERE g.games_year = 2009
GROUP BY e.event_name
ORDER BY event_count DESC;

--Cuales son las 20 principales ciudades donde se han jugado mas Olimpiadas
SELECT TOP (20) c.city_name, COUNT(DISTINCT g.id) AS games_count
FROM city AS c
JOIN games_city AS gc ON c.id = gc.city_id
JOIN games AS g ON gc.games_id = g.id
GROUP BY c.city_name
ORDER BY games_count DESC;

--Liste los paises no tienen ningun participante en las ultimas 10 olimpiadas
SELECT n.region_name
FROM noc_region AS n
LEFT JOIN person_region AS pr ON n.id = pr.region_id
LEFT JOIN games_competitor AS gc ON pr.person_id = gc.person_id
LEFT JOIN games AS g ON gc.games_id = g.id
WHERE g.games_year >= YEAR(GETDATE()) - 10
  AND pr.person_id IS NULL
GROUP BY n.region_name;

--liste los 5 paises que mas ganan medallas de oro, plata y bronce
SELECT TOP (5) n.region_name, 
       COUNT(CASE WHEN m.medal_name = 'Gold' THEN 1 END) AS gold_count,
       COUNT(CASE WHEN m.medal_name = 'Silver' THEN 1 END) AS silver_count,
       COUNT(CASE WHEN m.medal_name = 'Bronze' THEN 1 END) AS bronze_count,
       COUNT(*) AS total_count
FROM noc_region AS n
JOIN person_region AS pr ON n.id = pr.region_id
JOIN games_competitor AS gc ON pr.person_id = gc.person_id
JOIN competitor_event AS ce ON gc.id = ce.competitor_id
JOIN medal AS m ON ce.medal_id = m.id
GROUP BY n.region_name
ORDER BY gold_count DESC, silver_count DESC, bronze_count DESC, total_count DESC;

--El evento con mayor cantidad de personas participando
SELECT TOP (1) e.event_name, COUNT(DISTINCT gc.person_id) AS participant_count
FROM event AS e
JOIN competitor_event AS ce ON e.id = ce.event_id
JOIN games_competitor AS gc ON ce.competitor_id = gc.id
GROUP BY e.event_name
ORDER BY participant_count DESC;

--Liste los deportes que en todas las olimpiadas siempre se llevan a cabo
SELECT s.sport_name
FROM sport AS s
WHERE NOT EXISTS (
  SELECT g.games_year
  FROM games AS g
  LEFT JOIN games_competitor AS gc ON g.id = gc.games_id
  LEFT JOIN competitor_event AS ce ON gc.id = ce.competitor_id
  LEFT JOIN event AS e ON ce.event_id = e.id
  WHERE e.sport_id = s.id
    AND g.games_year >= YEAR(GETDATE()) - 10
  GROUP BY g.games_year
  HAVING COUNT(DISTINCT e.id) = 0
);

--Muestre la comparacion de la cantidad de veces entre los dos generos(M,F) que ganado medallas de 
--cualquier tipo
SELECT 
  p.gender,
  COUNT(m.id) AS medal_count
FROM 
  person AS p
LEFT JOIN 
  games_competitor AS gc ON p.id = gc.person_id
LEFT JOIN 
  competitor_event AS ce ON gc.id = ce.competitor_id
LEFT JOIN 
  medal AS m ON ce.medal_id = m.id
GROUP BY 
  p.gender
ORDER BY 
  p.gender;

--Cual es la altura y peso que mas es mas frecuente en los participantes del deporte de Boxeo
SELECT 
  ROUND(AVG(p.height), 2) AS average_height,
  ROUND(AVG(p.weight), 2) AS average_weight
FROM 
  person AS p
JOIN 
  games_competitor AS gc ON p.id = gc.person_id
JOIN 
  competitor_event AS ce ON gc.id = ce.competitor_id
JOIN 
  event AS e ON ce.event_id = e.id
WHERE 
  e.event_name = 'Boxing';

--Muestre los participantes menores de edad que participan en las olimpiadas
SELECT
    p.full_name,
    gc.age
FROM
    person AS p
JOIN
    games_competitor AS gc ON p.id = gc.person_id
WHERE
    gc.age < 18;