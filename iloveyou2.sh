#!/bin/bash

clear
tput civis

# Colors
pink='\033[38;5;213m'
hotpink='\033[38;5;205m'
purple='\033[38;5;99m'
cyan='\033[1;36m'
white='\033[1;37m'
red='\033[1;31m'
reset='\033[0m'
bold='\033[1m'

typewriter() {
    text="$1"
    speed="${2:-0.03}"

    for (( i=0; i<${#text}; i++ )); do
        printf "%s" "${text:$i:1}"
        sleep "$speed"
    done

    printf "\n"
}

heartbeat() {
    for i in {1..2}; do
        clear

        echo -e "${hotpink}"
cat << "EOF"

      ❤     ❤
   ❤           ❤
  ❤             ❤
  ❤             ❤
   ❤           ❤
      ❤     ❤
         ❤

EOF
        echo -e "${reset}"

        sleep 0.4

        clear

        echo -e "${pink}"
cat << "EOF"

    ❤ ❤ ❤ ❤
  ❤    ❤    ❤
 ❤            ❤
 ❤            ❤
  ❤          ❤
    ❤ ❤ ❤ ❤
        ❤

EOF
        echo -e "${reset}"

        sleep 0.4
    done
}

# Loading animation
chars="♥♡"

for i in {1..30}; do
    printf "\r${pink}Loading something special... ${chars:i%2:1}${reset}"
    sleep 0.07
done

sleep 0.5
clear

heartbeat
clear

echo -e "${purple}"
echo "╔══════════════════════════════╗"
echo "║        FOR MY GIRL ❤️         ║"
echo "╚══════════════════════════════╝"
echo -e "${reset}"

sleep 1

echo
echo -e "${cyan}${bold}Hey babe ❤️${reset}"

sleep 1

echo
typewriter "I know this is just a Bash script..."
sleep 1

typewriter "but I wanted to make something special for you."
sleep 1.5

echo
echo -e "${pink}Things I love about you:${reset}"
sleep 0.7

things=(
"❤ Your smile"
"❤ Your laugh"
"❤ The way you make my days better"
"❤ Every moment with you"
)

for item in "${things[@]}"; do
    echo -e "${hotpink}$item${reset}"
    sleep 0.9
done

sleep 1

echo
echo -e "${cyan}Calculating how much I love you...${reset}"

bar=""

for i in {1..30}; do
    bar="${bar}█"
    printf "\r${pink}[%-30s]${reset}" "$bar"
    sleep 0.06
done

printf "\n\n"

sleep 1

echo -e "${red}${bold}RESULT:${reset} Infinite ❤️"
sleep 1

echo
typewriter "Thanks for being my favorite person."
sleep 1

echo
echo -e "${hotpink}${bold}Forever yours ❤️${reset}"

echo
tput cnorm