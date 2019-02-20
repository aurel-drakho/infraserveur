#!/bin/bash
#---------------------------------------------------------------------
# ./debian-automatisation.sh
# wget info-logic.fr/linux_anthony/debian-automatisation.sh

# installation des packages pour debian
# Anthony COURTE
# Version 1.0
# 15/02/2019
#
#---------------------------------------------------------------------

# Variables Globales
CFG_HOSTNAME_FQDN=`hostname -f`;
WT_BACKTITLE="Installation debian - Anthony Courte - INFO-LOGIC"

# Couleur du Bash
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0m' # Sans Couleur

#Sauvegarde du current directory
PWD=$(pwd);

# vérification du source.list
  contrib=$(cat /etc/apt/sources.list | grep contrib | grep -v "cdrom")
  nonfree=$(cat /etc/apt/sources.list | grep non-free | grep -v "cdrom")
  if [ -z "$contrib" ]; then
        if [ -z "$nonfree" ]; then
                sed -i 's/main/main contrib non-free/' /etc/apt/sources.list;
        else
                sed -i 's/main/main contrib/' /etc/apt/sources.list;
        fi
  else
        if [ -z "$nonfree" ]; then
                sed -i 's/main/main non-free/' /etc/apt/sources.list;
        fi
  fi
  echo -e "${green} OK${NC}\n"
}

#update et upgrade du debian
echo -n "Update et upgrade en cours d'installation... patienter "
apt-get -qq update > /dev/null 2>&1
apt-get -qqy upgrade > /dev/null 2>&1
echo -e "[${green}DONE!!!${NC}]\n"
echo "[${green}Update et upgrade effectué${NC}]\n"

#installation des appli de bases
echo -n "installation des appli de bases... patienter "
apt-get -y install ssh openssh-server vim-nox nano binutils dnsutils aptitude sudo ntp

#modification du nom d'hote
# nom d'hote
echo "Renseigner le futur nom d'hote du debian ?"
read nomHote
echo $nomHote > /etc/hostname

# nom de domaine - fichier hosts
echo -echo "veuiller Renseigner le futur nom de domaine"
read nomDomain

echo -echo "veuiller Renseigner l'ipdu serveur debian"
read monIP

echo "127.0.0.1 $nomHote.$nomdomaine" > /etc/hosts
echo  "$monIP $nomHote.$nomdomaine.$nomHote" >> /etc/hosts