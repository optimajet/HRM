/*
Company: OptimaJet
Project: DWKit HRM
File: CreateObjects.sql
*/

BEGIN TRANSACTION

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'Department')
BEGIN
	CREATE TABLE dbo.Department (
	  Id uniqueidentifier NOT NULL,
	  [Name] nvarchar(256) NOT NULL
	  CONSTRAINT PK_Department PRIMARY KEY (Id)
	)
	PRINT 'Department CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'Location')
BEGIN
	CREATE TABLE dbo.[Location] (
	  Id uniqueidentifier NOT NULL,
	  [Name] nvarchar(256) NOT NULL,
	  Phone nvarchar(256) NOT NULL,
	  [Address] nvarchar(256) NOT NULL
	  CONSTRAINT PK_Location PRIMARY KEY (Id)
	)
	PRINT 'Location CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'Document')
BEGIN
	CREATE TABLE dbo.Document (
	  Id uniqueidentifier NOT NULL,
	  NumberId int IDENTITY,
	  [Date] datetime NULL,
	  LastUpdatedDate datetime NULL,
	  [Type] nvarchar(50) NOT NULL,
	  [Name] nvarchar(256) NOT NULL,
	  AuthorId uniqueidentifier NOT NULL,
	  ManagerId uniqueidentifier NULL,
	  Comment nvarchar(max) NULL,
	  [Extensions] nvarchar(max) NULL,
	  [State] nvarchar(256) NULL,
	  [Amount] money NOT NULL CONSTRAINT DF_Document_Amount DEFAULT (0),
	  LastUpdatedEmployeeId uniqueidentifier NULL,
	  CONSTRAINT PK_Document PRIMARY KEY (Id)	  
	)

	PRINT 'Document CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'DocumentFiles')
BEGIN
	CREATE TABLE dbo.DocumentFiles (
	  Id uniqueidentifier NOT NULL,
	  DocumentId uniqueidentifier NOT NULL,
	  Token nvarchar(50) NULL,
	  [Name] nvarchar(256) NULL,
	  [Size] int NULL,
	  CONSTRAINT PK_DocumentFiles PRIMARY KEY (Id)	  
	)

	PRINT 'DocumentFiles CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'DocumentTransitionHistory')
BEGIN
	CREATE TABLE dbo.DocumentTransitionHistory (
	  Id uniqueidentifier NOT NULL,
	  DocumentId uniqueidentifier NOT NULL,
	  EmployeeId uniqueidentifier NULL,
	  TransitionTime datetime NULL,
	  [Order] bigint IDENTITY,
	  InitialState nvarchar(1024) NOT NULL,
	  DestinationState nvarchar(1024) NOT NULL,
	  Command nvarchar(1024) NOT NULL,
	  AllowedToEmployeeNames nvarchar(max) NOT NULL,
	  CONSTRAINT PK_DocumentTransitionHistory PRIMARY KEY (Id),
	  CONSTRAINT FK_DocumentTransitionHistory_Document FOREIGN KEY (DocumentId) REFERENCES dbo.Document (Id) ON DELETE CASCADE ON UPDATE CASCADE	  
	)

	PRINT 'DocumentTransitionHistory CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'Employee')
BEGIN
	CREATE TABLE dbo.Employee (
		[Id] [uniqueidentifier] NOT NULL,
		[FirstName] [nvarchar](256) NOT NULL,
		[LastName] [nvarchar](256) NULL,
		[MiddleName] [nvarchar](256) NULL,
		[Email] [nvarchar](256) NULL,
		[LocationId] [uniqueidentifier] NULL,
		[Groups] [nvarchar](max) NULL,
		[DepartmentId] [uniqueidentifier] NULL,
		[Title] [nvarchar](128) NULL,
		[SourceHire] [nvarchar](50) NULL,
		[DateJoin] [datetime] NULL,
		[SeatingLocation] [nvarchar](256) NULL,
		[Type] [nvarchar](50) NULL,
		[PhoneMobile] [nvarchar](50) NULL,
		[PhoneWork] [nvarchar](50) NULL,
		[OtherEmail] [nvarchar](50) NULL,
		[BirthDate] [datetime] NULL,
		[Skills] [nvarchar](256) NULL,
		[Address] [nvarchar](256) NULL,
		[State] [nvarchar](50) NULL,
		[Extensions] [nvarchar](max) NULL,
		[NumberId] [int] IDENTITY(1,1) NOT NULL,
		[Name] [nvarchar](128) NULL,
		[Rate] [money] NULL,
		[Salary] [money] NULL,
		[AverageTaxRate] [float] NULL,
		[DateLeft] [datetime] NULL,
		[IsLeft] [bit] NOT NULL DEFAULT(0),
		CONSTRAINT PK_Employee PRIMARY KEY (Id) 
	)

	PRINT 'Employee CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'EmployeeFiles')
BEGIN
	CREATE TABLE dbo.EmployeeFiles (
		[Id] [uniqueidentifier] NOT NULL,
		[EmployeeId] [uniqueidentifier] NOT NULL,
		[Token] [nvarchar](50) NULL,
		[Name] [nvarchar](256) NULL,
		[Size] [int] NULL,
		CONSTRAINT PK_EmployeeFiles PRIMARY KEY (Id),
		CONSTRAINT FK_EmployeeFiles_Employee FOREIGN KEY (EmployeeId) REFERENCES dbo.Employee (Id) ON DELETE CASCADE ON UPDATE CASCADE 
	)

	PRINT 'EmployeeFiles CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'EmployeeSalary')
BEGIN
	CREATE TABLE dbo.EmployeeSalary (
		[Id] [uniqueidentifier] NOT NULL,
		[EmployeeId] [uniqueidentifier] NULL,
		[DateFrom] [datetime] NULL,
		[DateTo] [datetime] NULL,
		[Salary] [money] NULL,
		[Rate] [money] NULL,
		[AverageTaxRate] [float] NULL,
		CONSTRAINT PK_EmployeeSalary PRIMARY KEY (Id),
		CONSTRAINT FK_EmployeeSalary_Employee FOREIGN KEY (EmployeeId) REFERENCES dbo.Employee (Id) ON DELETE CASCADE ON UPDATE CASCADE 
	)

	PRINT 'EmployeeSalary CREATE TABLE'
END

IF NOT EXISTS (SELECT 1 FROM [INFORMATION_SCHEMA].[TABLES] WHERE [TABLE_NAME] = N'InvitationLetter')
BEGIN
	CREATE TABLE dbo.InvitationLetter (
		[Id] [uniqueidentifier] NOT NULL,
		[Date] [datetime] NOT NULL,
		[DateExpired] [datetime] NOT NULL,
		[EmployeeId] [uniqueidentifier] NOT NULL,
		CONSTRAINT PK_InvitationLetter PRIMARY KEY (Id)
	)

	PRINT 'InvitationLetter CREATE TABLE'
END

COMMIT TRANSACTION