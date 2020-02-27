USE MASTER; --usar bd master
DROP DATABASE IF EXISTS BaseEmpleados; --si existe,  q la borre (no es necesario)
CREATE DATABASE BaseEmpleados; --Crear la bd
GO
USE BaseEmpleados; --Usar esa bd

CREATE TABLE Empleados(
Legajo INT IDENTITY(1,1), --aca, PRIMARY KEY
Apellido VARCHAR(50) NOT NULL,
Nombres VARCHAR(50) NOT NULL,
Ciudad VARCHAR(50) DEFAULT ('CABA'),
Pais VARCHAR(50),
CONSTRAINT PK_LegajoEmpleados PRIMARY KEY (Legajo) --Esto lo podes omitir, si pones PRIMARY KEY arriba
);

EXEC sp_columns Empleados --Stored Procedure (Procedimiento Almacenado) 
--Este sirve para mostrar los datos de X tabla

INSERT INTO Empleados --Un insert xd
VALUES('Garcia','Jose','Mendoza','Argentina');

--Gomez, Jose, Default, null

INSERT INTO Empleados
VALUES	('Gomez','Jose',default,null);

SELECT * FROM Empleados;

--Juan Ramirez, usando los campos

INSERT INTO Empleados(Nombres,Apellido)
VALUES	('Juan','Ramirez')

--Insertar sin campos legajo:10 nombre:Luis apellido:Robles
SET IDENTITY_INSERT Empleados ON; --Modificamos el insert de identity, para permitir legajos 'manuales'

INSERT INTO Empleados(Legajo,Nombres,Apellido) --Hay que especificar el campo Legajo, sino no te lo toma!!
VALUES	(10,'Luis','Robles'); 

SET IDENTITY_INSERT Empleados OFF; --Lo ponemos en OFF de nuevo, para que vuelva a ser 'automatico'(?

INSERT INTO Empleados(Nombres,Apellido) --Ya no es necesario especificarlo, y la correlatividad  desde
VALUES	('Luis2','Robles2');	--el numero de legajo insertado manualmente (en este caso, 10..11..etc)

