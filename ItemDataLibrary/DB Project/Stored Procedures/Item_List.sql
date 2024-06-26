CREATE PROCEDURE [dbo].[Item_List]
AS
begin
	set nocount on;

	SELECT [i].[productName], [i].[Brand], [i].[Code], [i].[UnitPrice]
	FROM dbo.Item i
end
