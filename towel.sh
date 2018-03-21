#!/bin/bash 
 
display_usage() {
	echo "# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    towel.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ossanche <oscardemadriz@gmail.com>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/03/17 10:42:06 by ossanche          #+#    #+#              #
#    Updated: 2018/03/17 10:42:34 by ossanche         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #" 
	echo -e "\n###If you're gonna survive out here, you've gotta know...where your towel is!###\n\n"
	echo -e "Will download Stupidity and your repository code from dayXX,\nCheck with norminette, build them and also test them with Stupidity" 
	echo  -e "\nUsage:\n ./towel.sh <dayNumber> \n" 
	echo  -e "\nExample:\n ./towel.sh 03 \n" 
	} 
interval="5"
delay="2"
full_path="$PWD/day$1"
if git fetch | grep --quiet 'master'
	then 
		chmod +x update.sh
		echo -e "Updating...\nplease go for coffee or talk with the peer on your left..."
		(exec ./update.sh)  2> /dev/null &
		exit 0
	fi 
# if less than two arguments supplied, display usage 
	if [  $# -le 0 ] 
	then 
		display_usage
		exit 1
	fi 
 
# check whether user had supplied -h or --help . If yes display usage 
	if [[ ( $# == "--help") ||  $# == "-h" ]] 
	then 
		display_usage
		exit 0
	fi 
cd /tmp
if [ -d "toweltmp" ]; then
  # Control will enter here if $DIRECTORY exists.
  		cd toweltmp
  		git pull
  		cd ..
	else
		git clone https://github.com/mirror12k/42us-stupidity.git toweltmp
fi
cd toweltmp
if [ -d "day$1" ]; then
  # Control will enter here if $DIRECTORY exists.
  		cd day$1
  		git pull
  		cd ..
	else
		git clone vogsphere@vgs.42.us.org:intra/2018/activities/piscine_c_day_$1/$USER day$1
fi
ln -s /tmp/toweltmp/day$1 $full_path
./spawn.pl day$1 config_d$1.pl
./tools/build.sh
./tools/verify.sh
# kill -0 pid   Exit code indicates if a signal may be sent to $pid process.
(
    ((t = 15))

    while ((t > 0)); do
        sleep $interval
        kill -0 $$ || exit 0
        ((t -= interval))
    done

    # Be nice, post SIGTERM first.
    # The 'exit 0' below will be executed if any preceeding command fails.
    if ps aux | grep -q "check.pl"; then
    	commands=$(ps aux | grep 'check.pl' | awk '{print $2}')
    	echo -e "       ______
  [===|     |====]
      |     ||
      |     ||
      |=====||
      |=====||
      '\"\"\"\"\"'|
       |     |
       '\"\"\"\"\"'"
        printf "ErRoR: Hmmm You have an infinite loop in this exercise\ndon't worry i won't talk about this with anybody"
		sleep 1
		printf  "."
		sleep 1
		printf "."
		sleep 1
		printf ". after all..."
		sleep $delay
		printf " i'm just a towel ;)\n\n"
			sleep $delay
		kill $commands 2> /dev/null > /dev/null
		exit 1
	fi
    
) 2> /dev/null &
exec ./tools/check_all.sh

