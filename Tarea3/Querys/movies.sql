--Mostrar la lista de todas las peliculas indicando si esta en Idioma español o no
SELECT m.title, CASE WHEN l.language_name = 'Spanish' THEN 'Yes' ELSE 'No' END AS is_spanish
FROM movie AS m
LEFT JOIN movie_languages AS ml ON m.movie_id = ml.movie_id
LEFT JOIN language AS l ON ml.language_id = l.language_id;

--Mostrar el genero(drama, accion, terror, etc) de cada pelicula
SELECT m.title, g.genre_name
FROM movie AS m
JOIN movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN genre AS g ON mg.genre_id = g.genre_id; 

--Cuales son las 5 compañias productoras de peliculas que tiene mayor aceptacion (votos)
SELECT TOP (5) pc.company_name, COUNT(m.vote_count) AS total_votes
FROM movie AS m
JOIN movie_company AS mc ON m.movie_id = mc.movie_id
JOIN production_company AS pc ON mc.company_id = pc.company_id
WHERE m.vote_average > 7
GROUP BY pc.company_name
ORDER BY total_votes DESC;

--Mostrar una lista de las personas que participan en cada pelicula
SELECT m.title, p.person_name
FROM movie AS m
JOIN movie_crew AS mc ON m.movie_id = mc.movie_id
JOIN person AS p ON mc.person_id = p.person_id;

--Mostrar una lista con la cantidad de personas por departamento que cuenta cada compañia productora
SELECT pc.company_name, d.department_name, COUNT(p.person_id) AS person_count
FROM production_company AS pc
JOIN movie AS m ON pc.company_id = m.movie_id
JOIN movie_crew AS mc ON m.movie_id = mc.movie_id
JOIN person AS p ON mc.person_id = p.person_id
JOIN department AS d ON mc.department_id = d.department_id
GROUP BY pc.company_name, d.department_name;

--Mostrar las peliculas en las que ha participado las personas como parte del movie_cast
SELECT m.title, p.person_name, mc.character_name
FROM movie AS m
JOIN movie_cast AS mc ON m.movie_id = mc.movie_id
JOIN person AS p ON mc.person_id = p.person_id;

--Listar los paises donde estan ubicas las compañias productoras
SELECT DISTINCT c.country_name
FROM production_company AS pc
JOIN movie_company AS mc ON pc.company_id = mc.company_id
JOIN movie AS m ON mc.movie_id = m.movie_id
JOIN production_country AS pcn ON m.movie_id = pcn.movie_id
JOIN country AS c ON pcn.country_id = c.country_id;

--Mostrar de la lista de elencos cuantas mujeres participan en una pelicula de drama
SELECT m.title, COUNT(p.person_id) AS woman_count
FROM movie AS m
JOIN movie_cast AS mc ON m.movie_id = mc.movie_id
JOIN person AS p ON mc.person_id = p.person_id
JOIN gender AS g ON mc.gender_id = g.gender_id
JOIN movie_genres AS mg ON m.movie_id = mg.movie_id
JOIN genre AS ge ON mg.genre_id = ge.genre_id
WHERE ge.genre_name = 'Drama' AND g.gender = 'Female'
GROUP BY m.title;

--Mostrar la cantidad de idiomas en los que se dobla cada pelicula
SELECT m.title, COUNT(DISTINCT ml.language_id) AS language_count
FROM movie AS m
JOIN movie_languages AS ml ON m.movie_id = ml.movie_id
GROUP BY m.title;

--Mostrar las 8 palabras claves mas utilizadas en las peliculas
SELECT TOP (8) k.keyword_name, COUNT(*) AS keyword_count
FROM keyword AS k
JOIN movie_keywords AS mk ON k.keyword_id = mk.keyword_id
GROUP BY k.keyword_name
ORDER BY keyword_count DESC;