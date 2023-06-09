--Mostrar una lista de los superpoderes que tiene cada Super Heroe
SELECT superhero.superhero_name, superpower.power_name 
FROM superhero
JOIN hero_power ON superhero.id = hero_power.power_id
JOIN superpower ON hero_power.power_id = superpower.id
GROUP BY superhero.superhero_name, superpower.power_name
ORDER BY superhero.superhero_name;

--Mostrar la cantidad de superpoderes con los que cuenta cada Super Heroe
SELECT s.superhero_name, COUNT(hp.power_id) AS power_count
FROM superhero s
JOIN hero_power hp ON s.id = hp.hero_id
GROUP BY s.superhero_name;

--Mostrar los diez superpoderes que es mas frecuente en cada Super Heroe
SELECT TOP (10) sp.power_name, COUNT(hp.hero_id) AS power_count
FROM superpower AS sp
JOIN hero_power AS hp ON sp.id = hp.power_id
GROUP BY sp.power_name
ORDER BY power_count DESC;

--Mostrar los Super Heroes que no cuentan con el Atributo de Intelligence
SELECT superhero.superhero_name
FROM superhero
WHERE id NOT IN (
  SELECT hero_id
  FROM hero_attribute
  JOIN attribute ON hero_attribute.attribute_id = attribute.id
  WHERE attribute.attribute_name = 'Intelligence'
);

--Mostrar los Super Heroes que cuentan con tres o 5 Atributos
SELECT superhero.superhero_name
FROM superhero
JOIN (
  SELECT hero_id, COUNT(attribute_id) AS attribute_count
  FROM hero_attribute
  GROUP BY hero_id
  HAVING COUNT(attribute_id) = 3 OR COUNT(attribute_id) = 5
) AS counts ON superhero.id = counts.hero_id;

--Mostrar la lista de las mujeres que son Super Heroes
SELECT superhero.superhero_name
FROM superhero
WHERE gender_id = (
  SELECT id
  FROM gender
  WHERE gender.gender = 'Female'
);

--Mostrar la lista de los colores de como se identifca un Super Heroe (color de ojos, traje y pelo)
SELECT s.superhero_name, e.colour AS eye_color, h.colour AS hair_color, sk.colour AS skin_color
FROM superhero AS s
JOIN colour AS e ON s.eye_colour_id = e.id
JOIN colour AS h ON s.hair_colour_id = h.id
JOIN colour AS sk ON s.skin_colour_id = sk.id;

--Mostrar la lista de Super Heroe indicando su origen (race) y cantidad de superpoderes
SELECT s.superhero_name, r.race, COUNT(hp.power_id) AS power_count
FROM superhero AS s
JOIN race AS r ON s.race_id = r.id
LEFT JOIN hero_power AS hp ON s.id = hp.hero_id
GROUP BY s.superhero_name, r.race;

--Mostrar la cantidad de superheroes que tienen un papel de Superheroe Bueno(alignment) 
--agrupado por cada editor(publisher)
SELECT p.publisher_name, COUNT(s.id) AS hero_count
FROM superhero AS s
JOIN alignment AS a ON s.alignment_id = a.id
JOIN publisher AS p ON s.publisher_id = p.id
WHERE a.alignment = 'Good'
GROUP BY p.publisher_name;
