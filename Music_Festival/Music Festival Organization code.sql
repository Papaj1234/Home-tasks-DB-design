CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INT,

    CONSTRAINT fk_manager FOREIGN KEY (manager_id)
        REFERENCES staff(staff_id) ON DELETE SET NULL
);

CREATE TABLE ticket (
    ticket_id SERIAL PRIMARY KEY,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE festival (
    festival_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    ticket_id INT NOT NULL,

    CONSTRAINT fk_ticket FOREIGN KEY (ticket_id)
        REFERENCES ticket(ticket_id)
);

CREATE TABLE event (
    event_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    event_date DATE NOT NULL,
    festival_id INT NOT NULL,

    CONSTRAINT fk_festival FOREIGN KEY (festival_id)
        REFERENCES festival(festival_id) ON DELETE CASCADE
);

CREATE TABLE sponsor (
    sponsor_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE FestivalSponsor (
    sponsor_id INT NOT NULL,
    festival_id INT NOT NULL,

    CONSTRAINT fk_sponsor FOREIGN KEY (sponsor_id)
        REFERENCES sponsor(sponsor_id),
    CONSTRAINT fk_festival FOREIGN KEY (festival_id)
        REFERENCES festival(festival_id),

    PRIMARY KEY (sponsor_id, festival_id)
);

CREATE TABLE artist (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    role_in_the_group VARCHAR(100)
);

CREATE TABLE band (
    band_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE EventBand (
    event_id INT NOT NULL,
    band_id INT NOT NULL,

    CONSTRAINT fk_event FOREIGN KEY (event_id)
        REFERENCES event(event_id),
    CONSTRAINT fk_band FOREIGN KEY (band_id)
        REFERENCES band(band_id),

    PRIMARY KEY (event_id, band_id)
);

CREATE TABLE ArtistBand (
    artist_id INT NOT NULL,
    band_id INT NOT NULL,

    CONSTRAINT fk_artist FOREIGN KEY (artist_id)
        REFERENCES artist(artist_id),
    CONSTRAINT fk_band FOREIGN KEY (band_id)
        REFERENCES band(band_id),

    PRIMARY KEY (artist_id, band_id)
);

CREATE TABLE genre (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE GenreBand (
    genre_id INT NOT NULL,
    band_id INT NOT NULL,

    CONSTRAINT fk_genre FOREIGN KEY (genre_id)
        REFERENCES genre(genre_id),
    CONSTRAINT fk_band FOREIGN KEY (band_id)
        REFERENCES band(band_id),

    PRIMARY KEY (genre_id, band_id)
);

CREATE TABLE equipment (
    equipment_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

CREATE TABLE EventEquipment (
    equipment_id INT NOT NULL,
    event_id INT NOT NULL,

    CONSTRAINT fk_equipment FOREIGN KEY (equipment_id)
        REFERENCES equipment(equipment_id),
    CONSTRAINT fk_event FOREIGN KEY (event_id)
        REFERENCES event(event_id) ON DELETE CASCADE,

    PRIMARY KEY (equipment_id, event_id)
);

CREATE TABLE EventStaff (
    staff_id INT NOT NULL,
    event_id INT NOT NULL,

    CONSTRAINT fk_staff FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id),
    CONSTRAINT fk_event FOREIGN KEY (event_id)
        REFERENCES event(event_id) ON DELETE CASCADE,

    PRIMARY KEY (staff_id, event_id)
);
