							--SUBCONSULTAS: Sufre, perra
--Consulta principal(externa): Se utilizan los valores que devuelve la interna
--Subconsulta(interna): Se ejecuta primero y se pasa a la principal
--Correlacionada: Los parametros de la subconsulta se utilizan en la condicion de la principal
--Independiente: EL resultado de la subconsulta no se usa para condicionar a la Principal

--Una subconsulta que te trae esos datos de SalesOrderID donde el ID de customer sea
--igual al CustomerID de los que trabajan en Europa
SELECT SalesOrderID, OrderDate,CustomerID
FROM SALES.SalesOrderHeader
WHERE CustomerID IN (
	SELECT c.CustomerID FROM Sales.Customer AS c --Esta
	JOIN Sales.SalesTerritory AS t	--Verga
	ON c.TerritoryID=t.TerritoryID --Es la
	WHERE t.[group]='Europe'); --Subconsulta

--Lo mismo de arriba con JOIN:
SELECT soh.SalesOrderID, soh.OrderDate, soh.CustomerID 
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.Customer AS c
ON soh.CustomerID=c.CustomerID
JOIN Sales.SalesTerritory AS t
ON c.TerritoryID=t.TerritoryID
WHERE t.[Group]= 'Europe'; --Se pone corchetes en [group] porque es una palabra reservada (GROUP BY),
							--si se lo sacas, te da error


--Obtener id, nombre y precio de los productos que su precio sea igual al minimo
SELECT p.ProductID, p.Name, p.ListPrice 
FROM Production.Product AS p
WHERE ListPrice=
(SELECT MIN(ListPrice) FROM Production.Product) --Subconsulta escalar: Porque trae un solo resultado

--Seleccionar los productos que su precio sea mayor al precio promedio
SELECT p.ProductID, p.Name, p.ListPrice 
FROM Production.Product AS p
WHERE ListPrice>(SELECT AVG(ListPrice) FROM Production.Product) --Escalar que trae el promedio
ORDER BY p.ListPrice --Ordenamos por precio 

/*
	Vimos tambien IN, ALL, EXISTS, NOT IN, etc...
	Pero muy por arriba, podes googlearlo
*/
