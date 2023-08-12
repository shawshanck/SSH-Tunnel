#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color
myIP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

installApps()
{
    clear
    OS="$REPLY" ## <-- This $REPLY = OS Selection
    echo -e "${NC}You can configure a ${GREEN}Tunnel ${NC}through ${GREEN}SSH${NC} ${NC}with this script!${NC}"
    echo -e "Please select ${GREEN}'y'${NC} for each item you would like to install."
    echo -e "${RED}NOTE:${NC} Please update your OS then use this script.${NC}"
    echo -e ""
    echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
    echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"
    echo -e ""

    #### Try to instal net-tools
    read -rp "Net-Tools (y/n): " NTLS

    startInstall
}

startInstall() 
{
    clear
    echo -e "*******************************************************"
    echo -e "***         Preparing for Installation              ***"
    echo -e "*******************************************************"
    echo -e ""
    sleep 3s

#######################################################
###           Install for Debian / Ubuntu           ###
#######################################################

    if [[ "$OS" == [234] ]]; then
        if [[ "$NTLS" == [yY] ]]; then
            (sudo apt install net-tools -y) > ~/net-tools.log 2>&1 &

            echo -e "${RED}Note:${NC}${GREEN} Enter each parameter carefully:${NC}"
            echo -e ""
            
            read -e -p "      1. Please Enter the Destination IP Address: " -i "192.168.10.1" desIP
            desIP=${desIP:-"192.168.10.1"}

            read -e -p "      2. Please Enter the Destination SSH Port: " -i "22" desSP
            desSP=${desSP:-"22"}

            read -e -p "      3. Please Enter the Destination Target Port: " -i "22" desEP
            desEP=${desEP:-"22"}

            read -e -p "      4. Please Enter the Source Target Port: " -i "10022" srcSP
            srcSP=${srcSP:-"1022"}

            sudo ssh-keygen
            sleep 5s

            sudo ssh-copy-id -p ${desSP:-"22"} root@${desIP:-"192.168.10.1"}

            mkdir -p /usr/local/bin
            cd /usr/local/bin

            echo "#!/bin/sh
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo ssh -p ${desSP:-"22"} -f -N -L 0.0.0.0:${srcSP:-"1022"}:${desIP:-"192.168.10.1"}:${desEP:-"22"} root@${desIP:-"192.168.10.1"}" >> tunnel.sh

            chmod +x /usr/local/bin/tunnel.sh

            cd /etc

            while read line; do

                # Replace all instances on line of Khulna with Dhaka
                echo ${line//"@reboot         root    /usr/local/bin/tunnel.sh"/"#Previous Crontab job for SSH Tunnel removed. New one added at the end of this file."}

            done < crontab > /tmp/crontab0

            mv /tmp/crontab0 crontab

            echo "@reboot         root    /usr/local/bin/tunnel.sh" >>crontab

            sudo ssh -p ${desSP:-"22"} -f -N -L 0.0.0.0:${srcSP:-"1022"}:${desIP:-"192.168.10.1"}:${desEP:-"22"} root@${desIP:-"192.168.10.1"}

        fi
    fi
        
    
#######################################################
###              Install for CentOS 7 or 8          ###
#######################################################
    if [[ "$OS" == "1" ]]; then
        if [[ "$NTLS" == [yY] ]]; then
            sudo sudo yum install net-tools > ~/docker-script-install.log 2>&1
            echo -e "${RED}Note:${NC}${GREEN} Enter each parameter carefully:"
            echo -e ""

            read -e -p "      1. Please Enter the Destination IP Address: " -i "192.168.10.1" desIP
            desIP=${desIP:-"192.168.10.1"}

            read -e -p "      2. Please Enter the Destination SSH Port: " -i "22" desSP
            desSP=${desSP:-"22"}

            read -e -p "      3. Please Enter the Destination Target Port: " -i "22" desEP
            desEP=${desEP:-"22"}

            read -e -p "      4. Please Enter the Source Target Port: " -i "10022" srcSP
            srcSP=${srcSP:-"1022"}

            sudo ssh-keygen
            sleep 5s

            sudo ssh-copy-id -p ${desSP:-"22"} root@${desIP:-"192.168.10.1"}

            mkdir -p /usr/local/bin
            cd /usr/local/bin

            echo "#!/bin/sh
sudo iptables -t nat -A POSTROUTING -j MASQUERADE
sudo ssh -p ${desSP:-"22"} -f -N -L 0.0.0.0:${srcSP:-"1022"}:${desIP:-"192.168.10.1"}:${desEP:-"22"} root@${desIP:-"192.168.10.1"}" >> tunnel.sh

            chmod +x /usr/local/bin/tunnel.sh

            cd /etc

            while read line; do

                # Replace all instances on line of Khulna with Dhaka
                echo ${line//"@reboot         root    /usr/local/bin/tunnel.sh"/"#Previous Crontab job for SSH Tunnel removed. New one added at the end of this file."}

            done < crontab > /tmp/crontab0

            mv /tmp/crontab0 crontab

            echo "@reboot         root    /usr/local/bin/tunnel.sh" >>crontab

            sudo ssh -p ${desSP:-"22"} -f -N -L 0.0.0.0:${srcSP:-"1022"}:${desIP:-"192.168.10.1"}:${desEP:-"22"} root@${desIP:-"192.168.10.1"}

        fi
    fi

    sleep 3s
    cd

    clear

    echo -e "${GREEN}SSH Tunnle Successfully Configured.${NC}"
    echo ""
    echo -e "All incoming traffic from port: ${YELLOW}${srcSP:-"1022"}${NC} on this server, will be forwarded to ${YELLOW}${desIP:-"192.168.10.1"}:${desEP:-"22"}${NC}"
    echo ""
    echo ""
    echo -e "      ${CYAN}Provided to you by ${YELLOW}Mohammad Mohammadpour${NC}"
    echo -e "          ${YELLOW}https://github.com/shawshanck${NC}"

    exit 1
}

echo ""
echo ""

clear

echo -e "${YELLOW}Let's figure out which OS / Distro you are running.${NC}"
echo -e ""
echo -e ""
echo -e "${GREEN}    From some basic information on your system, you appear to be running: ${NC}"
echo -e "${GREEN}        --  OS Name            ${NC}" $(lsb_release -i)
echo -e "${GREEN}        --  Description        ${NC}" $(lsb_release -d)
echo -e "${GREEN}        --  OS Version         ${NC}" $(lsb_release -r)
echo -e "${GREEN}        --  Code Name          ${NC}" $(lsb_release -c)
echo -e ""
echo -e "${YELLOW}------------------------------------------------${NC}"
echo -e ""

PS3="Please select the number for your OS / distro: "
select _ in \
    "CentOS 7 / 8 / Fedora" \
    "Debian 10 / 11" \
    "Ubuntu 18.04" \
    "Ubuntu 20.04 / 21.04 / 22.04" \
    "Exit"
do
  case $REPLY in
    1) installApps ;;
    2) installApps ;;
    3) installApps ;;
    4) installApps ;;
    5) exit ;;
    *) echo "Invalid selection, please try again..." ;;
  esac
done
