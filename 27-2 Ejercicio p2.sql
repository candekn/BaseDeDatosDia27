--En AdventureWorks: Crear una copia de la tabla productos, cuya subcategoria sea 1
USE AdventureWorks2016CTP3;

SELECT * INTO CopiaProductos 
FROM Production.Product AS p
WHERE p.ProductSubcategoryID=1;

SELECT * FROM CopiaProductos;

--crear una tabla a partir de la tabla con la cantidad de productos de cada color con su color
SELECT p.Color, Count(*) AS 'Cantidad de registros' --Seleccionamos el color, y contamos la cantidad
INTO Colores
FROM Production.Product AS p
GROUP BY p.Color --Agrupamos por color (o sea q va a contar y agrupar los registros por Color)

SELECT * FROM Colores;

--Actualizar el 20% del precio de subcategory 1 (copiaProductos)
--Ejecuta estas tres cosas juntas para ver la diferencia:
select ProductID, ListPrice as 'Sin Incremento' FROM CopiaProductos; --Antes del UPDATE

UPDATE CopiaProductos --UPDATE LaTablaAModificar
SET ListPrice = ListPrice*1.20 --SET LaColumnaAModificar
WHERE ProductSubcategoryID=1 --La Condicion (en este caso esta al pedo xq la tabla clonada es de subcategory=1)

SELECT ProductID, ListPrice as 'Con Incremento' FROM CopiaProductos --Despues del UPDATE

--Clonar la tabla Purchasing.PurchaseOrderDetail
SELECT * INTO CopiaPur
FROM Purchasing.PurchaseOrderDetail

SELECT * FROM CopiaPur;
--De la copia Pur, Eliminar los detalles de compra cuya fecha
--de vencimientos pertenezcan al tercer trimestre del año 2012
--dueDate

/*Aca me hice una segunda copia para ver si estaba bien lo q iba a eliminar*/
SELECT * INTO CopiaPur2
FROM CopiaPur
WHERE YEAR(DueDate)=2012 AND MONTH(DueDate) IN(7,8,9)

select * FROM CopiaPur2

;/*8845(total registro) - 149(a eliminar) */
DELETE FROM CopiaPur
WHERE YEAR(DueDate)=2012 AND MONTH(DueDate) IN(7,8,9)

SELECT * FROM CopiaPur;

--Clonar Person.Person y eliminar las personas que empiecen con M
SELECT * INTO CopiaPerson
FROM Person.Person;

DELETE FROM CopiaPerson --Eliminar de Tabla
WHERE CopiaPerson.FirstName LIKE 'M%' --Condicion




