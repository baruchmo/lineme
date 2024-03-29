USE [LineManage]
GO
/****** Object:  StoredProcedure [dbo].[spDeletepersonLine]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spDeletepersonLine]
@PersonId int,@SuppCodeId int

AS
BEGIN
DELETE FROM [dbo].[LineOrder]
      WHERE PersonId=@PersonId and SuppCodeId=@SuppCodeId;
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetallLineOrder]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetallLineOrder]
As
BEGIN
	Select PersonId,SuppCodeId,DateAndTime ,Price,Deal_setPrice,DealDate, NameServTyp from LineOrder
	inner join Supplier on LineOrder.SuppCodeId=Supplier.SupplierCode
	inner join ServiceTypes on Supplier.ServiceId=ServiceTypes.Service 
	order by DateAndTime asc;
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetallPerson]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetallPerson]
As
BEGIN
	select * from Person
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetallServiceTypes]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spGetallServiceTypes]
As
BEGIN
	Select * from ServiceTypes
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetallSupplier]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spGetallSupplier]
As
BEGIN
	Select * from Supplier
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetLineBySuppCodeId]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetLineBySuppCodeId]
As
BEGIN
	select count(PersonId) as TotalinLine,SuppCodeId,NameServTyp,Count(Deal_setPrice) as DealTotal from LineOrder
	inner join Supplier on LineOrder.SuppCodeId=Supplier.SupplierCode
	inner join ServiceTypes on Supplier.ServiceId=ServiceTypes.Service
	Group by SuppCodeId,NameServTyp;



	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetLogLineOrder]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetLogLineOrder]
As
BEGIN
	Select PersonId,SuppCodeId,DateAndTime,(Price)as Start_Price ,Deal_setPrice,DealDate, NameServTyp from LineOrder
	inner join Supplier on LineOrder.SuppCodeId=Supplier.SupplierCode
	inner join ServiceTypes on Supplier.ServiceId=ServiceTypes.Service 
	where Deal_setPrice>0
	
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertNewLineOrder]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spInsertNewLineOrder]
@PersonId int,@SuppCodeId int,@Price int
As
BEGIN
	insert into LineOrder
	([PersonId],[SuppCodeId],[DateAndTime],[Price])
	Values (@PersonId,@SuppCodeId,getdate(),@Price);



	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertNewPerson]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spInsertNewPerson]
@Id int,@Name nvarchar(50)
As
BEGIN
	insert into Person
	([Id],[Name])
	Values (@Id,@Name)



	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spSelectService]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSelectService]
As
BEGIN
	Select SupplierCode,NameServTyp as Service from Supplier
	inner join ServiceTypes on Supplier.ServiceId=ServiceTypes.Service;


	
	
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateLineOrder]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spUpdateLineOrder]
@PersonId int,@SuppCodeId int,@Deal_setPrice int
AS
BEGIN
UPDATE LineOrder
set 
  [Deal_setPrice] = @Deal_setPrice     

	where PersonId=@PersonId and SuppCodeId=@SuppCodeId;
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateSetDeal]    Script Date: 4/5/2017 12:28:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE  [dbo].[spUpdateSetDeal]
@PersonId int,@SuppCodeId int,@Deal_setPrice int
AS
BEGIN
UPDATE LineOrder
set  [Deal_setPrice] = @Deal_setPrice
      ,[DealDate] = getdate()
	where PersonId=@PersonId and SuppCodeId=@SuppCodeId
END

GO
