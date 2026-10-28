use sql_murder_mystery;
show tables;
-- Preguntando por la escena del crimen, hay 3 rows, solo una de ellas corresponde al crimen
SELECT 
    *
FROM
    crime_scene_report
WHERE
    date LIKE '20180115'
        AND city LIKE 'SQL%';
#'20180115', 'murder', 'Security footage shows that there were 2 witnesses. 
#The first witness lives at the last house on \"Northwestern Dr\". 
#The second witness, named Annabel, lives somewhere on \"Franklin Ave\".', 'SQL City'

-- El primer testigo viven en la calle Northwestern Dr en el ultimo numero, en la siguiente saco el nombre
-- Segundo testigo
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
AND address_number = (
    SELECT MAX(address_number)
    FROM person
    WHERE address_street_name = 'Northwestern Dr'
)
UNION
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
AND name LIKE 'Annabel%';
#Primer testigo -'Morty Schapiro'
#'I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
#The membership number on the bag started with "48Z". Only gold members have those bags. 
#The man got into a car with a plate that included "H42W".'
#Segundo testigo 'Annabel Miller'
#'I saw the murder happen, and I recognized the killer from my gym when 
#I was working out last week on January the 9th.'
SELECT 
    *
FROM
    person p
        INNER JOIN
    get_fit_now_member gymM ON p.id = gymM.person_id
        INNER JOIN
    drivers_license dl ON p.license_id = dl.id
WHERE
    membership_status LIKE 'gold'
        AND gymM.id LIKE '%48Z%'
        AND plate_number LIKE '%H42W%';
#Asesino encontrado "Jeremy Bowers"
-- Interroga el policia al asesino, para encontrar quien le contrató  
    SELECT 
    *
FROM
    person p
        INNER JOIN
    interview i ON p.id = i.person_id
WHERE
    p.name LIKE 'Jeremy Bowers';
    #'I was hired by a woman with a lot of money. I don''t know her name but 
    #I know she''s around 5''5" (65") or 5''7" (67"). 
    #She has red hair and she drives a Tesla Model S. 
    #I know that she attended the SQL Symphony Concert 3 times in December 2017.
    
    -- ver los eventos -> select * from facebook_event_checkin;
    -- Buscar a la chica con el pelo rojo la altura entre y que haya ido al concierto SQL 3 veces
SELECT 
    *
FROM
    person p
        INNER JOIN
    drivers_license dl ON p.license_id = dl.id
        INNER JOIN
    facebook_event_checkin face ON p.id = face.person_id
WHERE
    face.event_name LIKE 'SQL Symphony Concert'
        AND gender LIKE 'female'
        AND dl.hair_color LIKE 'red'
        AND dl.height BETWEEN 65 AND 67;
#'Miranda Priestly' fue 3 veces encima tiene un tesla s, culpable maxima