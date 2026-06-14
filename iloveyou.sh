#!/bin/bash

# Girlfriend Appreciation Script 💖

chars="/-\|"

for i in {1..20}; do
    printf "\rLoading... ${chars:i%4:1}"
    sleep 0.1
done

printf "\nDone!\n"


clear
tput civis

pink='\033[1;35m'
red='\033[1;31m'
white='\033[1;37m'
cyan='\033[1;36m'
reset='\033[0m'

typewriter() {
    text="$1"
    speed="${2:-0.04}"

    for (( i=0; i<${#text}; i++ )); do
        printf "%s" "${text:$i:1}"
        sleep "$speed"
    done
    printf "\n"
}

# Intro animation
for i in {1..15}; do
    clear
    printf "\n\n\n"
    printf "%*s${pink}❤${reset}\n" "$i" ""
    sleep 0.06
done

clear

echo -e "${red}"
cat << "EOF"

██╗      ██████╗ ██╗   ██╗███████╗
██║     ██╔═══██╗██║   ██║██╔════╝
██║     ██║   ██║██║   ██║█████╗
██║     ██║   ██║╚██╗ ██╔╝██╔══╝
███████╗╚██████╔╝ ╚████╔╝ ███████╗
╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝

EOF

echo -e "${reset}"

sleep 1

echo -e "${cyan}Hey babe ❤️${reset}"
sleep 1

typewriter "I know this is just a Bash script..."
sleep 1

typewriter "but I wanted to make something for you anyway."
sleep 1.5

echo
echo -e "${pink}Thank you for:${reset}"
sleep 0.7

echo -e "${red}❤ making me smile${reset}"
echo -e "${red}❤ staying by my side${reset}"
echo -e "${red}❤ making ordinary days feel special${reset}"

sleep 1.5

echo
echo -e "${pink}You honestly mean a lot to me.${reset}"
sleep 1.5

echo

# Animated loading bar
bar=""

for i in {1..25}; do
    bar="${bar}❤"
    printf "\r${white}Calculating how much I love you:${reset} [%-25s]" "$bar"
    sleep 0.08
done

printf "\n\n"

sleep 1

echo -e "${red}Result:${reset} Infinite. ♾ ❤"
sleep 1

echo
echo -e "${cyan}Thanks for being my favorite person.${reset}"

echo
echo -e "${pink}Forever yours ❤️${reset}"

tput cnorm