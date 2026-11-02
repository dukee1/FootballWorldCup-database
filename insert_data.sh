#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi


echo $($PSQL "TRUNCATE games, teams RESTART IDENTITY")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_TEAM=$($PSQL "SELECT team_id 
    FROM teams 
    WHERE name = '$WINNER'")
    if [[ -z $WINNER_TEAM ]]
    then
      INSERT_WINNER_TEAM=$($PSQL "INSERT INTO teams(name) 
      VALUES ('$WINNER')")
      if [[ $INSERT_WINNER_TEAM = "INSERT 0 1" ]]
      then
        echo "Inserted into teams, $WINNER."
      fi
    fi
    OPPONENT_TEAM=$($PSQL "SELECT team_id 
    FROM teams 
    WHERE name = '$OPPONENT'")
    if [[ -z $OPPONENT_TEAM ]]
    then
      INSERT_OPPONENT_TEAM=$($PSQL "INSERT INTO teams(name) 
      VALUES ('$OPPONENT')")
      if [[ $INSERT_OPPONENT_TEAM = "INSERT 0 1" ]]
      then
        echo "Inserted into teams, $OPPONENT."
      fi
    fi
    WINNER_TEAM=$($PSQL "SELECT team_id 
    FROM teams 
    WHERE name = '$WINNER'")

    OPPONENT_TEAM=$($PSQL "SELECT team_id 
    FROM teams 
    WHERE name = '$OPPONENT'")

    INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
    VALUES($YEAR, '$ROUND', $WINNER_TEAM, $OPPONENT_TEAM, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_GAME = "INSERT 0 1" ]]
    then
      echo "Inserted into games, $WINNER - $OPPONENT in $ROUND round game."
    fi
  fi
done