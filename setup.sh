#!/bin/bash
# RHEL7 Initialization
# Version : V 0.1.0
# Author  : Nasser Alhumood
# .-.    . . .-.-.
# |.|.-.-|-.-|-`-..-,.-.. .
# `-``-`-'-' ' `-'`'-'   `

# Some Unnecessary Variables, but they're here anyway
version=V0.1.0
oss="CentOs7, RHEL7"

# Welcome Massage
clear
echo -e "\e[1;34;1m+=================================\e[0m"
echo -e "\e[1;34;1m+\e[0m" "RHEL7 initializer -  " $version
echo -e "\e[1;34;1m+\e[0m" "supported operating systems: " $oss
echo -e "\e[1;34;1m+=================================\e[0m"
echo
echo

# Making sure you wanna continue
echo "Don't close the application and wait unil it is completed."
echo "You should be patient if you want to continue..."
echo
read -p "Would you like to continue ? [y/N] "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo No problem, goodbye!
    exit 0
fi

# Creating a logs folder
mkdir logs

# Asking about hostname
read -p "Would you like to update your hostname ? [y/N] "
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Current hostname: $(hostname)"
    echo -n "Hostname: "
    read yourhostname
    echo > /etc/hostname
    echo $yourhostname > /etc/hostname
    echo -n "Hostname domain: "
    read hostnamedomain
    echo -n "Public ip: "
    read publicip
    echo "$publicip $hostnamedomain $yourhostname" >> /etc/hosts
    hostnamectl set-hostname $yourhostname
fi


# Step 1 : Updating the systems
echo -ne "SYSTEM UPDATE               [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y update
} > log/out1.log 2> log/err1.log
echo -ne "SYSTEM UPDATE               [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 2 : Enabling repos
echo -ne "ENABLING REPOS              [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional rhui-REGION-rhel-server-supplementary rhui-REGION-rhel-server-rhscl
} log/out2.log 2> log/err2.log
echo -ne "ENABLING REPOS              [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 3 : Installing epel
echo -ne "EPEL INSTALLATION           [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y install yum install epel-release
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y update
} > log/out3.log 2> log/err3.log
echo -ne "EPEL INSTALLATION           [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# The End
echo
echo -e "\e[31;1m  Awesome, Everything is set, Thank you.  \e[0m"