#!/bin/bash

#script for future fraud on other Lucky Duck games

cat $1_Dealers_schedule | awk -F" " '{print $1,$2,$3,$4}' | grep "$2" >> possible_suspects_for_losses





