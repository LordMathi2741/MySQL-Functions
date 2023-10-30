--3 Crear una función que retorne la cantidad de órdenes atendidas para un determinado año.
go
create view VTotalOrdersByYear as 
  SELECT COUNT(OrderID) as TotalOrders, Year(OrderDate) as Anio 
  FROM Orders 
  Group by Year(OrderDate)
go
go
create function FUNCTotalOrdersByYear(@Year int) returns int
begin 
    declare @TotalOrders int 
	Select @TotalOrders = TotalOrders FROM VTotalOrdersByYear Where Anio = @Year
	return @TotalOrders
  end
go
print dbo.FUNCTotalOrdersByYear(2017)