#!/bin/bash

# randomly generate a number between 1 and 1000
SECRET_NUMBER=$(( ( RANDOM % 1000 )  + 1 ))

# get username from the user. allow usernames that are 22 characters
echo -e "\nEnter your username:"
read NAME

# if the username is longer than 22 characters, truncate it to 22 characters
if [ ${#NAME} -gt 22 ]; then
    NAME=${NAME:0:22}
fi

# Initialize PSQL
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# check if the user already exists
USER_QUERY=$($PSQL "SELECT * FROM users WHERE name = '$NAME';")

if [ -z "$USER_QUERY" ]; then
    # if the user does not exist, create a new user and greet the new user
    echo -e "\nWelcome, $NAME! It looks like this is your first time here.\n"
    INSERT_USER_RESULT=$($PSQL "INSERT INTO users (name) VALUES ('$NAME') RETURNING user_id;")
    ID=$(echo $INSERT_USER_RESULT | sed -E 's/(^[0-9]+).*/\1/g')
    GAMES_PLAYED=0
else
    # if the user already exists, separately store the each data from the query to a variable
    IFS='|' read -r ID NAME GAMES_PLAYED BEST_GAME <<< $USER_QUERY

    echo Welcome back, $NAME\! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.
fi

echo "Guess the secret number between 1 and 1000:"
read GUESS

# the game loop
GUESS_COUNT=1
until [[ $GUESS -eq $SECRET_NUMBER ]]; do
    # check if the input is an integer
    if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
        echo -e "\nThat is not an integer, guess again:"
        read GUESS
        (( GUESS_COUNT++ ))

    else
        if [ $GUESS -lt $SECRET_NUMBER ]; then
            echo "It's higher than that, guess again:"
            read GUESS
            (( GUESS_COUNT++ ))
        else
            echo "It's lower than that, guess again:"
            read GUESS
            (( GUESS_COUNT++ ))
        fi
    fi
done

# update the user's game stats
if [ -z $BEST_GAME ] || [ $GUESS_COUNT -lt $BEST_GAME ]; then
    BEST_GAME=$GUESS_COUNT
fi
(( GAMES_PLAYED++ ))

UPDATE_USER_RESULT=$($PSQL "UPDATE users SET games_played = $GAMES_PLAYED, best_game = $BEST_GAME WHERE user_id = $ID;")

# victory message
echo You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job\!