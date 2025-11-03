CREATE TABLE guide(
guide_id SERIAL PRIMARY KEY,
full_name VARCHAR(255) NOT NULL,
country VARCHAR(255)
);


CREATE TABLE excursion(
excursion_id SERIAL PRIMARY KEY,
description TEXT,
place VARCHAR(255) NOT NULL,
guide_id INT NOT NULL,

	CONSTRAINT fk_guide FOREIGN KEY (guide_id) REFERENCES guide(guide_id) 
		on delete set null
);


CREATE TABLE tour(
tour_id SERIAL PRIMARY KEY,
price NUMERIC(10, 2) NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL
);


CREATE TABLE ExcursionTour(
excursion_id INT NOT NULL,
tour_id INT NOT NULL,

	CONSTRAINT fk_excursion FOREIGN KEY (excursion_id) REFERENCES excursion(excursion_id)
		on delete cascade,
		
	CONSTRAINT fk_tour FOREIGN KEY (tour_id) REFERENCES tour(tour_id)
		on delete cascade,
		
	PRIMARY KEY (excursion_id, tour_id)
);


CREATE TABLE hotel(
hotel_id SERIAL PRIMARY KEY,
country VARCHAR(255) NOT NULL,
hotel_name VARCHAR(255) NOT NULL
);


CREATE TABLE HotelTour(
hotel_id INT NOT NULL,
tour_id INT NOT NULL,

	CONSTRAINT fk_hotel FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id)
		on delete cascade,
		
	CONSTRAINT fk_tour FOREIGN KEY (tour_id) REFERENCES tour(tour_id)
		on delete cascade,

		PRIMARY KEY (hotel_id, tour_id)
);


CREATE TABLE destination (
destination_id SERIAL PRIMARY KEY,
country VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL
);


CREATE TABLE DestinationTour(
destination_id INT NOT NULL,
tour_id INT NOT NULL,

	CONSTRAINT fk_destination FOREIGN KEY (destination_id) REFERENCES destination(destination_id)
		on delete cascade,
		
	CONSTRAINT fk_tour FOREIGN KEY (tour_id) REFERENCES tour(tour_id)
		on delete cascade,

		PRIMARY KEY (destination_id, tour_id)
);


CREATE TABLE client(
client_id SERIAL PRIMARY KEY,
full_name VARCHAR(255),
email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE booking(
booking_id SERIAL PRIMARY KEY,
client_id INT NOT NULL,
tour_id INT NOT NULL,

CONSTRAINT fk_client FOREIGN KEY (client_id) REFERENCES client(client_id)
		on delete cascade,

CONSTRAINT fk_tour FOREIGN KEY (tour_id) REFERENCES tour(tour_id)
		on delete cascade
);





