CREATE TABLE [dbo].[PhiElementsFoc]
(
	[Object] VARCHAR(50) NOT NULL,
	[Record] VARCHAR(100) NOT NULL,
	[Field] VARCHAR(100) NOT NULL,
	
	CONSTRAINT pk_PhiElementsFoc PRIMARY KEY CLUSTERED ([Object],[Record],[Field])
)
