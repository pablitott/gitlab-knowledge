#! /usr/bin/bash
# Clears the aws role, aws will use the configured default profile
pattern="^AWS*"
if [[ $1 != "" ]]; then pattern=$1; fi 

awsKeys=$(env | grep -E $pattern)
# echo $awsKeys
for Key in $awsKeys
do
	awsKey=$(echo $Key | awk -F'=' {'print $1'})
	unset $awsKey
done
