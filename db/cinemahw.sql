DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers (
id SERIAL PRIMARY KEY,
name VARCHAR(255),
funds NUMERIC
);


CREATE TABLE films (
id SERIAL PRIMARY KEY,
title VARCHAR(255),
price NUMERIC
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  show_time VARCHAR(255),
  film_id INT REFERENCES films(id) ON DELETE CASCADE
  --film_name VARCHAR(255)
);

CREATE TABLE tickets (
id SERIAL PRIMARY KEY,
customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
film_id INT REFERENCES films(id) ON DELETE CASCADE,
screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
