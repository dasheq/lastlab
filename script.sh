#!/bin/bash

function press_enter {
	printf "\n"
	printf "Press Enter to continue..."
	read
	clear
}

selection=
until [ "$selection" = "0" ]; do
	printf "\nSelect from the menu: \n\n" 
	printf "  1) VM Connection Test\n"
	printf "  2) Show Boto Version\n"
	printf "  3) List all queues\n"
	printf "  4) Create a new queue\n"
	printf "  5) Delete a specific queue\n"
	printf "  6) Return the number of messages in a queue\n"
	printf "  7) Write a new message to a queue\n"
	printf "  8) Read a message on the queue\n"
	printf "  9) Get and delete a message from the queue\n"
	printf " \n 99) Exit\n"

	printf "\nSelection: "
	read selection

	case $selection in
		1  ) 	telnet snf-35353.vm.okeanos-global.grnet.gr 5000 
			press_enter
			;; 
		2  )   	curl -s -X GET localhost:8080/version
			press_enter
			;;
		3  ) 	curl -s -X GET -H 'Accept: application /json' http://localhost:8080/queues | python -mjson.tool
			press_enter
			;;
		4  ) 	curl -X POST -H 'Content-Type: application/json' http://localhost:8080/queues -d '{"name": "DamosQ"}'
			press_enter
			;;
		5  ) 	curl -X DELETE -H 'Accept: application/json' http://localhost:8080/queues/DamosQ
			press_enter
			;;
		6  ) 	curl -X GET -H 'Accept: application/json' http://localhost:8080/queues/DamosQ/msgs/count
			press_enter
			;;
		7  ) 	curl -s -X POST -H 'Accept: application/json' http://localhost:8080/queues/DamosQ/msgs -d '{"content": "this is the queue message"}' 
			press_enter
			;;
		8  )	curl -X GET -H 'Accept: application/json' http://localhost:8080/queues/DamosQ/msgs
			press_enter
			;;
		9  ) 	curl -X DELETE -H 'Accept: application/json' http://localhost:8080/queues/DamosQ/msgs
			press_enter
			;;
		99) exit
			;;
		* ) printf "You did not choose a valid option!\n"
	esac
done

printf "\n"
