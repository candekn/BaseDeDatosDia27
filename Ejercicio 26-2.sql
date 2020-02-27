use AdventureWorks2016CTP3;
GO
--2.Obtener cod producto, numero de producto q SON ruedas. Usando where
SELECT p.ProductID, p.ProductNumber, P.name, pc.Name FROM Production.Product AS p, Production.ProductSubCategory AS pc
WHERE P.ProductSubcategoryID=PC.ProductSubcategoryID AND pc.Name LIKE 'Wheels'


--3.Usando Join
SELECT p.ProductID, p.ProductNumber, P.name, pc.Name FROM Production.Product AS p
JOIN Production.ProductSubCategory AS pc
ON P.ProductSubcategoryID=PC.ProductSubcategoryID
WHERE pc.Name LIKE 'Wheels'

--4.Obtener el codigo de vendedor y el codigo y nombre del territorio asignado de todos los vendedores
SELECT sp.BusinessEntityID, t.TerritoryID, t.Name FROM sales.SalesPerson AS sp
JOIN Sales.SalesTerritory as t  
ON sp.TerritoryID = t.TerritoryID ORDER BY t.Name;

--5.Territorios que no tienen asignados vendedores
SELECT t.Name, sp.BusinessEntityID FROM Sales.SalesTerritory AS t
LEFT JOIN Sales.SalesPerson AS sp
ON t.TerritoryID = sp.TerritoryID
WHERE sp.BusinessEntityID IS NULL;

--Obtener nombre de categoria, nomvbre de subcategoria y nombre de producto ordenado por
--categoria y subcategoria
SELECT pc.Name 'Categoria', ps.Name 'SubCategoria', p.Name 'Producto' 
	FROM  Production.ProductCategory AS pc
	JOIN Production.ProductSubcategory AS ps 
	ON pc.ProductCategoryID=ps.ProductCategoryID
	JOIN Production.Product AS p
	ON ps.ProductSubcategoryID = p.ProductSubcategoryID
	ORDER BY pc.Name, ps.Name

--Obtener productos q tienen igual precio. Se deben mostrar de a pares: codigo y nombre de cada uno de los
--dos productos y el precio de ambos. Ordenar precio desc

SELECT p.ProductID 'ID P1', p.Name 'Name P1', pp.ProductID 'ID P2', pp.Name 'Name P2', 
p.ListPrice 'Precio 1', pp.ListPrice 'Precio 2'
FROM Production.Product AS p
CROSS JOIN Production.Product AS pp
WHERE p.ListPrice=pp.ListPrice 
AND p.ListPrice!=0
ORDER BY p.ListPrice desc

--Obtener empleados vendedores
SELECT emp.LoginID, sp.BusinessEntityID FROM HumanResources.Employee AS emp
JOIN sales.SalesPerson as sp
ON emp.BusinessEntityID=sp.BusinessEntityID

--Codigo, nombre, precio de lisgta y precio de venta de productos
--donde el precio sea inferior al precio de lista recomendado para ese producto.
--Ordenar por nombre de producto
SELECT DISTINCT p.ProductID, p.Name,p.ListPrice, od.UnitPrice FROM Production.Product AS p
JOIN Sales.SalesOrderDetail AS od
ON p.ProductID=od.ProductID
WHERE od.UnitPrice<p.ListPrice
ORDER BY 2;

--	Obetener todas las perosnas nombre y apellido, en caso de ser empleados. LoginId
SELECT pp.FirstName, pp.LastName, emp.LoginID FROM Person.Person AS pp
LEFT JOIN HumanResources.Employee AS emp
ON pp.BusinessEntityID=emp.BusinessEntityID
ORDER BY 1

--Obtener nombre de prod y proveedores cuya subcategoria es 15. Ordenar por nombre de proveedor
SELECT p.Name 'Nombre Producto', v.Name 'Nombre Proveedor' 
FROM Production.Product as P
JOIN Purchasing.ProductVendor AS pv
ON p.ProductID = pv.ProductID
JOIN Purchasing.Vendor AS v
ON pv.BusinessEntityID= v.BusinessEntityID
WHERE p.ProductSubcategoryID=15
ORDER BY v.Name;

--1.Obtener el nombre, precio de lista y precio de lista INCREMENTADO un 15% de los productos con precio 
--de lista mayor a 100$
SELECT p.Name, p.ListPrice, 'Precio incrementado' = IIF((p.ListPrice>100),(p.ListPrice+p.ListPrice*0.15),(p.ListPrice))
FROM Production.Product AS p
WHERE p.ListPrice!=0;

--2.Obtener el nombre concatenado con el apellido de todas las personas
SELECT pp.FirstName,pp.LastName, CONCAT(pp.FirstName,' ',pp.LastName) 'Nombre completo' FROM Person.Person AS pp;

--3.Obtener apellido y primera letra de todos los empleados
SELECT pp.LastName, pp.firstName, LEFT(pp.FirstName,1) as 'Primera letra' 
FROM Person.Person AS pp
JOIN HumanResources.Employee AS emp
ON pp.BusinessEntityID=emp.BusinessEntityID

--4.Obtener nombre + apellido de personas q tengan terminacion española 
SELECT CONCAT_WS(' ',pp.LastName,pp.FirstName) AS 'Nombre Completo' 
FROM Person.Person AS pp
WHERE pp.LastName LIKE '%ez'

--5.Obtener el codigo y comision actual de todos los vendedores, con cast y convert
SELECT sp.BusinessEntityID AS 'Codigo', CAST(sp.CommissionPct * sp.SalesYTD AS decimal(8,2)) as 'Comision' 
FROM Sales.SalesPerson AS sp

--6.Obtener el nombre y precio de lista (Con titulo 'El precio de lista es: ')
--De los productos cuyo precio de lista está entre 350 y 400
--Y que el nombre contenga el 46

SELECT CONCAT(p.Name,' El precio de lista es: $',p.ListPrice) AS 'Producto y Precio' 
FROM Production.Product AS p
WHERE p.ListPrice BETWEEN 350 AND 400
AND p.name LIKE '%46%';

--8.Obtener numero fecha de emision y fecha de entrega sumandole 2 dias a la fecha de emision
SELECT soh.orderDate,  CAST(DATEADD(D,2,soh.OrderDate) AS date) AS 'Fecha de entrega(+2)' 
FROM Sales.SalesOrderHeader AS soh

--SET IDENTITY_INSERT tabla ON;
--Significa que podemos insertar registros en campos IDENTITY
--Y cambiar la correlatividad 
--SET IDENTITY_INSERT tabla OFF;
--Vuelve a la correlatividad antes del ON