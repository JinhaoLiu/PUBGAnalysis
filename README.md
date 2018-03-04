# Project name

PUBG-A (PlayerUnknown's Battlegrounds Ananlysis)

# Proposition

PUBG-A is a data-driven web application that provides gaming items information listing and insight
analysis of player stats for PUBG game players who are unhappy with their gaming strategies, skills
and limitation of oﬃcial gaming data analysis.

# Plans

**Current**

- Game item information
- Player data analysis including player's radar chart and game leaderboard
- Match data analysis focusing on rendering higher death rate spots on game map in early gaming stage and late gaming stage using heatmap

**In the future**

- Real-time stats analysis and visualization based on AWS EC2, SNS, SQS, Lambda
- Dynamic change on death spots analysis heatmap

# Data source

- Kaggle dataset A: https://www.kaggle.com/lazyjustin/pubgplayerstats

  Kaggle dataset B: https://www.kaggle.com/chegerland/pubg-data-analysis/data

  - extract: use python / js scripts to clean data

- PUBG Tracker: https://pubgtracker.com/site-api

  - extract: use python / js scripts to collect raw data by calling APIs and then clean data

- PUBG Wiki: https://pubg.gamepedia.com/PLAYERUNKNOWNS_BATTLEGROUNDS_Wiki

