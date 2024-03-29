USE [LineManage]
GO
/****** Object:  StoredProcedure [dbo].[spDeletepersonLine]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetallLineOrder]    Script Date: 4/8/2017 10:39:56 PM ******/
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
	where Deal_setPrice is null
	order by DateAndTime asc;
	
END

GO
/****** Object:  StoredProcedure [dbo].[spGetallPerson]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetallServiceTypes]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetallSupplier]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetLineBySuppCodeId]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetLogLineOrder]    Script Date: 4/8/2017 10:39:56 PM ******/
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
	where Deal_setPrice is null;
	
END

GO
/****** Object:  StoredProcedure [dbo].[spInsertNewLineOrder]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spInsertNewPerson]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spSelectService]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateLineOrder]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateSetDeal]    Script Date: 4/8/2017 10:39:56 PM ******/
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
/****** Object:  Table [dbo].[LineOrder]    Script Date: 4/8/2017 10:39:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LineOrder](
	[PersonId] [int] NOT NULL,
	[SuppCodeId] [int] NOT NULL,
	[DateAndTime] [datetime] NOT NULL,
	[Price] [int] NULL,
	[Deal_setPrice] [int] NULL,
	[DealDate] [datetime] NULL,
 CONSTRAINT [PK_LineOrder_1] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[SuppCodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Person]    Script Date: 4/8/2017 10:39:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceTypes]    Script Date: 4/8/2017 10:39:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceTypes](
	[Service] [int] IDENTITY(1,1) NOT NULL,
	[NameServTyp] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_ServiceTypes] PRIMARY KEY CLUSTERED 
(
	[Service] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 4/8/2017 10:39:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierCode] [int] NOT NULL,
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](150) NULL,
	[Phone] [int] NULL,
	[Decciption] [nvarchar](250) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[LineOrder]  WITH CHECK ADD  CONSTRAINT [FK_LineOrder_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[LineOrder] CHECK CONSTRAINT [FK_LineOrder_Person]
GO
ALTER TABLE [dbo].[LineOrder]  WITH CHECK ADD  CONSTRAINT [FK_LineOrder_Supplier] FOREIGN KEY([SuppCodeId])
REFERENCES [dbo].[Supplier] ([SupplierCode])
GO
ALTER TABLE [dbo].[LineOrder] CHECK CONSTRAINT [FK_LineOrder_Supplier]
GO
