:setvar MatDb livefdb
	SELECT  t.TableName as [TableName]
	, c.ColumnName as [ColumnName]
	, dt.Name as [SqlDatatype]
	-- Prefix Int or Namepart types might be more interesting to hash, but this isn't comprehensive.
	, CONVERT(BIT,CASE WHEN c.ColumnName = 'Name' THEN 1 WHEN c.ColumnDataType_DrDataTypeID = 'PFXINT' THEN 1 WHEN c.ColumnDataType_DrDataTypeID = 'NAMEPART' THEN 1 ELSE 0 END) AS [Hashable]
FROM [$(MatDb)].[dbo].[DrTable_Columns] c
JOIN [dbo].[PhiElementsFoc] foc
	ON c.ColumnObjectClass = foc.[Object]
	AND c.ColumnRecord = foc.Record
	AND c.ColumnField = foc.Field
JOIN [$(MatDb)].[dbo].[DrDataType_Main] dt
on dt.DrDataTypeID = c.ColumnDataType_DrDataTypeID
JOIN [$(MatDb)].[dbo].[DrTable_Main] t
	ON c.DrTableID = t.DrTableID
	AND c.SourceID = t.SourceID
	