-- Active: 1727243228775@@127.0.0.1@3306
CREATE DATABASE volunteersdb
    DEFAULT CHARACTER SET = 'utf8mb4';

    USE volunteersdb;

    -- Create the cities table
-- volunteers table will separately refer to this table via city.id to obtain name of the city
CREATE TABLE cities (
  id INT NOT NULL AUTO_INCREMENT,
  city VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

-- Insert values to the cities table
INSERT INTO cities (id, city) VALUES
(1, 'London'),
(2, 'Bristol'),
(3, 'Hove');

-- Create the languages table
-- The volunteers table will refer to a pivot table (volunteers_languages, below) via volunteer_id 
-- As one volunteer may speak one or more languages
-- And one language may be spoken by one or more volunteer
CREATE TABLE languages (
  id int NOT NULL AUTO_INCREMENT,
  language varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

-- Insert values to the languages table
INSERT INTO languages (id, language) VALUES
(1, 'German'),
(2, 'English'),
(3, 'Dutch');

-- Create the volunteers table in its FIRST AND SECOND normal form
-- TO BE UPDATED
CREATE TABLE IF NOT EXISTS volunteers (
  id INT NOT NULL AUTO_INCREMENT,
  surname VARCHAR(50) NOT NULL,
  mobile VARCHAR(15) NOT NULL,
  city_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_volunteercity FOREIGN KEY (city_id) REFERENCES cities(id)
  );

INSERT INTO volunteers (surname, mobile, city_id) VALUES
('Kroner', '0865214459',  1), -- London
('James', '45678912', 2), -- Bristol
('Dexter', '987654321', 3), -- Hove
('Stephen', '65412365', 1); -- London

CREATE TABLE salutations (
    id INT NOT NULL AUTO_INCREMENT,
    salutation VARCHAR(10) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO salutations (id, salutation) VALUES
(1, 'Mr'),
(2, 'Miss'),
(3, 'Mrs');

-- Alter table volunteers to include salutation_id
ALTER TABLE volunteers ADD COLUMN salutation_id INT NOT NULL AFTER id;

-- Insert values of salutation_id to each volunteer
UPDATE volunteers SET salutation_id = 1 WHERE (id = 1);
UPDATE volunteers SET salutation_id = 3 WHERE (id = 2);
UPDATE volunteers SET salutation_id = 2 WHERE (id = 3);
UPDATE volunteers SET salutation_id = 1 WHERE (id = 4);

-- Add constraint, where volunteers tablesalutation_id references salutations table's id
ALTER TABLE volunteers ADD CONSTRAINT fk_volunteerssalutations FOREIGN KEY (salutation_id) REFERENCES salutations(id);

-- Create a weak relationship (many-many) between volunteers and the language(s) they speak 
DROP TABLE IF EXISTS volunteers_languages;

CREATE TABLE volunteers_languages (
  volunteer_id INT NOT NULL,
  language_id INT NOT NULL,
  CONSTRAINT fk_volunteerlang FOREIGN KEY (volunteer_id) REFERENCES volunteers(id), 
  CONSTRAINT fk_langvolunteer FOREIGN KEY (language_id) REFERENCES languages(id),
  PRIMARY KEY (volunteer_id, language_id)
);

INSERT INTO volunteers_languages (volunteer_id, language_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 2),
(3, 3),
(4, 1);

- Create a table that records the hours put in by each volunteer 
DROP TABLE IF EXISTS volunteer_hours;

CREATE TABLE volunteer_hours (
id INT NOT NULL AUTO_INCREMENT,
volunteer_id INT NOT NULL,
hours INT NOT NULL,
created_at DATETIME ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_volunteer FOREIGN KEY (volunteer_id) REFERENCES volunteers(id),
PRIMARY KEY (id)
);

INSERT INTO volunteer_hours (volunteer_id, hours) VALUES
(1, 15), -- Kroner, 15 hours
(1, 12), -- Krpner, 15 hours
(2, 32), -- James, 32 hours
(3, 11), -- Dexter, 11 hours
(3, 7), -- Dexter, 7 hours 
(3, 5); -- Dexter, 11 hours

