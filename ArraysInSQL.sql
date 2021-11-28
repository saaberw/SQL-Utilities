

------------------Implement array-like functionality in SQL Server
-----------------

DECLARE @list nvarchar(MAX) = '1,99,22,33,45',
        @xml  xml
SELECT @xml = '<x>' + replace(@list COLLATE DATABASE_DEFAULT, ',', '</x><x>') + '</x>'


DECLARE  @requestIndex int=2
DECLARE  @result INT

SELECT  @result=resultset.val FROM 
(SELECT row_number() OVER(ORDER BY X.x) AS pos,
		X.x.value('.', 'int') AS val       
FROM   @xml.nodes('/x/text()') X(x)
 ) AS resultset WHERE resultset.pos=@requestIndex
 
 SELECT @result
