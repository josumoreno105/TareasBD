--Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.
SELECT country.country_name
FROM country
INNER JOIN university ON university.country_id = country.id
GROUP BY country.country_name

--Conocer cuantas universidades hay en cada pais.
SELECT country.country_name, COUNT(university.id) AS university_count
FROM country
LEFT JOIN university ON university.country_id = country.id
GROUP BY country.id, country.country_name

--Conocer cuantos paises no tienen universidades en el ranking.
SELECT COUNT(country.id) AS pais_sin_uni
FROM country
LEFT JOIN university ON university.country_id = country.id
WHERE country.id IS NULL

--Mostrar los criterios de cada tipo de ranking.
SELECT ranking_criteria.criteria_name, ranking_system.system_name
FROM ranking_criteria
INNER JOIN ranking_system ON ranking_system.id = ranking_criteria.ranking_system_id

--Conocer el ranking que tiene mas criterios
SELECT ranking_system.system_name, COUNT(ranking_criteria.id) AS criteria_count
FROM ranking_system 
LEFT JOIN ranking_criteria ON ranking_criteria.ranking_system_id = ranking_system.id
GROUP BY ranking_system.system_name
ORDER BY criteria_count DESC
 
--Cual es el top de universidades de forma descendente del ano 2012 por cada criterio
SELECT ranking_criteria.criteria_name, university.university_name, university_ranking_year.score
FROM university_ranking_year
INNER JOIN ranking_criteria ON ranking_criteria.id = university_ranking_year.ranking_criteria_id
INNER JOIN university ON university.id = university_ranking_year.university_id
WHERE university_ranking_year.year = 2012
ORDER BY ranking_criteria.criteria_name, university_ranking_year.score DESC

--Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'
SELECT TOP 5 university.name, COUNT(university_ranking_year.score) AS score_count
FROM university_ranking_year
INNER JOIN ranking_criteria ON ranking_criteria.id = university_ranking_year.ranking_criteria_id
INNER JOIN university ON university.id = university_ranking_year.university_id
INNER JOIN ranking_system ON ranking_system.id = ranking_criteria.ranking_system_id
WHERE ranking_criteria.criteria_name = 'Center for World University Rankings'
  AND university_ranking_year.score = 100
GROUP BY university.name
ORDER BY score_count DESC

--Mostrar que paises se posicionaron con universidades con un score mayor a 90
SELECT university.university_name, university_ranking_year.score
FROM university_ranking_year
INNER JOIN university ON university.id = university_ranking_year.university_id
INNER JOIN ranking_criteria ON ranking_criteria.id = university_ranking_year.ranking_criteria_id
WHERE university_ranking_year.score > 90

--Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'
SELECT university.university_name
FROM university
INNER JOIN university_ranking_year ON university_ranking_year.university_id = university.id
INNER JOIN ranking_criteria ON ranking_criteria.id = university_ranking_year.ranking_criteria_id
INNER JOIN ranking_system ON ranking_system.id = ranking_criteria.ranking_system_id
WHERE ranking_system.system_name = 'Shanghai Ranking'

--Mostrar el top 10 de las peores posiciones del tipo ranking 'Times Higher....'
SELECT TOP(10) university.university_name
FROM university
INNER JOIN university_ranking_year ON university_ranking_year.university_id = university.id
INNER JOIN ranking_criteria ON ranking_criteria.id = university_ranking_year.ranking_criteria_id
INNER JOIN ranking_system ON ranking_system.id = ranking_criteria.ranking_system_id
WHERE ranking_system.system_name = 'Times Higher Education World University Ranking'
ORDER BY university_ranking_year.score ASC