#!/bin/bash

if [ -z "$1" ]; then
    echo "Please provide an element as an argument."
    exit 0
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

query_and_display_element() {
    local QUERY="$1"
    ELEMENT_QUERY=$($PSQL "$QUERY")

    if [ -z "$ELEMENT_QUERY" ]; then
        echo "I could not find that element in the database."
        exit 0
    fi

    echo "$ELEMENT_QUERY" | while IFS="|" read AN SYMBOL NAME
    do
        ELEMENT_PROPERTY_QUERY=$($PSQL "SELECT * FROM properties WHERE atomic_number = $AN;")
        echo "$ELEMENT_PROPERTY_QUERY" | while IFS="|" read AN AM MP BP TYPE_ID
        do
            TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID;")
            echo "The element with atomic number $AN is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AM amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
        done
    done
    exit 0
}

query_element_by_atomic_number() {
    query_and_display_element "SELECT * FROM elements WHERE atomic_number = $1;"
}

query_element_by_symbol() {
    query_and_display_element "SELECT * FROM elements WHERE symbol = '$1';"
}

query_element_by_name() {
    query_and_display_element "SELECT * FROM elements WHERE name = '$1';"
}

main() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        query_element_by_atomic_number "$1"
    elif [[ $1 =~ ^[A-Z][a-z]?$ ]]; then
        query_element_by_symbol "$1"
    else 
        query_element_by_name "$1"
    fi
}

main "$1"
