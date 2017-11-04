#Deals 2 Russell Coonrod 11/4/2017

USE Deals; 
#Create a view named DealValues that lists the DealID, total dollar value and number of parts for each deal.
DROP VIEW IF EXISTS DealValues;
CREATE VIEW DealValues AS
SELECT DEALS.dealid, SUM(DollarValue) AS TotDollarValue, COUNT(PartNumber) AS NumParts
FROM DEALS JOIN DEALPARTS on (DEALS.DealID = DEALPARTS.DealID)
Group by DEALS.DealID
ORDER BY DEALS. DealID;
SELECT * from DealValues;


#10 Create a view named DealSummary that lists the DealID, DealName, number of players, total dollar value, and number of parts for each deal.
#Bonus: use a subquery to construct a comma-separated list of deal types for each deal. (Don't forget the comment and the select query.)
DROP VIEW IF EXISTS DealSummery;
Create VIEW DealSummery As
SELECT Deals.DealID, DealName, COUNT(PlayerID) AS NumPlayers, TotDollarValue, NumParts
FROM DEALS Join DealValues on (DEALS.DealID = DealValues.DealID)
	JOIN Players ON (DEALS.DealID = players.DealID)
GROUP BY Deals.DealID;

#11 Create a view called DealsByType that lists TypeCode, number of deals, and total value of deals for each deal type.
DROP VIEW IF EXISTS DealsByType;
Create VIEW DealsByType as
SELECT DISTINCT dealtypes.TypeCode, COUNT(Deals.DealID) as NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes
	LEFT JOIN Deals ON (DealTypes.DealID = Deals.DealID)
    Join DealParts on (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode;


#12 Create a view called DealPlayers that lists the CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder.
DROP VIEW IF EXISTS DealPlayers;
CREATE VIEW DealPlayers as
SELECT DealID, CompanyID, CompanyName, RoleCode
From Players
	JOIN Deals Using (DealID)
    JOIN COMPANIES Using(CompanyID)
    JOIN ROLECODES USING (RoleCode)
ORDER BY ROLESORTORDER;

#13Create a view called DealsByFirm that lists the FirmID, Name, number of deals, and total value of deals for each firm.
#Each firm should be listed, even if there are no deals for that firm. (Don't forget the comment and the select query.)
DROP VIEW IF EXISTS DealsByFirm;
CREATE VIEW DealsByFirm as
Select FirmID, `Name` AS FIRMNAME, COUNT(PLAYERS.DealID) AS NumDeals,SUM(TotDollarValue) AS Totvalue
FROM FIRMS
	left JOIN PLAYERSUPPORTS USING (FirmID)
    left JOIN PLAYERS USING (PlayerID)
    left JOIN DealValues USING (DealID)
GROUP BY FirmID, `Name`;