
CREATE USER 'magandakami'@'localhost' IDENTIFIED BY 'magandakami';

GRANT ALL PRIVILEGES ON * . * TO 'magandakami'@'localhost';

DROP DATABASE IF EXISTS foresthackDB;
CREATE DATABASE foresthackDB;

USE foresthackDB;

CREATE TABLE IF NOT EXISTS tree(
	tree_id INT AUTO_INCREMENT PRIMARY KEY,
	treeName VARCHAR(64) UNIQUE NOT NULL,
	scientificName VARCHAR(64) NOT NULL,
	familyName VARCHAR(64),
	conservationStatus VARCHAR(16),
	uses VARCHAR(128),
	seedType VARCHAR(16),
	seedCount INT(6)
);

CREATE TABLE IF NOT EXISTS phenology(
	treeName VARCHAR(64) UNIQUE NOT NULL,
	flowering VARCHAR(128),
	fruiting VARCHAR(128),
	maturity VARCHAR(128),
	collection VARCHAR(128),
	FOREIGN KEY (treeName) REFERENCES tree(treeName)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS user(
	username VARCHAR(32) UNIQUE NOT NULL,
	password VARCHAR(32) NOT NULL,
	fullname VARCHAR(64) NOT NULL,
	email VARCHAR(32) NOT NULL,
	cpNumber INT(11),
	type VARCHAR(12) NOT NULL
);

CREATE TABLE IF NOT EXISTS plantedTree(
	plantedtree_id INT AUTO_INCREMENT PRIMARY KEY,
	treeName VARCHAR(64) NOT NULL,
	owner VARCHAR(32) NOT NULL,
	plantedBy VARCHAR(32) NOT NULL,
	datePlanted TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	status VARCHAR(64),
	FOREIGN KEY (treeName) REFERENCES tree(treeName)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (owner) REFERENCES user(username)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (plantedBy) REFERENCES user(username)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS report(
	report_id INT AUTO_INCREMENT PRIMARY KEY,
	treeName VARCHAR(64) NOT NULL,
	employerUname VARCHAR(32) NOT NULL,
	employeeUname VARCHAR(32) NOT NULL,
	reportTxt VARCHAR(256) NOT NULL,
	reportImg VARCHAR(64) NOT NULL,
	dateReported TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (employerUname) REFERENCES user(username)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (employeeUname) REFERENCES user(username)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS seedStores(
	seedStores_id INT AUTO_INCREMENT PRIMARY KEY,
	seedName VARCHAR(64) NOT NULL,
	storeName VARCHAR(64) NOT NULL,
	FOREIGN KEY (seedName) REFERENCES tree(treeName)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);