#!/bin/sh
#############################
#      __ __                #
#     |_ |_ |_     o  _     #
#     __)__)| | o  | (_)    #
#---------------------------#
# auth: bin-bash she-bang   #
# lic : free use and modify #
# site: https://55h.io      #
#############################

# My server IP/set ip address of server
SERVER_IP="xxx.xxx.xxx.xxx"
SSH_PORT="22"

# Flushing all rules
iptables -F
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
 
# Allow incoming ssh only
iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport $SERVER_IP -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport $SERVER_IP --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

#allow  web port 80 and 443
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT

# make sure nothing comes or goes out of this box
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP

# lits new rules
iptables -L -v -n | more

exit 1
