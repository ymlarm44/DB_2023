CREATE TABLE CINE (
	ID_cine INT PRIMARY KEY,
	CUIT BIGINT,
	Nombre VARCHAR(30) NOT NULL
);

CREATE TABLE SALA (
	ID_sala INT PRIMARY KEY,
	TIPO VARCHAR(30)
);

CREATE TABLE TAREA (
	ID_tarea INT PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	es_riesgo BOOLEAN NOT NULL
	);
	
CREATE TABLE Cine_sala (
	ID_cine INT,
	ID_sala INT,
	CONSTRAINT id_cine_sala_pk PRIMARY KEY(ID_cine, ID_sala),
	CONSTRAINT id_cine_fk FOREIGN KEY(ID_cine)
REFERENCES CINE(ID_Cine),
	CONSTRAINT id_sala_fk FOREIGN KEY(ID_sala)
REFERENCES SALA(ID_sala)
);

CREATE TABLE EMPLEADO(
	DNI BIGINT PRIMARY KEY,
	Nombre VARCHAR(30),
	ID_cine INT,
	fecha_inicio DATE,
	fecha_fin DATE,
	supervisado_por BIGINT,
	CONSTRAINT id_cine_fk FOREIGN KEY(ID_cine)
REFERENCES CINE(ID_cine),
	CONSTRAINT DNI_fk FOREIGN KEY(supervisado_por)
REFERENCES EMPLEADO(DNI)
);

CREATE TABLE Tarea_Empleado(
	DNI BIGINT,
	ID_tarea INT,
	CONSTRAINT id_tarea_empleado_pk PRIMARY KEY(DNI, ID_tarea),
	CONSTRAINT id_tarea_fk FOREIGN KEY(ID_tarea)
REFERENCES TAREA(ID_tarea),
	CONSTRAINT id_empleado_fk FOREIGN KEY(DNI)
REFERENCES EMPLEADO(DNI)
);

INSERT INTO Cine (ID_cine, CUIT, Nombre) VALUES (5, 61291929893, 'illum');
INSERT INTO Cine (ID_cine, CUIT, Nombre) VALUES (9, 86194852330, 'id');

INSERT INTO Sala (ID_sala, tipo) VALUES (0, 'Común');
INSERT INTO Sala (ID_sala, tipo) VALUES (2, 'Ultra');
INSERT INTO Sala (ID_sala, tipo) VALUES (3, 'HD');
INSERT INTO Sala (ID_sala, tipo) VALUES (5, 'Común');
INSERT INTO Sala (ID_sala, tipo) VALUES (8, 'HD');

INSERT INTO Cine_Sala (ID_Cine, ID_Sala) VALUES (5, 0);
INSERT INTO Cine_Sala (ID_Cine, ID_Sala) VALUES (5, 3);
INSERT INTO Cine_Sala (ID_Cine, ID_Sala) VALUES (5, 8);
INSERT INTO Cine_Sala (ID_Cine, ID_Sala) VALUES (9, 2);
INSERT INTO Cine_Sala (ID_Cine, ID_Sala) VALUES (9, 5);

INSERT INTO Empleado (DNI,Nombre,ID_Cine,fecha_inicio,fecha_fin,supervisado_por)
VALUES
  (20599421,'Brielle Mendez',9,'Apr 3, 2019',NULL,NULL),
  (22211008,'Nash Abbott',9,'Feb 7, 2020','Dec 28, 2020',20599421),
  (39409537,'Melinda Manning',5,'Jul 12, 2019',NULL,22211008),
  (33752869,'Hu Snyder',9,'Mar 22, 2019','Jan 4, 2021',39409537),
  (33807023,'Yuli Slater',5,'Dec 23, 2019','Aug 6, 2020',22211008),
  (32748731,'Christen Bowen',9,'Feb 21, 2020',NULL,39409537),
  (31130764,'Regina Briggs',5,'Jan 30, 2020','Aug 5, 2020',22211008),
  (14854147,'Cedric Burt',5,'Jan 14, 2020',NULL,39409537),
  (17914042,'Knox Garcia',5,'Nov 1, 2019',NULL,39409537);

INSERT INTO Tarea (ID_Tarea, Nombre, Es_riesgo) VALUES (0, 'Limpieza', False);
INSERT INTO Tarea (ID_Tarea, Nombre, Es_riesgo) VALUES (6, 'Orden', False);
INSERT INTO Tarea (ID_Tarea, Nombre, Es_riesgo) VALUES (9, 'Reposición', True);

INSERT INTO Tarea_Empleado (ID_Tarea, DNI) VALUES (0, 20599421);
INSERT INTO Tarea_Empleado (ID_Tarea, DNI) VALUES (6, 20599421);
INSERT INTO Tarea_Empleado (ID_Tarea, DNI) VALUES (9, 20599421);
INSERT INTO Tarea_Empleado (ID_Tarea, DNI) VALUES (0, 31130764);

SELECT count(*) FROM Empleado WHERE fecha_fin IS NULL;

SELECT Nombre FROM Empleado;

SELECT (CUIT) FROM cine WHERE cine.nombre = 'illum';

SELECT count(*) FROM tarea_empleado, empleado, tarea
WHERE tarea.nombre = 'Limpieza' AND tarea.ID_Tarea =
tarea_empleado.ID_Tarea AND empleado.DNI =
tarea_empleado.DNI AND empleado.fecha_fin is NULL;

ALTER TABLE SALA
	ADD Capacidad INT;