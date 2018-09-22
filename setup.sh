#!/bin/bash
# RHEL7 Initialization
# Version : V 0.1.1
# Author  : Nasser Alhumood
# .-.    . . .-.-.
# |.|.-.-|-.-|-`-..-,.-.. .
# `-``-`-'-' ' `-'`'-'   `
clear

# Some Unnecessary Variables, but they're here anyway
version=V0.1.1
oss="CentOs7, RHEL7"

# Welcome Massage
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

# Hostname Update
read -p "Would you like to update your hostname ? [y/N] "
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
    echo -e "HOSTNAME UPDATE             [\e[1;37;1;1;42m   +done   \e[0m]"
    echo
fi

# Root Password Change
read -p "Would you like to change your root password ? [y/N] "
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo passwd
    echo -e "Root Password               [\e[1;37;1;1;42m   +done   \e[0m]"
    echo
fi

# Starting the process
echo "Starting the process:"

# Step 1 : Updating the systems
echo -ne "SYSTEM UPDATE               [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y update
} > logs/out1.log 2> logs/err1.log
echo -ne "SYSTEM UPDATE               [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 2 : Enabling repos
echo -ne "ENABLING REPOS              [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional rhui-REGION-rhel-server-supplementary rhui-REGION-rhel-server-rhscl
} > logs/out2.log 2> logs/err2.log
echo -ne "ENABLING REPOS              [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 3 : Installing epel
echo -ne "EPEL INSTALLATION           [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo yum -y update
} > logs/out3.log 2> logs/err3.log
echo -ne "EPEL INSTALLATION           [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# Step 3 : Installing esential packages
echo -ne "PACKAGES INSTALLATION       [\e[1;30;1;1;47min progress\e[0m]\r"
{
    sudo yum -y install nano wget
} > logs/out4.log 2> logs/err4.log
echo -ne "PACKAGES INSTALLATION       [\e[1;37;1;1;42m   +done   \e[0m]"
echo

# The End
echo
echo -e "\e[31;1m  Awesome, Everything is set, Thank you.  \e[0m"