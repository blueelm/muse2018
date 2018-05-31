CREATE TABLE [dbo].[PhiElementsNpr]
(
	[Dpm] VARCHAR(50) NOT NULL,
	[Segment] VARCHAR(100) NOT NULL,
	[Element] VARCHAR(100) NOT NULL,
	
	CONSTRAINT pk_PhiElementsNpr PRIMARY KEY CLUSTERED ([Dpm],[Segment],[Element])
)
