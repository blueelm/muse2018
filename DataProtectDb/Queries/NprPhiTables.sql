:setvar NprDb livendb
SELECT  t.TableName as [TableName]
FROM [$(NprDb)].[dbo].[DrTableColumns] c
JOIN [dbo].[PhiElementsNpr] npr
	ON c.DpmID = npr.Dpm
	AND c.SegmentID = npr.Segment
	AND c.ElementID = npr.Element
JOIN [$(NprDb)].[dbo].[DrTableMain] t
	ON c.TableID = t.TableID
	AND c.SourceID = t.SourceID
GROUP BY t.TableName