USE [Video Games]

/*
Which platform has the most sales? 
*/
SELECT Platform, SUM(Global_Sales) as total_sales
FROM vgsales$
GROUP BY Platform
ORDER BY total_sales
DESC
/*
Which genre has the most sales?
*/
SELECT Genre, SUM(Global_Sales) as total_sales
FROM vgsales$
GROUP BY Genre
ORDER BY total_sales
DESC
/*
Which year had the most video games sales?
*/
SELECT Year, SUM(Global_Sales) as total_sales
FROM vgsales$
GROUP BY Year
ORDER BY total_sales
DESC
/*
What are the average global sales per game per year?
*/
SELECT Year, AVG(Global_Sales) as avg_sales
FROM vgsales$
GROUP BY Year
ORDER BY Year
ASC
/*
Which publisher had the most sales in North America in 2008?
*/
SELECT Publisher, Year, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Year = 2008
GROUP BY Publisher, Year
ORDER BY na_sales DESC
/*
Which publishers have sold at least $10 million?
*/
SELECT Publisher, SUM(Global_Sales) as total_sales
FROM vgsales$
WHERE Global_Sales > 10
GROUP BY Publisher
ORDER BY total_sales
DESC
/*
What was Electronic Arts' best selling game in 2008?
*/
SELECT Name, Publisher, Year, SUM(Global_Sales) as total_sales
FROM vgsales$
WHERE Publisher = 'Electronic Arts' AND Year = 2008
GROUP BY Publisher, Year, Name
ORDER BY total_sales
DESC
/*
Let's breakdown the sales for FIFA Soccer 09 in 2008 by region.
*/
SELECT Name, Year, SUM(NA_Sales) as na_sales, SUM(EU_Sales) as eu_sales, SUM(JP_Sales) as jp_sales, SUM(Other_Sales) as other_sales
FROM vgsales$
WHERE Name = 'FIFA Soccer 09' AND Year = 2008
GROUP BY Name, Year
/*
What percentage of those sales came from North America?
*/
SELECT Name, Year, ROUND((SUM(NA_sales) / SUM(Global_Sales) * 100), 2) as na_sales_percentage
FROM vgsales$
WHERE Name = 'FIFA Soccer 09' and Year = 2008
GROUP BY Name, Year

/*
Now that we've analyzed the data a bit, let's start building our video game conference!

Since this conference is being held in North America, we will focus on North America sales only.

Here's the plan for the booths at this conference:
1980s: Booth for top game and booth for top publisher
1990s: Booths for top 2 games and booth for top publisher
2000s: Booths for top 3 games and booth for top publisher
2010s: Booths for top 3 games and booth for top 2 publishers
*/
/*
Let's add a decade column to make it easier to group our data
*/
ALTER TABLE vgsales$
ADD Decade VARCHAR(3)

UPDATE vgsales$
SET Decade = '80s'
WHERE Year > 1979 AND Year < 1990

UPDATE vgsales$
SET Decade = '90s'
WHERE Year > 1989 AND Year < 2000

UPDATE vgsales$
SET Decade = '00s'
WHERE Year > 1999 AND Year < 2010

UPDATE vgsales$
SET Decade = '10s'
WHERE Year > 2009 AND Year < 2020

/*
1980s

Let's find the top game from this decade
*/
SELECT TOP 1 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '80s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
Now, the top publisher
*/
SELECT TOP 1 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '80s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

/*
1990s

Let's find the top 2 games from this decade
*/
SELECT TOP 2 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '90s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
Now, the top publisher
*/
SELECT TOP 1 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '90s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

/*
2000s

Let's find the top 3 games from this decade
*/
SELECT TOP 3 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '00s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
Now, the top publisher
*/
SELECT TOP 1 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '00s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

/*
2010s

Let's find the top 2 games from this decade
*/
SELECT TOP 3 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '10s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
Now, the top 2 publishers
*/
SELECT TOP 2 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '10s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

/*
It looks like Nintendo was at the top for 3 decades in a row. Let's change up our conference a bit in order to cater to the Nintendo fans and maybe bring in some other top developers from 1980-2010.
*/

/*
What is the best-selling Nintendo game of all time?
*/
SELECT TOP 1 Name, Publisher, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Publisher = 'Nintendo'
GROUP BY Publisher, Name
ORDER BY na_sales DESC
/*
This is a bit of an odd case, since Wii Sports was included with every Wii console that was sold. Let's find the next result.
*/
SELECT TOP 2 Name, Publisher, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Publisher = 'Nintendo'
GROUP BY Publisher, Name
ORDER BY na_sales DESC
/*
It looks like Super Mario Bros. is the top selling Nintendo game of all time. We'll have a main booth dedicated to this game.
*/
/*
Now let's find the next top-selling publishers and games from the 80s, 90s, and 00s.

80s:
*/
SELECT TOP 2 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '80s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

SELECT TOP 2 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '80s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
90s:
*/
SELECT TOP 2 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '90s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

SELECT TOP 2 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '90s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC
/*
00s
*/
SELECT TOP 2 Publisher, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '00s'
GROUP BY Publisher, Decade
ORDER BY na_sales DESC

SELECT TOP 2 Name, Decade, SUM(NA_Sales) as na_sales
FROM vgsales$
WHERE Decade = '00s'
GROUP BY Name, Decade 
ORDER BY na_sales DESC



/*
So here's our final lineup for our conference:

Main booth: Nintendo & Super Mario Bros.

80s: Atari & Duck Hunt
90s: Sony Computer Entertainment & Pokemon Red/Blue
00s: Electronic Arts & Mario Kart Wii
10s: Activision & Grand Theft Auto V