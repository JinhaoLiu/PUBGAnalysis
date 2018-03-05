USE PUBGAnalysis;

-- 1. A sinple but straight forward leaderboard (only include username, game number, K/D ratio, win rate and highest rating).
SELECT   UserName, 
         Games, 
         KD, 
         WinRate, 
         HighestRating 
FROM     Leaderboard;

-- 2. Top 10 favorite weapons.
SELECT W.ItemName, W.WeaponType, count(*) AS num
FROM PUBGAnalysis.Weapons AS W
INNER JOIN PUBGAnalysis.Favorites AS F
WHERE W.ItemName = F.ItemName
GROUP BY ItemName
ORDER BY num DESC
Limit 10;

-- 3. Average rating of top 100 users.
SELECT AVG(top.SoloRating + top.DuoRating 
           + top.SquadRating)/3 AS AVG_RATING 
FROM   (SELECT UserName, 
               WinNum, 
               SoloRating, 
               DuoRating, 
               SquadRating 
        FROM   LeaderBoard 
        ORDER  BY WinNum DESC 
        LIMIT  100) AS top; 

-- 4. Show the favorite items of users whose KD > 3.0.
SELECT Favorites.UserName, Favorites.ItemName 
FROM 
LeaderBoard INNER JOIN Favorites
ON LeaderBoard.UserName = Favorites.UserName
WHERE LeaderBoard.KD >= 3.0;

-- 5. What are the types of weapons having top 3 damage?
SELECT WeaponType, Damage FROM Weapons ORDER BY Damage DESC LIMIT 3;

-- 6. What is the average KD of users whose favorite item is M416?
SELECT AVG(LeaderBoard.KD) AS AVG_KD
FROM Favorites LEFT JOIN LeaderBoard ON Favorites.UserName =
LeaderBoard.UserName
GROUP BY Favorites.ItemName
HAVING Favorites.ItemName = 'M416';

-- 7. Show users ranking by highest rating.
SELECT LeaderBoard.UserName, LeaderBoard.HighestRating
FROM LeaderBoard
ORDER BY LeaderBoard.HighestRating DESC;

-- 8. Top 10 solo rating users which shows the individual
SELECT LeaderBoard.UserName, LeaderBoard.SoloRating
FROM LeaderBoard
ORDER BY LeaderBoard.SoloRating DESC
LIMIT 10;
       
# 9. Select the most favorite vehicle type
SELECT X.ItemName, X.VehicleType, count(*) AS num
FROM PUBGAnalysis.Vehicles AS X
	INNER JOIN PUBGAnalysis.Favorites AS Y
WHERE X.ItemName = Y.ItemName
GROUP BY ItemName
ORDER BY num DESC
Limit 1;

-- 10. Find the ratio of number of games from the user with max KD vs the user with min KD.
SELECT num_games_from_user_with_max_kd / num_games_from_user_with_min_kd AS RatioOfNumOfGamesFromUserWithMaxKdVSUserWithMinKd
FROM (
	SELECT Games AS num_games_from_user_with_max_kd
    FROM PUBGAnalysis.LeaderBoard ORDER BY KD DESC LIMIT 1) as X
  INNER JOIN 
  (SELECT Games AS num_games_from_user_with_min_kd
    FROM PUBGAnalysis.LeaderBoard ORDER BY KD LIMIT 1) as Y


