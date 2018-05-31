/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

USE master;

IF EXISTS (SELECT * FROM sys.server_principals WHERE [name] = 'login_DataProtectClr')
	DROP LOGIN login_DataProtectClr

IF EXISTS (SELECT * FROM sys.certificates WHERE [name] = 'DataProtectClrCert')
	DROP CERTIFICATE DataProtectClrCert

:r .\create_cert.sql

CREATE LOGIN login_DataProtectClr FROM CERTIFICATE DataProtectClrCert

 
GRANT EXTERNAL ACCESS ASSEMBLY TO login_DataProtectClr;

USE [$(DatabaseName)];

