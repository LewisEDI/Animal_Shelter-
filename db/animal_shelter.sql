DROP TABLE animals;
DROP TABLE owners;

CREATE TABLE owners (
  id SERIAL8 primary key,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  phone_number INT8,
  address VARCHAR (255)

);

CREATE TABLE animals (
  id SERIAL8 primary key,
  name VARCHAR(255),
  species VARCHAR(255),
  breed VARCHAR(255),
  age INT4,
  recieved_date VARCHAR(255),
  adoptable VARCHAR(255),
  photo VARCHAR(255),
  owner_id INT8 REFERENCES owners(id)

);
