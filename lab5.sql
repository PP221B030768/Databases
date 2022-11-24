CREATE TABLE Warehouses (
                            code INTEGER PRIMARY KEY,
                            location varchar(255) ,
                            capacity INTEGER
);

CREATE TABLE Boxes (
                       code CHARACTER(4) PRIMARY KEY,
                       contents varchar(255),
                       value REAL ,
                       warehouses INTEGER REFERENCES Warehouses(code)
);


INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Boxes(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);

SELECT * from Warehouses;

SELECT * from Boxes where value > 150;

SELECT DISTINCT contents from Boxes;

SELECT warehouses, count(*)
FROM Boxes
GROUP BY warehouses;

SELECT warehouses, count(*) as number
FROM Boxes
GROUP BY warehouses
HAVING count(*) > 2;

INSERT INTO Warehouses (code, location, capacity) VALUES (6, 'New York', 3);

INSERT INTO Boxes VALUES('H5RT', 'Papers', 200, 2);

UPDATE boxes
SET value = value*85/100
where value =
      (SELECT value from boxes order by value DESC LIMIT 1 OFFSET (2));

SELECT * from boxes;

DELETE FROM Boxes WHERE value < 150;

DELETE FROM boxes WHERE warehouses IN
                        (
                            SELECT code
                            FROM Warehouses
                            WHERE location = 'New York'
                        ) RETURNING *;


