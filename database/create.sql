create table item (
	id INT(11) NOT NULL AUTO_INCREMENT,
	type varchar(255) NOT NULL,
	description varchar(512) NOT NULL,
	PRIMARY KEY(id)
)

INSERT INTO item (type, description) VALUES ("prefix", "Air");
INSERT INTO item (type, description) VALUES ("prefix", "Jet");
INSERT INTO item (type, description) VALUES ("prefix", "Flight");
INSERT INTO item (type, description) VALUES ("sufix", "Hub");
INSERT INTO item (type, description) VALUES ("sufix", "Station");
INSERT INTO item (type, description) VALUES ("sufix", "Mart");