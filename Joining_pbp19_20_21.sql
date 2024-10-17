#Creating new table to insert info into
CREATE TABLE demo.pbp_19_20_21 AS
SELECT * FROM demo.pbp_2019;

INSERT INTO demo.pbp_19_20_21
SELECT * FROM demo.pbp_2020;

INSERT INTO demo.pbp_19_20_21
SELECT * FROM demo.pbp_2021;

#Removing irrelevent collumns
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN MyUnknownColumn;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN `MyUnknownColumn_[0]`;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN SeriesFirstDown;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN NextScore;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN TeamWin;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN `MyUnknownColumn_[1]`;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN IsChallenge;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN IsChallengeReversed;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN Challenger;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN IsMeasurement;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN YardLineFixed;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN YardLineDirection;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN YardLineDirection;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN IsTwoPointConversion;
ALTER TABLE demo.pbp_19_20_21 DROP COLUMN IsTwoPointConversionSuccessful;

SELECT * FROM demo.pbp_19_20_21
ORDER BY Gameid, Quarter, Minute DESC, Second DESC;








