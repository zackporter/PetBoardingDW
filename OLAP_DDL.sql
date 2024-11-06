CREATE TABLE service_package
(
	package_key SERIAL PRIMARY KEY,
	package_id INT UNIQUE NOT NULL,
	package_name varchar(100) NOT NULL,
	package_rate DECIMAL(10,2) NOT NULL
);


CREATE TABLE states
(
	state_key SERIAL PRIMARY KEY,
	state_name varchar(50) NOT NULL,
	state_code varchar(10) NOT NULL,
);

CREATE TABLE city
(
	city_key SERIAL PRIMARY KEY,
	city_name VARCHAR(50) NOT NULL,
	state_key INT NOT NULL,	
	CONSTRAINT fks FOREIGN KEY (state_key) REFERENCES states(state_key),
);

CREATE TABLE vet_clinic 
(
	clinic_key SERIAL PRIMARY KEY,
	clinic_id INT UNIQUE NOT NULL,
	name TEXT NOT NULL,
	address TEXT NOT NULL,
	services_offered TEXT NOT NULL,
	contact_info TEXT NOT NULL,
	city_key INT,
	city TEXT NOT NULL,
	FOREIGN KEY (city_key) REFERENCES city(city_key)
);

CREATE TABLE caregiver
(
	caregiver_key SERIAL PRIMARY KEY,
	caregiver_id INT UNIQUE NOT NULL,
	name VARCHAR(100) NOT NULL,
	experience_level varchar(50),
	boarding_rate DECIMAL(10,2) NOT NULL,
	address VARCHAR(100),
	city_key INT,
	city TEXT NOT NULL,
	FOREIGN KEY (city_key) REFERENCES city(city_key)
);

CREATE TABLE date
(
	date_key INT PRIMARY KEY,
	date DATE NOT NULL,
	day_nb_week INT NOT NULL,
	day_name_week VARCHAR(20) NOT NULL,
	day_nb_month INT NOT NULL,
	day_nb_year INT NOT NULL,
	week_nb_year INT NOT NULL,
	month_number INT NOT NULL,
	month_name VARCHAR(20) NOT NULL,
	quarter VARCHAR(10)
);

CREATE TABLE visit_details
(
	visit_key SERIAL PRIMARY KEY,
	visit_id INT UNIQUE NOT NULL,
	visit_date date NOT NULL,
	reason TEXT NOT NULL,
	prescription_details TEXT NOT NULL
);

CREATE TABLE pet_owner
(
	pet_owner_key SERIAL PRIMARY KEY,
	owner_id INT UNIQUE NOT NULL,
	name VARCHAR(100) NOT NULL,
	contact_info VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	address VARCHAR(100) NOT NULL,
	city_key INT NOT NULL,
	city TEXT NOT NULL,
	FOREIGN KEY (city_key) REFERENCES city(city_key)
);

CREATE TABLE pet
(
	pet_key SERIAL PRIMARY KEY,
	pet_id INT UNIQUE NOT NULL,
	name VARCHAR(50) NOT NULL,
	breed VARCHAR(50) NOT NULL,
	age INT NOT NULL,
	pet_owner_key INT NOT NULL,
	FOREIGN KEY (pet_owner_key) REFERENCES pet_owner(pet_owner_key)
);


CREATE TABLE vet_visit
(
	visit_date_key INT NOT NULL,
	visit_key INT NOT NULL,
	clinic_key INT NOT NULL,
	pet_key INT NOT NULL,
	total_cost INT NOT NULL,
	visit_day VARCHAR(20) NOT NULL,
	FOREIGN KEY (visit_date_key) REFERENCES date(date_key),
	FOREIGN KEY (visit_key) REFERENCES visit_details(visit_key),
	FOREIGN KEY (clinic_key) REFERENCES vet_clinic(clinic_key),
	FOREIGN KEY (pet_key) REFERENCES pet(pet_key),
	CONSTRAINT pk1 PRIMARY KEY( visit_date_key, visit_key, clinic_key, pet_key)
	
);

CREATE TABLE booking
(
	start_date_key INT NOT NULL,
	end_date_key INT NOT NULL,
	package_key INT NOT NULL,
	pet_key INT NOT NULL,
	caregiver_key INT NOT NULL,
	booking_rate INT NOT NULL,
	caregiver_rate INT NOT NULL,
	caregiver_total INT NOT NULL,
	duration INT NOT NULL,
	FOREIGN KEY (start_date_key) REFERENCES date(date_key),
	FOREIGN KEY (end_date_key) REFERENCES date(date_key),
	FOREIGN KEY (package_key) REFERENCES service_package(package_key),
	FOREIGN KEY (pet_key) REFERENCES pet(pet_key),
	FOREIGN KEY (caregiver_key) REFERENCES caregiver(caregiver_key),
	CONSTRAINT pk2 PRIMARY KEY(start_date_key, end_date_key, package_key, pet_key, caregiver_key)
	
);