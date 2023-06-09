// JOINS

SELECT * FROM country c ;
SELECT * FROM university u ;

--INSERT INTO country (id,country_name) values(1248,'Honduras')

/*
 1. Realizar una consulta donde pueda obtener los paises donde estan ubicadas cada universidad.
 2. Conocer cuantas universidades hay en cada pais.
 3. Conocer cuantos paises no tienen universidades en el ranking.
 */

--Respuesta 1:
SELECT u.university_name ,c.country_name  FROM university u 
inner join country c on u.country_id = c.id ;

--Repuesta 2:
SELECT c.country_name , count(u.id) 'Cantidad de Universidades' FROM country c 
INNER JOIN university u on c.id =u.country_id 
GROUP BY c.country_name 
ORDER BY c.country_name ASC






SELECT * FROM ranking_system rs ;
SELECT * FROM ranking_criteria rc ;



/*
 1. Mostrar los criterios de cada tipo de ranking
 2. Conocer el ranking que tiene mas criterios
*/

SELECT * FROM university_ranking_year ury 

/*
 * 1. Cual es el top de universidades de forma descendente del ano 2012 por cada criterio
 * 2. Mostrar las 5 universidad con mas cantidades de score 100 del ranking tipo 'Center for World University Rankings'
 * 3. Mostrar que paises se posicionaron con universidades con un score mayor a 90
 * 4. Mostrar las universidades que utilizan los criterios del tipo ranking 'Shangai Ranking'
 * 5. Mostrart el top 10 de las peores posiciones del tipo ranking 'Times Higher....'
 */
 