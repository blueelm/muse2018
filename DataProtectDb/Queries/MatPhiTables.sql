:setvar MatDb livefdb
SELECT  t.TableName as [TableName]	
FROM [$(MatDb)].[dbo].[DrTable_Columns] c
JOIN [dbo].[PhiElementsFoc] foc
	ON c.ColumnObjectClass = foc.[Object]
	AND c.ColumnRecord = foc.Record
	AND c.ColumnField = foc.Field
JOIN [$(MatDb].[dbo].[DrDataType_Main] dt
	ON dt.DrDataTypeID = c.ColumnDataType_DrDataTypeID
JOIN [$(MatDb)].[dbo].[DrTable_Main] t
	ON c.DrTableID = t.DrTableID
	AND c.SourceID = t.SourceID
GROUP BY t.TableName
	