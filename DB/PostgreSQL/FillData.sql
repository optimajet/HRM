/*
Company: OptimaJet
Project: DWKit HRM
File: FillData.sql
*/

BEGIN;

UPDATE "dwAppSettings" SET "Value" = 'DWKit HRM' WHERE "Name" = 'ApplicationName';
UPDATE "dwAppSettings" SET "Value" = 'Human resource management' WHERE "Name" = 'ApplicationDesc';

DO $AppSettingsValueMailServer$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM "dwAppSettings" WHERE "Name" = N'MailServer') THEN
		INSERT INTO "dwAppSettings" ("Name","GroupName","ParamName","Value","Order","EditorType","IsHidden") VALUES ('MailServer','Mail','Mail Server','',0,'0',false::boolean);
	END IF;
END $AppSettingsValueMailServer$;

DO $AppSettingsValueMailServerPort$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM "dwAppSettings" WHERE "Name" = N'MailServerPort') THEN
		INSERT INTO "dwAppSettings" ("Name","GroupName","ParamName","Value","Order","EditorType","IsHidden") VALUES ('MailServerPort','Mail','Mail Server Port','',1,'0',false::boolean);
	END IF;
END $AppSettingsValueMailServerPort$;

DO $AppSettingsValueMailServerLogin$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM "dwAppSettings" WHERE "Name" = N'MailServerLogin') THEN
		INSERT INTO "dwAppSettings" ("Name","GroupName","ParamName","Value","Order","EditorType","IsHidden") values('MailServerLogin','Mail','Mail Login','',2,'0', false::boolean);
	END IF;
END $AppSettingsValueMailServerLogin$;

DO $AppSettingsValueMailServerPass$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM "dwAppSettings" WHERE "Name" = N'MailServerPass') THEN
		INSERT INTO "dwAppSettings" ("Name","GroupName","ParamName","Value","Order","EditorType","IsHidden") VALUES('MailServerPass', 'Mail', 'Mail Password','',3,'password', false::boolean);
	END IF;
END $AppSettingsValueMailServerPass$;



DO $AppSettingsValueMailServerSsl$
BEGIN
	IF NOT EXISTS(SELECT 1 FROM "dwAppSettings" WHERE "Name" = N'MailServerSsl') THEN
		INSERT INTO "dwAppSettings" ("Name","GroupName","ParamName","Value","Order","EditorType","IsHidden") VALUES('MailServerSsl', 'Mail','EnableSsl','',4,'checkbox',false::boolean );
	END IF;
END $AppSettingsValueMailServerSsl$;


INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('8d378ebe-0666-46b3-b7ab-1a52480fd12a', 'Big Boss', 'BigBoss');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('412174c2-0490-4101-a7b3-830de90bcaa0', 'Accountant', 'Accountant');

--Department
INSERT INTO "Department"("Id", "Name") VALUES ('517E56DB-70BA-407D-94AF-07592A48F9E2','Marketing');
INSERT INTO "Department"("Id", "Name") VALUES ('DA5A99E4-EFE1-442A-9252-40FB0C292AFF','Support');
INSERT INTO "Department"("Id", "Name") VALUES ('0D3BE843-D004-4028-B014-6DFB24C4DFFD','Research & Development');
INSERT INTO "Department"("Id", "Name") VALUES ('CC566598-44D8-4041-B036-7F59DE8C2B45','Sales');
INSERT INTO "Department"("Id", "Name") VALUES ('9E127B8E-D908-46B8-8D3C-DE13E58AAD7D','Other');
INSERT INTO "Department"("Id", "Name") VALUES ('CAA0EF91-E138-4941-954E-E374555C2CA8','Accounting');
INSERT INTO "Department"("Id", "Name") VALUES ('94CE73CF-6339-4C19-95C8-E6505DF41BCA','Head office');

--Location
INSERT INTO "Location"("Id", "Name", "Phone", "Address") VALUES ('B95B5AD6-E7EF-44C6-AD86-2B34E917E472','New York','','350 5th Ave, New York, NY 10118, USA');
INSERT INTO "Location"("Id", "Name", "Phone", "Address") VALUES ('7A7DAF57-B113-4817-8BCD-300859FD23CB','Paris','','7 Rue du Port aux Vins, 92150 Suresnes, France');
INSERT INTO "Location"("Id", "Name", "Phone", "Address") VALUES ('E1AABDDE-67E6-4AE1-922F-93985871E5F9','London','','Parliament Square, Westminster, St Margaret Street, London, UK');
INSERT INTO "Location"("Id", "Name", "Phone", "Address") VALUES ('EA4C30E4-A9EB-4145-B7E6-AF8F0392A474','Mumbai','','Cumballa Hill, Mumbai 400026, India ');
INSERT INTO "Location"("Id", "Name", "Phone", "Address") VALUES ('E450F591-86B0-49BB-BEAE-E82236A9F61E','Helsinki','','Lentajantie 3, 01530 Vantaa');

--Permissions
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('FF58997F-C00C-A368-A1A4-40BFD23BEB17', 'Employee', 'Employee');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('48AF1B62-F075-804F-CDB6-5A9ED161DEB8', 'Dashboard', 'Dashboard');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('EAC8C80F-D756-90AC-49BD-B074C60A46A1', 'Settings', 'Settings');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('9E843F67-8A70-D824-60C4-B9D39D4DDCFC', 'Work Calendar', 'WorkCalendar');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('1F676FC7-31EF-4496-B885-BF85ACE3BEEF', 'Workflow Report', 'WorkflowReport');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('B533C5D5-342B-35E0-A31E-D3AB1BEA68A2', 'Employee Report', 'EmployeeReport');
INSERT INTO "dwSecurityPermissionGroup"("Id", "Name", "Code") VALUES('747B671E-BC50-F7E1-A03C-E824B43DA116', 'Documents', 'Documents');

INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('C9433C9C-B91B-5BF5-7AD3-11B4E74225DE','Edit','Edit','FF58997F-C00C-A368-A1A4-40BFD23BEB17');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('0A474F49-4358-75D3-23E9-2C58A2E52B99','ViewSalary','View Salary','FF58997F-C00C-A368-A1A4-40BFD23BEB17');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('F40201AF-82F8-DF2C-A225-D8A08F1DF0F2','EditSalary','Edit Salary','FF58997F-C00C-A368-A1A4-40BFD23BEB17');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('2CC300B6-DAE2-F001-9DA8-D981FDD76C4C','View','View','FF58997F-C00C-A368-A1A4-40BFD23BEB17');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('2133CA46-BF49-4AD9-6456-99413EE1F77A','ViewCompanyInfo','View Company Informantion','48AF1B62-F075-804F-CDB6-5A9ED161DEB8');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('3A40C375-66DF-181D-05F7-3DBFFF750C87','View','View','48AF1B62-F075-804F-CDB6-5A9ED161DEB8');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('27C57A7A-CD79-3A02-C06D-1B3838B5E991','View','View','EAC8C80F-D756-90AC-49BD-B074C60A46A1');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('A61D971B-1AD8-E2A0-0EAA-9CA079D72B93','Edit','Edit','EAC8C80F-D756-90AC-49BD-B074C60A46A1');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('8452FF28-C3BB-9C57-D43B-191FFF4AE7AE','View','View','9E843F67-8A70-D824-60C4-B9D39D4DDCFC');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('3E261715-090D-00FA-9C96-3A981BF630F0','Edit','Edit','9E843F67-8A70-D824-60C4-B9D39D4DDCFC');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('8274BED7-9826-4ECA-A2BE-87875021D85F','View','View','1F676FC7-31EF-4496-B885-BF85ACE3BEEF');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('745CDB96-3025-E096-8B7C-EE6B40B7684C','Edit','Edit','1F676FC7-31EF-4496-B885-BF85ACE3BEEF');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('94AF1D8D-111F-EF9D-3161-4DE5B33DCEF1','Edit','Edit','B533C5D5-342B-35E0-A31E-D3AB1BEA68A2');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('AEAF1F1A-FE45-4182-D1F0-14E0D4CCCD9C','View','View','B533C5D5-342B-35E0-A31E-D3AB1BEA68A2');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('FA25313E-FD34-CA33-536D-17FDE9EC9DBE','Edit','Edit','747B671E-BC50-F7E1-A03C-E824B43DA116');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('89063D97-D679-86CC-5403-E5475E6D93C5','ViewAll','ViewAll','747B671E-BC50-F7E1-A03C-E824B43DA116');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('DC6247C5-C90B-7205-8C91-B4AA943891F5','View','View','747B671E-BC50-F7E1-A03C-E824B43DA116');
INSERT INTO "dwSecurityPermission"("Id", "Code", "Name", "GroupId") VALUES ('6ECD53CB-0709-130D-D9B0-C3DE6DD9CEB7','SetState','SetState','747B671E-BC50-F7E1-A03C-E824B43DA116');

--Roles
insert INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('955625EF-5DAF-F133-2275-12813908312D', N'Users', N'Users');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('D0E0B7BE-5D69-8AB6-3261-1F922875DFF9', N'Accountants', N'Accountants');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('8B6CB071-3275-00C2-D315-976151BE935B', N'Directors', N'Directors');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('E826DC76-A231-4AC4-9D40-A103395D62B8', N'HR Managers', N'HR Managers');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7', N'HR Directors', N'HR Directors');
INSERT INTO "dwSecurityRole"("Id", "Code", "Name") VALUES ('DD266FD4-C0B5-D53C-EEA2-F57935F3E4D7', N'Managers', N'Managers');

INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('944DFD3C-FE61-49BB-896C-07459C0AEB83','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('380A91F8-4B38-416C-B0C6-0E5C803478A3','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','F40201AF-82F8-DF2C-A225-D8A08F1DF0F2',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('2B5ED255-CCBD-45B8-8B6B-1097A2B4F7E5','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('048FE086-4611-4772-80A4-12BADFD8C980','DD266FD4-C0B5-D53C-EEA2-F57935F3E4D7','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('4D369096-8DF4-42CA-AC1B-1B186C35CCF4','E826DC76-A231-4AC4-9D40-A103395D62B8','AEAF1F1A-FE45-4182-D1F0-14E0D4CCCD9C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('B684C77E-B84E-419F-9018-1FB3814FFE0B','E826DC76-A231-4AC4-9D40-A103395D62B8','8274BED7-9826-4ECA-A2BE-87875021D85F',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('B6D97CDE-45B3-4291-9F77-215B08DA9602','8B6CB071-3275-00C2-D315-976151BE935B','F40201AF-82F8-DF2C-A225-D8A08F1DF0F2',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('4356222E-B5E8-4A68-B5F1-22B7DD6F2EC2','955625EF-5DAF-F133-2275-12813908312D','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('F7C6F0E6-4984-4D04-B43E-299EFFCE8E46','E826DC76-A231-4AC4-9D40-A103395D62B8','2133CA46-BF49-4AD9-6456-99413EE1F77A',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('03C3E1E2-65E1-4568-A4C0-2D9FB4874C4D','8B6CB071-3275-00C2-D315-976151BE935B','6ECD53CB-0709-130D-D9B0-C3DE6DD9CEB7',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8BEA7590-2353-4C57-A708-2F4DF5ED7D63','E826DC76-A231-4AC4-9D40-A103395D62B8','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('FEA14D75-BFEB-47DB-BFB0-3484AD6DAF31','1B7F60C8-D860-4510-8E71-5469FC1814D3','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('FFB968AF-5FE0-4F21-A083-3637DEC78E11','955625EF-5DAF-F133-2275-12813908312D','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('DC93B454-E208-4883-AEEF-36B1A5C7DB75','955625EF-5DAF-F133-2275-12813908312D','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A88F1FF1-3727-44A7-804F-3793180CD877','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('41CB3935-A1BB-4010-A412-389D901837F3','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('74B68EEA-775D-4B2C-964D-39BC0619E0A8','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','8274BED7-9826-4ECA-A2BE-87875021D85F',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('2B256014-31C7-4062-B1A6-3A5579DF8A3E','1B7F60C8-D860-4510-8E71-5469FC1814D3','0A474F49-4358-75D3-23E9-2C58A2E52B99',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8E8EF711-EB92-4CF9-8512-3F118C507933','8B6CB071-3275-00C2-D315-976151BE935B','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('9A1F0769-12D8-4FC2-B04A-3F69C96DA71E','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','27C57A7A-CD79-3A02-C06D-1B3838B5E991',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('C90A1EC7-F107-40FA-A553-427E61741344','E826DC76-A231-4AC4-9D40-A103395D62B8','27C57A7A-CD79-3A02-C06D-1B3838B5E991',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('77DB9901-4C0E-47E0-BBD5-4991E6F3D198','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','0A474F49-4358-75D3-23E9-2C58A2E52B99',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A8D0BB81-E8FA-4C03-B7FC-49A73FFFF93B','1B7F60C8-D860-4510-8E71-5469FC1814D3','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('73464BA9-3EBA-4458-8891-4D46C106B96A','E826DC76-A231-4AC4-9D40-A103395D62B8','94AF1D8D-111F-EF9D-3161-4DE5B33DCEF1',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5148FBDB-D406-4CA2-A19E-50A692B51D11','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8E19AEA1-BEBF-4F13-A579-52F12DC48670','8B6CB071-3275-00C2-D315-976151BE935B','0A474F49-4358-75D3-23E9-2C58A2E52B99',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('1C4D2CAE-225F-4A9D-B015-5408BCA4BB8F','1B7F60C8-D860-4510-8E71-5469FC1814D3','89063D97-D679-86CC-5403-E5475E6D93C5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('3509029B-3822-4619-B91A-5636E7704319','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','F40201AF-82F8-DF2C-A225-D8A08F1DF0F2',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('3B349B46-05C9-43C7-9DCE-58A8748B103F','955625EF-5DAF-F133-2275-12813908312D','89063D97-D679-86CC-5403-E5475E6D93C5',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('DCB81CA9-BF67-4182-9EB4-5E331098E85D','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','2133CA46-BF49-4AD9-6456-99413EE1F77A',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('4182A768-2440-42E6-902D-5F634BA803A5','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','AEAF1F1A-FE45-4182-D1F0-14E0D4CCCD9C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5F247DF6-DB56-48AF-9424-62839B679C08','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','2133CA46-BF49-4AD9-6456-99413EE1F77A',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('31808BD9-2243-4B3A-9973-67EEC05F5329','E826DC76-A231-4AC4-9D40-A103395D62B8','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('2C383C9D-BA9C-4B77-B934-6C644CFC2B47','1B7F60C8-D860-4510-8E71-5469FC1814D3','3E261715-090D-00FA-9C96-3A981BF630F0',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('7DF079BD-EC35-4AAE-A903-6FA847D43286','1B7F60C8-D860-4510-8E71-5469FC1814D3','6ECD53CB-0709-130D-D9B0-C3DE6DD9CEB7',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('12171E5A-E66C-4F8E-A320-71E707B59D8C','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('02CEB496-6A7A-46C1-8A54-7642072B82C9','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('33BDB9AD-0F87-4E72-9B1C-7713D916A64F','8B6CB071-3275-00C2-D315-976151BE935B','89063D97-D679-86CC-5403-E5475E6D93C5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('29BC2D94-DA3D-4701-927C-7BF18D03DB0E','E826DC76-A231-4AC4-9D40-A103395D62B8','89063D97-D679-86CC-5403-E5475E6D93C5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('97C40000-7336-4F04-A0BF-7C4E94113A5B','8B6CB071-3275-00C2-D315-976151BE935B','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A0BCDFC7-AD8C-42E1-AE75-7D756FCD8E03','E826DC76-A231-4AC4-9D40-A103395D62B8','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('AE1DD154-3095-4B82-8F00-7F07E40D04DA','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','27C57A7A-CD79-3A02-C06D-1B3838B5E991',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('C2D5833A-D9B3-42FF-A03A-8694B26DD28B','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','3E261715-090D-00FA-9C96-3A981BF630F0',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('9CAC9766-47BE-4874-A2BD-8977025A6CB7','1B7F60C8-D860-4510-8E71-5469FC1814D3','94AF1D8D-111F-EF9D-3161-4DE5B33DCEF1',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('AB2F09D9-4FAD-46C0-97BC-8A169C6D68CB','E826DC76-A231-4AC4-9D40-A103395D62B8','A61D971B-1AD8-E2A0-0EAA-9CA079D72B93',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('1909570A-F804-42A6-AD9E-93DD3F8624A6','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','0A474F49-4358-75D3-23E9-2C58A2E52B99',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('55008D4C-C59E-486D-BFE4-94E39EC66F86','1B7F60C8-D860-4510-8E71-5469FC1814D3','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('6AFC3ED1-EDBF-4DA8-93B2-962ECB51D7ED','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8DF58B94-F36D-4194-9025-9635F2F99314','E826DC76-A231-4AC4-9D40-A103395D62B8','0A474F49-4358-75D3-23E9-2C58A2E52B99',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('B23D34ED-68E4-4DD1-B5DD-9811EB619EB8','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','745CDB96-3025-E096-8B7C-EE6B40B7684C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('78571B2A-192E-42AB-B615-98A9B79CF737','1B7F60C8-D860-4510-8E71-5469FC1814D3','745CDB96-3025-E096-8B7C-EE6B40B7684C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('83097B51-01DF-4F8B-AC7D-9B22AD7CD4A3','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','6ECD53CB-0709-130D-D9B0-C3DE6DD9CEB7',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('7A0107CD-56C7-4112-BC4E-A18BCC7CAF5F','1B7F60C8-D860-4510-8E71-5469FC1814D3','8274BED7-9826-4ECA-A2BE-87875021D85F',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('F2847C9B-B7EC-4D42-AE07-A2898ABA7818','1B7F60C8-D860-4510-8E71-5469FC1814D3','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('507170CC-9CD2-4BF0-8AE8-A74828466F06','1B7F60C8-D860-4510-8E71-5469FC1814D3','F40201AF-82F8-DF2C-A225-D8A08F1DF0F2',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('77D318F1-B2B5-4B60-B4B9-A893A554B088','E826DC76-A231-4AC4-9D40-A103395D62B8','745CDB96-3025-E096-8B7C-EE6B40B7684C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A2CC79DA-4238-4EA1-AEFD-A991A0A0536B','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','89063D97-D679-86CC-5403-E5475E6D93C5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8A3F114A-2F32-4482-9B40-AC807A334C41','1B7F60C8-D860-4510-8E71-5469FC1814D3','A61D971B-1AD8-E2A0-0EAA-9CA079D72B93',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('674D9EB9-0712-462A-BB27-ACB9D031BDD0','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('17E5C5F0-83C4-4D39-859D-ADA9A9EA70D9','955625EF-5DAF-F133-2275-12813908312D','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('6D47D6E6-8E86-4912-9CC7-ADB12A6CC064','E826DC76-A231-4AC4-9D40-A103395D62B8','3E261715-090D-00FA-9C96-3A981BF630F0',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5022E1C4-F94F-41B7-BCCC-AEF5B5CBB76A','1B7F60C8-D860-4510-8E71-5469FC1814D3','AEAF1F1A-FE45-4182-D1F0-14E0D4CCCD9C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('8B728880-22FC-4793-8CF0-B25A61B374D1','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','3A40C375-66DF-181D-05F7-3DBFFF750C87',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('9E9E198C-712F-42E8-AC24-B3C270FA1DB8','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('B4B2161C-7A19-4032-A3D1-B3F3755FF335','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','AEAF1F1A-FE45-4182-D1F0-14E0D4CCCD9C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('4C0F175E-EF84-444A-ACF5-B78E30F554D0','955625EF-5DAF-F133-2275-12813908312D','3E261715-090D-00FA-9C96-3A981BF630F0',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('25B15836-7141-4A5C-B43C-B98F75AC36A7','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','8274BED7-9826-4ECA-A2BE-87875021D85F',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5FE6A31D-A48F-409B-B3C3-BF02371D84F2','E826DC76-A231-4AC4-9D40-A103395D62B8','6ECD53CB-0709-130D-D9B0-C3DE6DD9CEB7',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A2670B84-9E9E-4026-95FA-C0C4D9FF12B6','E826DC76-A231-4AC4-9D40-A103395D62B8','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('BCB3158E-1C21-4FCF-B695-C25C1F7464DA','8B6CB071-3275-00C2-D315-976151BE935B','27C57A7A-CD79-3A02-C06D-1B3838B5E991',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5091DC82-1331-4BAF-98F1-D6FDDD8BA3AA','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','94AF1D8D-111F-EF9D-3161-4DE5B33DCEF1',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('FA8D4E0C-E931-4D51-A28C-DAB4959740D2','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','C9433C9C-B91B-5BF5-7AD3-11B4E74225DE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('01CD2123-AD0A-46ED-9CF6-DC633C732CD5','E826DC76-A231-4AC4-9D40-A103395D62B8','F40201AF-82F8-DF2C-A225-D8A08F1DF0F2',0);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('D0CD8398-7075-4F26-967B-DD071DE338B2','1B7F60C8-D860-4510-8E71-5469FC1814D3','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('76963786-01E6-4C44-B873-DE884D797B38','E826DC76-A231-4AC4-9D40-A103395D62B8','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('0E684AEB-462A-4453-93B7-E0BDCEC0E6A4','1B7F60C8-D860-4510-8E71-5469FC1814D3','2133CA46-BF49-4AD9-6456-99413EE1F77A',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('B0EDAE21-EAC0-4BAF-A4D4-E122AB93D2CB','1B7F60C8-D860-4510-8E71-5469FC1814D3','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('9DD2678F-CCB4-4943-8C0D-E63B35FD6E7C','1B7F60C8-D860-4510-8E71-5469FC1814D3','27C57A7A-CD79-3A02-C06D-1B3838B5E991',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('9876D0AD-6D42-4630-A3C5-E79E8742A95C','8B6CB071-3275-00C2-D315-976151BE935B','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('DF61D2F5-10C0-425F-9827-EAE321A836CB','8B6CB071-3275-00C2-D315-976151BE935B','DC6247C5-C90B-7205-8C91-B4AA943891F5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('967F103B-FE48-4765-B7AC-EDF6219B3404','8B6CB071-3275-00C2-D315-976151BE935B','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('34716489-C22A-4143-ACA3-F1B7AE98863F','955625EF-5DAF-F133-2275-12813908312D','FA25313E-FD34-CA33-536D-17FDE9EC9DBE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('5B1B7267-1E1B-4F1A-8E32-F3A7F54ADF63','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','A61D971B-1AD8-E2A0-0EAA-9CA079D72B93',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('586EBD61-3DC5-42D0-B920-F56851E878F4','955625EF-5DAF-F133-2275-12813908312D','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('A26486D7-87E9-49D1-9DDE-F71448458ADF','8B6CB071-3275-00C2-D315-976151BE935B','2CC300B6-DAE2-F001-9DA8-D981FDD76C4C',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('6AB8D00E-24A5-4D7A-A367-FC431B504FA5','8B6CB071-3275-00C2-D315-976151BE935B','3E261715-090D-00FA-9C96-3A981BF630F0',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('2FC1EC67-674A-4983-8443-FCF384BDA291','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','89063D97-D679-86CC-5403-E5475E6D93C5',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('02B120DB-4A02-4A5E-892F-FD0B1A262132','E826DC76-A231-4AC4-9D40-A103395D62B8','8452FF28-C3BB-9C57-D43B-191FFF4AE7AE',1);
INSERT INTO "dwSecurityRoleToSecurityPermission"("Id", "SecurityRoleId", "SecurityPermissionId", "AccessType") VALUES ('79F8CACA-D876-407A-88D6-FFA030459B27','8B6CB071-3275-00C2-D315-976151BE935B','2133CA46-BF49-4AD9-6456-99413EE1F77A',1);

--Users
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('540E514C-911F-4A03-AC90-C450C28838C5','Admin','Admin', '2018-01-01', NULL);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('F354C02D-963E-46C0-BEE6-B3DE1417385F','HR Director','HR Director', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('C9E3717C-0C31-4270-B49B-FA3C94CBD081','HR Manager','HR Manager', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('44A58535-CE41-4679-AC5B-90C1BCB3E4A2','Director','Director', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('3634F5B0-3A56-405F-9143-D49E36229AAA','Accountant','Accountant', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('E342A33E-00B1-4B9D-BE9C-0CC2BE32FD45','User 1','User 1', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('FAAFDE15-2954-4D77-B635-14649DF6454A','User 2','User 2', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('AFECCF3E-03AB-45BB-854B-90A669AC9651','User 3','User 3', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('FF9C702F-06D8-4825-9B16-CEDCFEAB895C','User 4','User 4', '2018-01-01', 1000);
INSERT INTO "Employee"("Id", "FirstName", "Name", "DateJoin", "Salary") VALUES ('0A0C67B1-38A1-4E9F-88AA-E180E547EE8A','User 5','User 5', '2018-01-01', 1000);

INSERT INTO "dwSecurityUser"("Id", "Name") SELECT "Id", "Name" FROM "Employee" WHERE "Id" != '540E514C-911F-4A03-AC90-C450C28838C5';

INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('BD1F6FFE-61A7-4FC8-8FC6-1EB86A7D2E93','2zmR7hMVa+Etmk/fFxV+kFzG5iw=','DBV9DiqeTSIVGZWxrWWMbA==','44A58535-CE41-4679-AC5B-90C1BCB3E4A2','director','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('9315E400-9D1D-4778-B7D8-6622EE1E94BB','Zid+M5oAUbuYuyjWIeAnWBwVwG4=','CUpg3B+ods4JVw5pSwEkqQ==','F354C02D-963E-46C0-BEE6-B3DE1417385F','hrdirector','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('6BEAEE4D-32A0-4786-BD4F-818547237CAD','JPjPyS7qKXUP2b4EJoxwQvEp1JM=','mk1UlR6swDnVqcZQcD/z+g==','C9E3717C-0C31-4270-B49B-FA3C94CBD081','manager','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('5236F155-79E0-42F8-AA22-C51ACDAC830E','4l9+s5ENRXW01N0oZeiwuIlROe4=','bKO78tzpFQQlEB5n8ZBRVw==','E342A33E-00B1-4B9D-BE9C-0CC2BE32FD45','user1','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('ED4C6821-7266-4780-84EC-2EED9EAD0F6C','F9JezvQqscMiLLw9v+ztP/jD8sk=','DLAAXHJcLbQ+JUpdIyNJmg==','FF9C702F-06D8-4825-9B16-CEDCFEAB895C','user2','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('02BD0858-FA48-48EC-BBC1-9E862EDBDA3E','rS5I94OIvwTfEEELS+hrJVw/W7Q=','4VVRWKUTnqeH9rCw6LVHgQ==','AFECCF3E-03AB-45BB-854B-90A669AC9651','user3','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('81D9AF3C-0541-4DD9-86FF-3C24BEEFBB9B','6v70HUcKJkVDfKhmmmmGZzRqS0Q=','xHB/K2KPjwLFryIhE6e6IQ==','FAAFDE15-2954-4D77-B635-14649DF6454A','user4','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('14324B96-25D0-456C-B5E5-0821883107C2','0VqC5LzO8EUtLqIx1Gf0k65gAI0=','v0gwdspvtOYDzNkzq1IUtg==','0A0C67B1-38A1-4E9F-88AA-E180E547EE8A','user5','0');
INSERT INTO "dwSecurityCredential"("Id", "PasswordHash", "PasswordSalt", "SecurityUserId", "Login", "AuthenticationType") VALUES ('FE43192E-AA51-4D28-A4CC-6268224D0837','Mvu3tZiE+Vz0emwCD7JpNpM+P/E=','Bw6A2G6KQkKgmTmIKhvOCw==','3634F5B0-3A56-405F-9143-D49E36229AAA','accountant','0');

INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('DF3E8935-70A9-4892-9033-5ACC3DBF7A45','955625EF-5DAF-F133-2275-12813908312D','E342A33E-00B1-4B9D-BE9C-0CC2BE32FD45');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('54E84F68-03C8-4AF2-82C5-63A45C27CAF8','DD266FD4-C0B5-D53C-EEA2-F57935F3E4D7','E342A33E-00B1-4B9D-BE9C-0CC2BE32FD45');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('1F67DDD7-9EF1-4B59-B8B6-2A08DA66B444','955625EF-5DAF-F133-2275-12813908312D','FAAFDE15-2954-4D77-B635-14649DF6454A');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('D3308884-9A35-4579-A0CF-54D26F96C5E6','955625EF-5DAF-F133-2275-12813908312D','AFECCF3E-03AB-45BB-854B-90A669AC9651');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('99A9FA5B-A3E6-4DD8-8352-0E36497C345B','955625EF-5DAF-F133-2275-12813908312D','44A58535-CE41-4679-AC5B-90C1BCB3E4A2');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('D2997389-1439-44E4-A95D-F34622E0931B','8B6CB071-3275-00C2-D315-976151BE935B','44A58535-CE41-4679-AC5B-90C1BCB3E4A2');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('CFBF4D1A-437F-4F8E-86BC-45A18A1C2605','E81B6727-1143-7E6A-1AFD-EEBA8D09A1A7','F354C02D-963E-46C0-BEE6-B3DE1417385F');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('2AEE31B3-B719-4EA9-99DA-7963C6C95B1F','955625EF-5DAF-F133-2275-12813908312D','F354C02D-963E-46C0-BEE6-B3DE1417385F');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('8191F714-3AC7-49AA-B0A7-C6D74193FADF','955625EF-5DAF-F133-2275-12813908312D','FF9C702F-06D8-4825-9B16-CEDCFEAB895C');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('0DC71D36-10CE-40ED-A13D-C509C3780AC1','955625EF-5DAF-F133-2275-12813908312D','0A0C67B1-38A1-4E9F-88AA-E180E547EE8A');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('3401605F-3660-4C02-B456-ED70559A1E5F','955625EF-5DAF-F133-2275-12813908312D','C9E3717C-0C31-4270-B49B-FA3C94CBD081');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('B2F3554C-EB0A-424C-8224-EDD3B09502E9','E826DC76-A231-4AC4-9D40-A103395D62B8','C9E3717C-0C31-4270-B49B-FA3C94CBD081');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('F5F365F3-19D7-4CBF-8F15-45D2548C6524','D0E0B7BE-5D69-8AB6-3261-1F922875DFF9','3634F5B0-3A56-405F-9143-D49E36229AAA');
INSERT INTO "dwSecurityUserToSecurityRole"("Id", "SecurityRoleId", "SecurityUserId") VALUES ('F755A8DF-18B9-435C-8A60-7F3FD4AA0155','955625EF-5DAF-F133-2275-12813908312D','3634F5B0-3A56-405F-9143-D49E36229AAA');

--WorkflowScheme
INSERT INTO "WorkflowScheme"("Code", "Scheme") VALUES ('BusinessTrip', '
<Process>
  <Designer />
  <Actors>
    <Actor Name="Author" Rule="IsDocumentAuthor" Value="" />
    <Actor Name="Manager" Rule="IsAuthorManager" Value="" />
    <Actor Name="HR Manager" Rule="CheckRole" Value="HR Managers" />
    <Actor Name="HR Director" Rule="CheckRole" Value="HR Directors" />
    <Actor Name="Director" Rule="CheckRole" Value="Directors" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountants" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Start" />
    <Command Name="Approve" />
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To HR Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
  </Commands>
  <Activities>
    <Activity Name="Draft" State="Draft" IsInitial="True" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="140" />
    </Activity>
    <Activity Name="ManagerSigning" State="ManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="320" Y="140" />
    </Activity>
    <Activity Name="HRManagerSigning" State="HRManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="620" Y="140" />
    </Activity>
    <Activity Name="HRDirectorSigning" State="HRDirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="540" Y="360" />
    </Activity>
    <Activity Name="DirectorSigning" State="DirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="630" Y="480" />
    </Activity>
    <Activity Name="Approved" State="Approved" IsInitial="False" IsFinal="True" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="340" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="Draft_Activity_1_1" To="ManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
        <Restriction Type="Restrict" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="CheckNoneAuthorManager" ConditionInversion="true" />
      </Conditions>
      <Designer X="268" Y="182" />
    </Transition>
    <Transition Name="ManagerSigning_Activity_1_1" To="HRManagerSigning" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="563" Y="156" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_1" To="DirectorSigning" From="HRDirectorSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="777" Y="404" />
    </Transition>
    <Transition Name="DirectorSigning_Activity_1_1" To="Approved" From="DirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="383" Y="429" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_2" To="Approved" From="HRDirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="385" Y="371" />
    </Transition>
    <Transition Name="ManagerSigning_Draft_1" To="Draft" From="ManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="268" Y="120" />
    </Transition>
    <Transition Name="HRManagerSigning_ManagerSigning_1" To="Draft" From="HRManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="425" Y="72" />
    </Transition>
    <Transition Name="HRDirectorSigning_HRManagerSigning_1" To="HRManagerSigning" From="HRDirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="748" Y="280" />
    </Transition>
    <Transition Name="HRManagerSigning_Approved_1" To="Approved" From="HRManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="644" Y="279" />
    </Transition>
    <Transition Name="HRManagerSigning_HRDirectorSigning_1" To="HRDirectorSigning" From="HRManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To HR Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="694" Y="279" />
    </Transition>
    <Transition Name="DirectorSigning_HRManagerSigning_1" To="HRManagerSigning" From="DirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="803" Y="279" />
    </Transition>
    <Transition Name="ManagerSigning_HRManagerSigning_1" To="HRManagerSigning" From="ManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Auto" />
      </Triggers>
      <Conditions>
        <Condition Type="Action" NameRef="CheckNoneAuthorManager" ConditionInversion="false" ResultOnPreExecution="false" />
      </Conditions>
      <Designer X="566" Y="221" />
    </Transition>
    <Transition Name="Draft_HRManagerSigning_1" To="HRManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="421" Y="260" />
    </Transition>
  </Transitions>
</Process>');

INSERT INTO "WorkflowScheme"("Code", "Scheme") VALUES ('Compensation', '
<Process>
  <Designer />
  <Actors>
    <Actor Name="Author" Rule="IsDocumentAuthor" Value="" />
    <Actor Name="Manager" Rule="IsAuthorManager" Value="" />
    <Actor Name="HR Manager" Rule="CheckRole" Value="HR Managers" />
    <Actor Name="HR Director" Rule="CheckRole" Value="HR Directors" />
    <Actor Name="Director" Rule="CheckRole" Value="Directors" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountants" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Start" />
    <Command Name="Approve" />
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To HR Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
  </Commands>
  <Activities>
    <Activity Name="Draft" State="Draft" IsInitial="True" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="140" />
    </Activity>
    <Activity Name="ManagerSigning" State="ManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="320" Y="140" />
    </Activity>
    <Activity Name="AccountantSigning" State="AccountantSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="620" Y="140" />
    </Activity>
    <Activity Name="HRDirectorSigning" State="HRDirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="540" Y="360" />
    </Activity>
    <Activity Name="DirectorSigning" State="DirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="630" Y="480" />
    </Activity>
    <Activity Name="Approved" State="Approved" IsInitial="False" IsFinal="True" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="340" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="Draft_Activity_1_1" To="ManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="CheckNoneAuthorManager" ConditionInversion="true" />
      </Conditions>
      <Designer X="263" Y="165" />
    </Transition>
    <Transition Name="ManagerSigning_Activity_1_1" To="AccountantSigning" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="568" Y="166" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_1" To="DirectorSigning" From="HRDirectorSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="777" Y="404" />
    </Transition>
    <Transition Name="DirectorSigning_Activity_1_1" To="Approved" From="DirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="383" Y="429" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_2" To="Approved" From="HRDirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="385" Y="371" />
    </Transition>
    <Transition Name="ManagerSigning_Draft_1" To="Draft" From="ManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="285" Y="236" />
    </Transition>
    <Transition Name="HRManagerSigning_ManagerSigning_1" To="Draft" From="AccountantSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="425" Y="72" />
    </Transition>
    <Transition Name="HRDirectorSigning_HRManagerSigning_1" To="AccountantSigning" From="HRDirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="748" Y="280" />
    </Transition>
    <Transition Name="HRManagerSigning_Approved_1" To="Approved" From="AccountantSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="644" Y="279" />
    </Transition>
    <Transition Name="HRManagerSigning_HRDirectorSigning_1" To="HRDirectorSigning" From="AccountantSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To HR Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="694" Y="279" />
    </Transition>
    <Transition Name="DirectorSigning_HRManagerSigning_1" To="AccountantSigning" From="DirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Accountant" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="803" Y="279" />
    </Transition>
    <Transition Name="ManagerSigning_HRManagerSigning_1" To="AccountantSigning" From="ManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Auto" />
      </Triggers>
      <Conditions>
        <Condition Type="Action" NameRef="CheckNoneAuthorManager" ConditionInversion="false" ResultOnPreExecution="false" />
      </Conditions>
      <Designer X="569" Y="224" />
    </Transition>
    <Transition Name="AccountantSigning_DirectorSigning_1" To="DirectorSigning" From="AccountantSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="887" Y="341" />
    </Transition>
  </Transitions>
</Process>');

INSERT INTO "WorkflowScheme"("Code", "Scheme") VALUES ('Recruitment', '
<Process>
  <Designer />
  <Actors>
    <Actor Name="Author" Rule="IsDocumentAuthor" Value="" />
    <Actor Name="Manager" Rule="IsAuthorManager" Value="" />
    <Actor Name="HR Manager" Rule="CheckRole" Value="HR Managers" />
    <Actor Name="HR Director" Rule="CheckRole" Value="HR Directors" />
    <Actor Name="Director" Rule="CheckRole" Value="Directors" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountants" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Start" />
    <Command Name="Approve" />
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To HR Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
  </Commands>
  <Activities>
    <Activity Name="Draft" State="Draft" IsInitial="True" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="140" />
    </Activity>
    <Activity Name="HRManagerSigning" State="HRManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="360" Y="140" />
    </Activity>
    <Activity Name="HRDirectorSigning" State="HRDirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="700" Y="140" />
    </Activity>
    <Activity Name="DirectorSigning" State="DirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="710" Y="320" />
    </Activity>
    <Activity Name="Approved" State="Approved" IsInitial="False" IsFinal="True" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="360" Y="320" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="Draft_Activity_1_1" To="HRManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="CheckNoneAuthorManager" ConditionInversion="true" />
      </Conditions>
      <Designer X="291" Y="170" />
    </Transition>
    <Transition Name="DirectorSigning_Activity_1_1" To="Approved" From="DirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_2" To="DirectorSigning" From="HRDirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="834" Y="248" />
    </Transition>
    <Transition Name="HRManagerSigning_ManagerSigning_1" To="Draft" From="HRManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="285" Y="106" />
    </Transition>
    <Transition Name="HRDirectorSigning_HRManagerSigning_1" To="HRManagerSigning" From="HRDirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="626" Y="102" />
    </Transition>
    <Transition Name="HRManagerSigning_Approved_1" To="HRDirectorSigning" From="HRManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="625" Y="171" />
    </Transition>
    <Transition Name="DirectorSigning_HRManagerSigning_1" To="HRDirectorSigning" From="DirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="767" Y="255" />
    </Transition>
  </Transitions>
</Process>');

INSERT INTO "WorkflowScheme"("Code", "Scheme") VALUES ('SickLeave', '
<Process>
  <Designer />
  <Actors>
    <Actor Name="Author" Rule="IsDocumentAuthor" Value="" />
    <Actor Name="Manager" Rule="IsAuthorManager" Value="" />
    <Actor Name="HR Manager" Rule="CheckRole" Value="HR Managers" />
    <Actor Name="HR Director" Rule="CheckRole" Value="HR Directors" />
    <Actor Name="Director" Rule="CheckRole" Value="Directors" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountants" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Start" />
    <Command Name="Approve" />
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To HR Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
  </Commands>
  <Activities>
    <Activity Name="Draft" State="Draft" IsInitial="True" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="140" />
    </Activity>
    <Activity Name="ManagerSigning" State="ManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="320" Y="140" />
    </Activity>
    <Activity Name="HRManagerSigning" State="HRManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="620" Y="140" />
    </Activity>
    <Activity Name="HRDirectorSigning" State="HRDirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="540" Y="360" />
    </Activity>
    <Activity Name="Approved" State="Approved" IsInitial="False" IsFinal="True" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="340" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="Draft_Activity_1_1" To="ManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
        <Restriction Type="Restrict" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="CheckNoneAuthorManager" ConditionInversion="true" />
      </Conditions>
      <Designer X="269" Y="167" />
    </Transition>
    <Transition Name="ManagerSigning_Activity_1_1" To="HRManagerSigning" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="568" Y="166" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_2" To="Approved" From="HRDirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="385" Y="371" />
    </Transition>
    <Transition Name="ManagerSigning_Draft_1" To="Draft" From="ManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="266" Y="97" />
    </Transition>
    <Transition Name="HRManagerSigning_ManagerSigning_1" To="Draft" From="HRManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="183" Y="71" />
    </Transition>
    <Transition Name="HRDirectorSigning_HRManagerSigning_1" To="HRManagerSigning" From="HRDirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="748" Y="280" />
    </Transition>
    <Transition Name="HRManagerSigning_Approved_1" To="Approved" From="HRManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="644" Y="279" />
    </Transition>
    <Transition Name="HRManagerSigning_HRDirectorSigning_1" To="HRDirectorSigning" From="HRManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To HR Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="694" Y="279" />
    </Transition>
    <Transition Name="ManagerSigning_HRManagerSigning_1" To="HRManagerSigning" From="ManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Auto" />
      </Triggers>
      <Conditions>
        <Condition Type="Action" NameRef="CheckNoneAuthorManager" ConditionInversion="false" ResultOnPreExecution="false" />
      </Conditions>
      <Designer X="569" Y="224" />
    </Transition>
    <Transition Name="Draft_HRManagerSigning_1" To="HRManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="" ConditionInversion="false" />
      </Conditions>
      <Designer X="419" Y="253" />
    </Transition>
  </Transitions>
</Process>');

INSERT INTO "WorkflowScheme"("Code", "Scheme") VALUES ('Vacation', '
<Process>
  <Designer />
  <Actors>
    <Actor Name="Author" Rule="IsDocumentAuthor" Value="" />
    <Actor Name="Manager" Rule="IsAuthorManager" Value="" />
    <Actor Name="HR Manager" Rule="CheckRole" Value="HR Managers" />
    <Actor Name="HR Director" Rule="CheckRole" Value="HR Directors" />
    <Actor Name="Director" Rule="CheckRole" Value="Directors" />
    <Actor Name="Accountant" Rule="CheckRole" Value="Accountants" />
  </Actors>
  <Parameters>
    <Parameter Name="Comment" Type="String" Purpose="Persistence" />
  </Parameters>
  <Commands>
    <Command Name="Start" />
    <Command Name="Approve" />
    <Command Name="Reject">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To HR Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
    <Command Name="To Director">
      <InputParameters>
        <ParameterRef Name="Comment" IsRequired="false" DefaultValue="" NameRef="Comment" />
      </InputParameters>
    </Command>
  </Commands>
  <Activities>
    <Activity Name="Draft" State="Draft" IsInitial="True" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="140" />
    </Activity>
    <Activity Name="ManagerSigning" State="ManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="320" Y="140" />
    </Activity>
    <Activity Name="HRManagerSigning" State="HRManagerSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="620" Y="140" />
    </Activity>
    <Activity Name="HRDirectorSigning" State="HRDirectorSigning" IsInitial="False" IsFinal="False" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="540" Y="360" />
    </Activity>
    <Activity Name="Approved" State="Approved" IsInitial="False" IsFinal="True" IsForSetState="True" IsAutoSchemeUpdate="True">
      <Implementation>
        <ActionRef Order="1" NameRef="UpdateTransitionHistory" />
      </Implementation>
      <PreExecutionImplementation>
        <ActionRef Order="1" NameRef="WriteTransitionHistory" />
      </PreExecutionImplementation>
      <Designer X="20" Y="340" />
    </Activity>
  </Activities>
  <Transitions>
    <Transition Name="Draft_Activity_1_1" To="ManagerSigning" From="Draft" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Author" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Start" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" NameRef="CheckNoneAuthorManager" ConditionInversion="true" />
      </Conditions>
      <Designer X="263" Y="165" />
    </Transition>
    <Transition Name="ManagerSigning_Activity_1_1" To="HRManagerSigning" From="ManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="568" Y="166" />
    </Transition>
    <Transition Name="HRDirectorSigning_Activity_1_2" To="Approved" From="HRDirectorSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="385" Y="371" />
    </Transition>
    <Transition Name="ManagerSigning_Draft_1" To="Draft" From="ManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="285" Y="236" />
    </Transition>
    <Transition Name="HRManagerSigning_ManagerSigning_1" To="Draft" From="HRManagerSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="425" Y="72" />
    </Transition>
    <Transition Name="HRDirectorSigning_HRManagerSigning_1" To="HRManagerSigning" From="HRDirectorSigning" Classifier="Reverse" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Director" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Reject" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="748" Y="280" />
    </Transition>
    <Transition Name="HRManagerSigning_Approved_1" To="Approved" From="HRManagerSigning" Classifier="Direct" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="Approve" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="644" Y="279" />
    </Transition>
    <Transition Name="HRManagerSigning_HRDirectorSigning_1" To="HRDirectorSigning" From="HRManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Restrictions>
        <Restriction Type="Allow" NameRef="HR Manager" />
      </Restrictions>
      <Triggers>
        <Trigger Type="Command" NameRef="To HR Director" />
      </Triggers>
      <Conditions>
        <Condition Type="Always" />
      </Conditions>
      <Designer X="694" Y="279" />
    </Transition>
    <Transition Name="ManagerSigning_HRManagerSigning_1" To="HRManagerSigning" From="ManagerSigning" Classifier="NotSpecified" AllowConcatenationType="And" RestrictConcatenationType="And" ConditionsConcatenationType="And" IsFork="false" MergeViaSetState="false" DisableParentStateControl="false">
      <Triggers>
        <Trigger Type="Auto" />
      </Triggers>
      <Conditions>
        <Condition Type="Action" NameRef="CheckNoneAuthorManager" ConditionInversion="false" ResultOnPreExecution="false" />
      </Conditions>
      <Designer X="569" Y="224" />
    </Transition>
  </Transitions>
</Process>');


COMMIT;