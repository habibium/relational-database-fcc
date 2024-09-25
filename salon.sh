#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"
SERVICES=$($PSQL "SELECT * FROM services")

echo -e "\n\n~~ freeCodeCamp Salon ~~\n"

SERVICE_MENU() {
    if [[ -n $1 ]]
    then
        echo -e "\n$1"
    fi

    echo -e "\nPlease enter the number for the service you want:"
    echo "$SERVICES" | sed 's/^ *//g; s/ |/)/g'

    # get service id from user
    read SERVICE_ID_SELECTED

    # check if the service id exists or not
    SERVICE_ID_SELECTED_RESULT=$($PSQL "SELECT * FROM services WHERE service_id = $SERVICE_ID_SELECTED")

    # if not then send to main menu
    if [[ -z $SERVICE_ID_SELECTED_RESULT ]]
    then
        SERVICE_MENU "There's no service with that ID"
    else
        # get user's info
        echo -e "\nEnter your phone number:"
        read CUSTOMER_PHONE

        # check if the user is a customer
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # if the user is not a customer ask for name and insert into db
        if [[ -z $CUSTOMER_ID ]]
        then
            echo -e "\nEnter your name:"
            read CUSTOMER_NAME
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        fi

        # finally get the customer's id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        echo -e "\nEnter the time when you want to get your service:"
        read SERVICE_TIME

        # create the appointment
        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

        # print the feedback to the user for a successful entry
        SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED" | sed -E 's/^ *| *$//')
        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID" | sed -E 's/^ *| *$//')
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
}

SERVICE_MENU

