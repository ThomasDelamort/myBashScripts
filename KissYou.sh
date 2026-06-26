#!/bin/bash

lyrics=(
    "SO TELL ME GIRL IF EVERYTIME WE"
    "TOUCH"
    "YOU GET THIS KINDA RUSH"
    "BABY, SAY, YEAH, YEAH, YEAH,"
    "YEAH, YEAH, YEAH"
    "IF YOU DON'T WANNA TAKE IT SLOW"
    "AND YOU JUST WANNA TAKE ME HOME"
    "BABY SAY YEAH, YEAH, YEAH"
    "YEAH YEAH"
    "AND LET ME KISS YOU"
)

draw_screen() {
    local text="$1"

    clear

    cols=$(tput cols)

    printf "%*s\n" $(( (cols+70)/2 )) "✦･ﾟ: *✧･ﾟ:* KISS YOU *:･ﾟ✧*:･ﾟ✦"
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo

    figlet -c "$text"

    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    printf "%*s\n" $(( (cols+18)/2 )) "★ ONE DIRECTION ★"
    echo
}

show_line() {
    local line="$1"
    local partial=""

    # Loading animation
    for dots in "." ".." "..."; do
        clear

        cols=$(tput cols)

        printf "%*s\n\n" $(( (cols+70)/2 )) "✦･ﾟ: *✧･ﾟ:* KISS YOU *:･ﾟ✧*:･ﾟ✦"
        printf "%*s\n" $(( (cols+${#dots})/2 )) "$dots"

        sleep 0.05
    done

    # Typing animation
    for ((i=0; i<${#line}; i++)); do
        partial+="${line:$i:1}"

        draw_screen "${partial}▋"

        sleep 0.03
    done

    # Show completed line
    draw_screen "$line"

    # Pause between lyrics
    if [[ "$line" == "AND LET ME KISS YOU" ]]; then
        sleep 2
    else
        sleep 1.5
    fi
}

clear

cols=$(tput cols)

echo
echo
printf "%*s\n" $(( (cols+32)/2 )) "♫ NOW PLAYING ♫"
echo

figlet -c "KISS YOU"

echo
printf "%*s\n" $(( (cols+18)/2 )) "★ ONE DIRECTION ★"

sleep 2

for line in "${lyrics[@]}"; do
    show_line "$line"
done

clear

echo
echo

figlet -c "THANK YOU"

echo
printf "%*s\n" $(( (cols+26)/2 )) "✦ KEEP SINGING ✦"

echo