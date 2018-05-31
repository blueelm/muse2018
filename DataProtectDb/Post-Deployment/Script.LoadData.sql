/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Load Phi Elements Tables.. These are incomplete. 
TRUNCATE TABLE [dbo].[PhiElementsFoc]
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'AnyMedRecNum')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'LastUnmergedFrom')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameWithFlag')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'Picture')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'EmrNumNameAndConfStatus')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'AgeCurrent')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameFullWithPrefix')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameFull')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NumberNameAndConfStatus')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NumberAndName')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'MedRecNum')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'EmrNumber')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'MothersName')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'HealthCareNum')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'SocSecNum')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'Age')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'BirthdateComputed')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'Birthdate')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'Name')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameMiddle')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameFirst')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'NameLast')
INSERT [dbo].[PhiElementsFoc] ([Object],[Record],[Field]) VALUES (N'HimRec',N'Main',N'MultDeptMedRecNum')
TRUNCATE TABLE [dbo].[PhiElementsNpr]
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'age')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'birthdate')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'computed.birthdate')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'current.age')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'emr.id')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'first.name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'first.name.indexed')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'healthcare.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'last.discharge.date')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'last.name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'last.name.indexed')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'lss.patient.acct')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'maiden.other.name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'merged.to')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'mf.unit.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'mothers.first.name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'old.unit.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'pat.home.phone')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'policy.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'pt.name')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'soc.sec.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'unit.number')
INSERT [dbo].[PhiElementsNpr] ([Dpm],[Segment],[Element]) VALUES (N'MRI.PAT',N'main',N'universal.number')