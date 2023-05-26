--convenient commands
select * from DimProperty;
select * from DimSales;
select * from DimTown;
select * from DimDate;
select * from DimIncome;
select * from FactSales;
select * from FactIncome;

--loading dimension tables

--create DimProperty table
create table DimProperty (
DimPropertyID int identity(1,1) not null primary key,
Serial_Number varchar(max) null,
Property_Town varchar(max) null,
Address varchar(max) null,
Residential_Type varchar(max) null,
Property_Type varchar(max) null,
Effective_from_date varchar(max) null,
Effective_to_date varchar(max) null,
is_Current smallint
);


--create DimDate table
create table DimDate (
DimDateID int identity(1,1) not null primary key,
Date_Recorded varchar(max), 
List_Year varchar(12),
Year_Recorded varchar(12),
Month_Recorded varchar(12),
Tax_Year varchar(12)
);


--create DimSales table
create table DimSales (
DimSalesID int identity(1,1) not null primary key,
Serial_Number varchar(max),
Assessed_Value varchar(max),
Sale_Amount varchar(max),
Sales_Ratio varchar(max),
Timestamp timestamp
);

--create DimTown table
create table DimTown (
DimTownID int identity(1,1) not null primary key,
Income_Town varchar(50),
Property_Town varchar(50)
);


--create DimIncome table
create table DimIncome (
DimIncomeID int identity(1,1) not null primary key,
Income_Town varchar(50),
CT_AGI varchar(50),
Tax_Year varchar(12)
);


--create FactSales table
create table FactSales (
DimSalesID varchar(20), 
DimTownID varchar(20), -- FOREIGN KEY REFERENCES DimTown(DimTownID), 
DimDateID varchar(20), -- FOREIGN KEY REFERENCES DimDate(DimDateID),
DimIncomeID varchar(20), --FOREIGN KEY REFERENCES DimIncome(DimIncomeID),
Serial_Number varchar(max),
Assessed_Value varchar(max),
Sale_Amount varchar(max),
CT_AGI varchar(50)
);

--add foreign key constraints
alter table FactSales
alter column DimTownID int not null;
alter table FactSales
alter column DimDateID int not null;


alter table FactSales
add foreign key (DimSalesID) REFERENCES DimSales(DimSalesID);
alter table FactSales
add foreign key (DimTownID) REFERENCES DimTown(DimTownID);
alter table FactSales
add foreign key (DimDateID) REFERENCES DimDate(DimDateID);
alter table FactSales
add foreign key (DimIncomeID) REFERENCES DimIncome(DimIncomeID);

--create FactIncome table
create table FactIncome (
DimIncomeID varchar(20), --FOREIGN KEY REFERENCES DimIncome(DimIncomeID),
DimDateID varchar(20), --FOREIGN KEY REFERENCES DimDate(DimDateID),
DimTownID varchar(20), --FOREIGN KEY REFERENCES DimTown(DimTownID),
Fed_AGI varchar(50),
CT_AGI varchar(50)
);

--add foreign keys to FactIncome
alter table FactIncome
alter column DimTownID int not null;
alter table FactIncome
alter column DimDateID int not null;
alter table FactIncome
alter column DimIncomeID int not null;

alter table FactIncome
add foreign key (DimTownID) REFERENCES DimTown(DimTownID);
alter table FactIncome
add foreign key (DimDateID) REFERENCES DimDate(DimDateID);
alter table FactIncome
add foreign key (DimIncomeID) REFERENCES DimIncome(DimIncomeID);