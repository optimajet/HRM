/*
Company: OptimaJet
Project: DWKit HRM
File: CreateObjects.sql
*/

begin;

CREATE TABLE IF NOT EXISTS "Department"
(
  "Id" uuid NOT NULL,
  "Name" character varying(256) NOT null,
  CONSTRAINT "Department_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "Location"
(
  "Id" uuid NOT NULL,
  "Name" character varying(256) NOT NULL,
  "Phone" character varying(256) NOT NULL,
  "Address" character varying(256) NOT null,
  CONSTRAINT "Location_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "Document"
(
  "Id" uuid NOT NULL,
  "NumberId" SERIAL NOT NULL,
  "Date" date NULL,
  "LastUpdatedDate" date NULL,
  "Type" character varying(50) NOT NULL,
  "Name" character varying(256) NOT NULL,
  "AuthorId" uuid NOT NULL,
  "ManagerId"  uuid NULL,
  "Comment" character varying(1024) NULL,
  "Extensions" jsonb NULL,
  "State" character varying(256) NOT NULL DEFAULT 'Draft',
  "Amount" numeric NOT NULL DEFAULT 0::numeric,
  "LastUpdatedEmployeeId" uuid NULL,
  CONSTRAINT "Document_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "DocumentFiles"
(
  "Id" uuid NOT NULL,
  "DocumentId" uuid NOT NULL REFERENCES "Document" ON DELETE CASCADE,
  "Token" character varying(50) NULL,
  "Name" character varying(256) NULL,
  "Size" int NULL,
  CONSTRAINT "DocumentFiles_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "DocumentTransitionHistory"
(
  "Id" uuid NOT NULL,
  "DocumentId" uuid NOT NULL REFERENCES "Document" ON DELETE CASCADE,
  "EmployeeId" uuid NULL REFERENCES "dwSecurityUser",
  "AllowedToEmployeeNames" character varying(1024) NULL,
  "TransitionTime" date NULL,
  "Order" SERIAL NOT NULL,
  "InitialState" character varying(256) NOT NULL,
  "DestinationState" character varying(256) NOT NULL,
  "Command" character varying(1024) NOT NULL,
  CONSTRAINT "DocumentTransitionHistory_pkey" PRIMARY KEY ("Id")
);


CREATE TABLE IF NOT EXISTS "Employee"
(
  "Id" uuid NOT NULL,
  "FirstName" character varying(256) NOT NULL,
  "LastName" character varying(256) NULL,
  "MiddleName" character varying(256) NULL,
  "Name" character varying(256) NOT NULL,
  "NumberId" SERIAL NOT NULL,
  "Email" character varying(256) NULL,
  "LocationId" uuid NULL REFERENCES "Location",
  "Groups" text NULL,
  "DepartmentId" uuid NULL REFERENCES "Department",
  "Title" character varying(128) NULL,
  "SourceHire" character varying(50) NULL,
  "DateJoin" date NULL,
  "SeatingLocation" character varying(50) NULL,
  "Type" character varying(50) NULL,
  "PhoneMobile" character varying(50) NULL,
  "PhoneWork" character varying(50) NULL,
  "OtherEmail" character varying(50) NULL,
  "BirthDate" date NULL,
  "Skills" character varying(256) NULL,
  "Address" character varying(256) NULL,
  "State" character varying(50) NULL,
  "Rate" numeric NULL,
  "Salary" numeric NULL,
  "AverageTaxRate" float NULL,
  "DateLeft" date NULL,
  "IsLeft" boolean NOT NULL DEFAULT 0::boolean,
  "Extensions" jsonb NULL,
  CONSTRAINT "Employee_pkey" PRIMARY KEY ("Id")
);


CREATE TABLE IF NOT EXISTS "EmployeeFiles"
(
  "Id" uuid NOT NULL,
  "EmployeeId" uuid NOT NULL REFERENCES "Employee" ON DELETE CASCADE,
  "Token" character varying(50) NULL,
  "Name" character varying(256) NULL,
  "Size" int NULL,
  CONSTRAINT "EmployeeFiles_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "EmployeeSalary"
(
  "Id" uuid NOT NULL,
  "EmployeeId" uuid NULL REFERENCES "Employee" ON DELETE CASCADE,
  "DateFrom" date NULL,
  "DateTo" date NULL,
  "Salary" numeric NULL,
  "Rate" numeric NULL,
  "AverageTaxRate" float NULL,
  CONSTRAINT "EmployeeSalary_pkey" PRIMARY KEY ("Id")
);

CREATE TABLE IF NOT EXISTS "InvitationLetter"
(
  "Id" uuid NOT NULL,
  "Date" date NOT NULL,
  "DateExpired" date NOT NULL,
  "EmployeeId" uuid NOT NULL,
  CONSTRAINT "InvitationLetter_pkey" PRIMARY KEY ("Id")
);

COMMIT;