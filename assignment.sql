CREATE DATABASE rangerdb;

CREATE table rangers (
    ranger_id SERIAL UNIQUE PRIMARY KEY,
    name TEXT,
    region TEXT
);

CREATE Table species (
    species_id SERIAL UNIQUE PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);

CREATE Table sightings (
    sighting_id SERIAL UNIQUE NOT NULL PRIMARY KEY,
    ranger_id INT REFERENCES rangers (ranger_id),
    species_id INT REFERENCES species (species_id),
    sighting_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    location TEXT,
    notes TEXT
)




insert INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta'),
    (
        'Carol King',
        'Mountain Range'
    );

SELECT * FROM rangers;

insert INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
values (
        'Snow Leopard',
        'panthera uncia',
        '1775-01-01',
        'Endengered'
    ),
    (
        'Bengal Tiger',
        'panthera tigris tigris',
        '1758-01-01',
        'Endangered'
    ),
    (
        'African Elephant',
        'loxodonta africana',
        '1758-01-01',
        'Vulnerable'
    ),
    (
        'Giant Panda',
        'ailuropoda melanoleuca',
        '1869-01-01',
        'Vulnerable'
    ),
    (
        'Red Panda',
        'ailurus fulgens',
        '1825-01-01',
        'Endangered'
    );

SELECT * FROM species;

INSERT into
    sightings (
        ranger_id,
        species_id,
        sighting_time,
        location,
        notes
    )
values (
        1,
        1,
        '2024-05-10 07:45:00',
        'Northern Hills',
        'Spotted near the river'
    ),
    (
        2,
        2,
        '2024-05-12 16:20:00',
        'River Delta',
        'Observed during patrol'
    ),
    (
        3,
        3,
        '2024-05-15 09:10:00',
        'Mountain Range',
        'Seen grazing in the valley'
    ),
    (
        1,
        4,
        '2024-05-18 18:30:00',
        'Northern Hills',
        'Near the bamboo grove'
    ),
    (
        2,
        4,
        '2024-05-15 09:10:00',
        'River Delta',
        'In the forest area'
    );

SELECT * FROM sightings;
-- 1
insert into
    rangers (name, region)
values ('Derek Fox', 'Coastal Plains');

-- 2
SELECT count(distinct species_id) as unique_species_count
from sightings;
-- 3
SELECT * from sightings WHERE location LIKE '%pass%';
-- 4
SELECT name, count(sighting_id) as total_sightings
from rangers
    join sightings on rangers.ranger_id = sightings.ranger_id
GROUP BY
    sightings.ranger_id,
    name;

-- 5
SELECT species.common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.species_id IS NULL;

    -- 6
    select * FROM sightings ORDER BY sighting_time DESC LIMIT 2;
-- 7
UPDATE species
set
    conservation_status = 'Historic'
WHERE
    discovery_date < '1800-01-01';

    -- 8
    SELECT sighting_id,
     CASE WHEN extract(HOUR FROM sighting_time) < 12 THEN 'Morning'
        WHEN extract(HOUR FROM sighting_time) >= 12 AND extract(HOUR FROM sighting_time) <= 17 THEN 'Afternoon'
        ELSE 'Evening' END AS time_of_day from sightings;
    -- 9
    DELETE FROM rangers where ranger_id in (
   SELECT rangers.ranger_id from rangers LEFT JOIN sightings ON rangers.ranger_id = sightings.ranger_id
WHERE
    sightings.ranger_id IS NULL);