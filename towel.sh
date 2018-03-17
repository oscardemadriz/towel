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
	echo -e "This script needs day number and intra user name.\nWill download Stupidity and your repository code from dayXX,\nCheck with norminette, build them and also test them with Stupidity" 
	echo  -e "\nUsage:\n ./towel.sh 03 ossanche \n" 
	} 

# if less than two arguments supplied, display usage 
	if [  $# -le 1 ] 
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

git clone https://github.com/mirror12k/42us-stupidity.git stupiditytmp
cd stupiditytmp
git clone vogsphere@vgs.42.us.org:intra/2018/activities/piscine_c_day_$1/$2 day$1
./spawn.pl day$1 config_d$1.pl
./tools/build.sh
./tools/verify.sh
./tools/check_all.sh
rm -rf stupiditytmp
