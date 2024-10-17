#Analysis

#Big plays by year (15+ for rush and 20+ for pass)
SELECT 
	SeasonYear,
    COUNT(CASE WHEN IsRush = 1 AND Yards >= 15 THEN 1 END) AS TotalBigRunPlays,
    COUNT(CASE WHEN IsPass = 1 AND Yards >= 20 THEN 1 END) AS TotalBigPassPlays
FROM demo.pbp_19_20_21
GROUP BY SeasonYear;

#What were the total plays each season and what percent of those plays were big plays?
SELECT 
	SeasonYear,
    COUNT(*) AS TotalPlays,
    ((COUNT(CASE WHEN IsRush = 1 AND Yards >= 15 THEN 1 END) + 
     COUNT(CASE WHEN IsPass = 1 AND Yards >= 20 THEN 1 END)) / COUNT(*)) * 100 AS PercentBigPlays
FROM demo.pbp_19_20_21
GROUP BY SeasonYear;

-- Percent of big plays during the season saw a DECREASE year after year from 2019-2021
-- Largest drop from 2019 to 2020 season, about 4% percent 

#What team had the most big plays each season and what percent of their plays were big plays?
SELECT SeasonYear, Team, TotalBigPlays, TotalPlays,
       (TotalBigPlays / TotalPlays) * 100 AS PercentBigPlays
FROM (
    SELECT 
        SeasonYear,
        OffenseTeam AS Team,
        COUNT(*) AS TotalPlays,
        COUNT(CASE WHEN IsRush = 1 AND Yards >= 15 THEN 1 END) +
        COUNT(CASE WHEN IsPass = 1 AND Yards >= 20 THEN 1 END) AS TotalBigPlays,
        ROW_NUMBER() OVER (PARTITION BY SeasonYear ORDER BY 
                           COUNT(CASE WHEN IsRush = 1 AND Yards >= 15 THEN 1 END) +
                           COUNT(CASE WHEN IsPass = 1 AND Yards >= 20 THEN 1 END) DESC) AS MaxTeam
    FROM 
        demo.pbp_19_20_21
    WHERE 
        SeasonYear IN (2019, 2020, 2021)
    GROUP BY 
        SeasonYear, OffenseTeam
) AS TeamsRank
WHERE MaxTeam = 1;
 
-- 2019: SF 9.44%, 2020: KC 8.37%, 2021: 7.72%
-- There was a year by year DECREASE in most explosive team's % of plays coming from big plays

#Big play touchdown percentage year after year increase or decrease?
WITH BigPlayStats AS (
    SELECT
        SeasonYear,
        OffenseTeam AS Team,
        COUNT(CASE WHEN (IsRush = 1 AND Yards >= 15) OR (IsPass = 1 AND Yards >= 20) THEN 1 END) AS TotalBigPlays,
        COUNT(CASE WHEN ((IsRush = 1 AND Yards >= 15) OR (IsPass = 1 AND Yards >= 20)) AND IsTouchdown = 1 THEN 1 END) AS BigPlayTouchdowns
    FROM demo.pbp_19_20_21
    GROUP BY SeasonYear, Team
),
TopBigPlayTeam AS (
    SELECT
        SeasonYear,
        Team,
        TotalBigPlays,
        BigPlayTouchdowns,
        (BigPlayTouchdowns / TotalBigPlays) * 100 AS BigTdPercentage,
        RANK() OVER (PARTITION BY SeasonYear ORDER BY TotalBigPlays DESC) AS ranked
    FROM BigPlayStats
)
SELECT
    SeasonYear,
    Team,
    TotalBigPlays,
    BigPlayTouchdowns,
    BigTdPercentage
FROM TopBigPlayTeam
WHERE ranked = 1 
ORDER BY SeasonYear;

-- Data shows 3-4% deacrease in big plays resulting in touchdowns from 2019-2020
-- Consistant with data showing overall decrease in big plays