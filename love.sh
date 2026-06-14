#!/bin/bash
# Romantic Bash Script 💖
clear
tput civis
pink='\033[1;35m'
red='\033[1;31m'
cyan='\033[1;36m'
reset='\033[0m'
type_text () {
    text="$1"
    delay="${2:-0.04}"
    for (( i=0; i<${#text}; i++ )); do
        printf "${text:$i:1}"
        sleep "$delay"
    done
    printf "\n"
}
# Floating hearts animation
for i in {1..20}; do
    clear
    printf "${pink}"
    for j in $(seq 1 $i); do
        printf " "
    done
    echo "❤"
    sleep 0.05
done
clear
echo -e "${red}"
cat << "EOF"
      ❤     ❤
    ❤    ❤    ❤
   ❤            ❤
   ❤            ❤
    ❤          ❤
      ❤      ❤
        ❤  ❤
          ❤
EOF
echo -e "${reset}"
sleep 1
echo -e "${cyan}Hey you...${reset}"
sleep 1
type_text "I just wanted to say something."
sleep 1
type_text "Every time you show up..."
sleep 1
type_text "my day gets a lot better."
sleep 1
type_text "And honestly?"
sleep 1
type_text "I really like you. ❤"
echo
type_text "So I made this tiny Bash script for you :)"
sleep 1
echo
printf "${pink}"
# Cute loading bar
bar=""
for i in {1..30}; do
    bar="${bar}❤"
    printf "\rSending affection [%-30s]" "$bar"
    sleep 0.08
done
printf "\n${reset}"
sleep 1
echo
echo -e "${red}Mission Complete.${reset}"
echo -e "${pink}You have successfully stolen my attention. ❤${reset}"
echo
tput cnorm