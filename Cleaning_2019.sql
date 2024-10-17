#CLEANING 2019 Play By Play

#Clean and Remove plays where play didn't count due to penalty and all non plays
SELECT * FROM demo.pbp_2019
WHERE IsPenalty = 1 AND IsPenaltyAccepted = 1 AND IsNoPlay = 1
ORDER BY Gameid;

DELETE
FROM demo.pbp_2019
WHERE IsPenalty = 1 AND IsPenaltyAccepted = 1 AND IsNoPlay = 1;

SELECT * FROM demo.pbp_2019
WHERE IsNoPlay = 1;

DELETE
FROM demo.pbp_2019
WHERE IsNoPlay = 1;

#Clean And Remove all non-offensive plays in PlayType(Punts,FGs,QB Kneel are 4 down plays)
SELECT DISTINCT PlayType
FROM demo.pbp_2019;

#Outlier PlayType's: 'EXCEPTION' 'KICK OFF' 'EXTRA POINT' 'TIMEOUT' 'TWO-POINT CONVERSION' 'PENALTY' ''
SELECT * FROM demo.pbp_2019
WHERE PlayType = 'EXCEPTION';

DELETE
FROM demo.pbp_2019
WHERE PlayType = 'EXCEPTION' AND Description LIKE 'E%';

SELECT * FROM demo.pbp_2019
WHERE PlayType = 'KICK OFF';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = 'KICK OFF';

SELECT * FROM demo.pbp_2019
WHERE PlayType = 'EXTRA POINT';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = 'EXTRA POINT';

SELECT * FROM demo.pbp_2019
WHERE PlayType = 'TIMEOUT';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = 'TIMEOUT';

SELECT * FROM demo.pbp_2019
WHERE PlayType = 'TWO-POINT CONVERSION';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = 'TWO-POINT CONVERSION';

SELECT * FROM demo.pbp_2019
WHERE PlayType = 'PENALTY';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = 'PENALTY';

SELECT * FROM demo.pbp_2019
WHERE PlayType = '' AND Description LIKE 'E%';

DELETE 
FROM demo.pbp_2019
WHERE PlayType = '' AND Description LIKE 'E%';

SELECT * FROM demo.pbp_2019
WHERE Description LIKE 'E%'
ORDER BY Gameid;

#Down should be 1-4, if no down listed their is issue, check description
SELECT * FROM demo.pbp_2019
WHERE Down != 1 AND Down != 2 AND Down != 3 AND Down != 4;

DELETE FROM demo.pbp_2019
WHERE Down != 1 AND Down != 2 AND Down != 3 AND Down != 4;

#Analyzing description to check no non-plays still in data
SELECT * FROM demo.pbp_2019
WHERE Description NOT LIKE '(%';

SELECT * FROM demo.pbp_2019;

#checking count in clean data vs raw data
SELECT 
    COUNT(CASE WHEN PlayType = 'RUSH' AND Yards >= 15 THEN 1 END) AS big_rush,
    COUNT(CASE WHEN PlayType = 'Pass' AND Yards >= 20 THEN 1 END) AS big_pass
FROM demo.pbp_2019;

SELECT 
    COUNT(CASE WHEN PlayType = 'RUSH' AND Yards >= 15 THEN 1 END) AS big_rush,
    COUNT(CASE WHEN PlayType = 'Pass' AND Yards >= 20 THEN 1 END) AS big_pass
FROM demo.RAWpbp_2019;







