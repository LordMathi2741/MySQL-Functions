--2 Crear una función que retorne el nombre de la categoría con la mayor cantidad de ítems de productos
-- vendidos para un determinado año.
go
alter view VTotalSales as 
Select COUNT(OD.OrderID) as TotalSales, ProductName, CategoryName, Year(OrderDate) as Anio 
FROM [Order Details] as OD 
Join Products as P on OD.ProductID = P.ProductID 
Join Categories as C on P.CategoryID = C.CategoryID
Join Orders as O on OD.OrderID = O.OrderID
group by ProductName, CategoryName, Year(OrderDate)
go

create view VMaxSale as 
Select Max(TotalSales) as MaxSale, ProductName, CategoryName, Anio 
FROM VTotalSales
Where Anio = 2018
Group by ProductName, CategoryName, Anio
go

alter function FCategoryWithMaxSale(@Year int) returns varchar(50) 
begin 
    declare @Category varchar(50) 
	declare @Sale int
	Select @Sale = MAX(MaxSale) FROM VMaxSale  WHERE Anio = @Year 
	Select @Category = CategoryName FROM VMaxSale WHERE Anio = @Year and MaxSale = @Sale  
	return @Category
end 

print dbo.FCategoryWithMaxSale(2018)




