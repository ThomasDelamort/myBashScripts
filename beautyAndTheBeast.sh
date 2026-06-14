#!/usr/bin/env bash
#
# beauty_and_the_beast.sh
# A terminal storytelling animation of the classic fairy tale
# (an original retelling of the public-domain tale by Beaumont, 1756).
#
# Usage:
#   ./beauty_and_the_beast.sh            normal speed, press Enter between scenes
#   ./beauty_and_the_beast.sh fast       quicker typing
#   ./beauty_and_the_beast.sh auto       types itself and auto-advances (hands-free)
#   ./beauty_and_the_beast.sh instant    no delays at all (for testing)
#
# Press Ctrl-C any time to quit — the cursor will be restored.

# ----------------------------------------------------------------------
# Colors & styles
# ----------------------------------------------------------------------
RESET=$'\e[0m'
BOLD=$'\e[1m'
DIM=$'\e[2m'
NARRATOR=$'\e[38;5;252m'   # soft white
BEAUTY=$'\e[38;5;218m'     # pink
BEAST=$'\e[1m'$'\e[38;5;131m'  # bold muted red
MERCHANT=$'\e[38;5;179m'   # warm gold
PRINCE=$'\e[38;5;111m'     # soft blue
ROSE=$'\e[38;5;161m'       # deep rose
GOLD=$'\e[38;5;220m'
GRAY=$'\e[38;5;245m'
GREEN=$'\e[38;5;107m'

# ----------------------------------------------------------------------
# Speed settings (chosen by the run mode argument)
# ----------------------------------------------------------------------
case "${1:-}" in
  fast)    SPEED=0.008; PUNCT=0.05; COMMA=0.02 ;;
  auto)    SPEED=0.028; PUNCT=0.20; COMMA=0.08; AUTO=1; AUTO_PAUSE=1.4 ;;
  instant) SPEED=0;     PUNCT=0;    COMMA=0;    AUTO=1; AUTO_PAUSE=0 ;;
  *)       SPEED=0.028; PUNCT=0.20; COMMA=0.08 ;;
esac

# ----------------------------------------------------------------------
# Cleanup: always restore the cursor and reset colors on exit
# ----------------------------------------------------------------------
cleanup() { printf '%s' "$RESET"; tput cnorm 2>/dev/null; }
trap cleanup EXIT
trap 'cleanup; exit 130' INT TERM
tput civis 2>/dev/null   # hide cursor while the show runs

# ----------------------------------------------------------------------
# Helpers
# ----------------------------------------------------------------------

# Type a paragraph one character at a time, wrapping it neatly to the
# terminal width and pausing a little longer on punctuation.
say() {
  local text="$1" color="${2:-$NARRATOR}"
  local width; width=$(tput cols 2>/dev/null || echo 80)
  (( width > 76 )) && width=76
  local wrapped; wrapped=$(printf '%s\n' "$text" | fold -s -w "$width")
  printf '%s' "$color"
  local i char
  for (( i=0; i<${#wrapped}; i++ )); do
    char="${wrapped:i:1}"
    printf '%s' "$char"
    sleep "$SPEED"
    case "$char" in
      '.'|'!'|'?') sleep "$PUNCT" ;;
      ','|';'|':')  sleep "$COMMA" ;;
    esac
  done
  printf '%s\n' "$RESET"
}

# A line of spoken dialogue, prefixed with the speaker's name.
speak() { say "$1: \"$2\"" "$3"; }

# Center one line of text.
center() {
  local text="$1" color="${2:-$RESET}"
  local width; width=$(tput cols 2>/dev/null || echo 80)
  local pad=$(( (width - ${#text}) / 2 ))
  (( pad < 0 )) && pad=0
  printf '%*s%s%s%s\n' "$pad" '' "$color" "$text" "$RESET"
}

# Print a block of ASCII art (passed on stdin) in a given color.
art() {
  local color="$1"
  printf '%s' "$color"
  cat
  printf '%s' "$RESET"
}

# Wait for the reader (or auto-advance in auto/instant mode).
pause() {
  echo
  if [[ -n "${AUTO:-}" ]]; then sleep "${AUTO_PAUSE:-1.4}"; return; fi
  center "( press Enter to continue )" "$GRAY"
  read -r _
}

# Start a fresh scene.
scene() { clear; echo; echo; }

# ----------------------------------------------------------------------
# Story
# ----------------------------------------------------------------------

title_screen() {
  scene
  echo
  art "$ROSE" <<'ART'
                          @@@@@
                        @@@@@@@@@
                       @@@@@@@@@@@
                        @@@@@@@@@
                          \ | /
                           \|/
                            |
                           /|\
                            |
ART
  echo
  center "B E A U T Y   A N D   T H E   B E A S T" "$BOLD$ROSE"
  echo
  center "an old tale, told anew" "$GRAY"
  echo; echo
  pause
}

scene_one() {
  scene
  say "Once, in a busy city by the sea, there lived a wealthy merchant and his three daughters."
  say "The two eldest were proud and fond of fine things. But the youngest was so gentle and so kind that everyone simply called her Beauty."
  say "Then misfortune came. The merchant's ships were lost at sea, his fortune sank beneath the waves, and the family had to leave their grand house for a small cottage at the edge of a dark wood."
  pause
}

scene_two() {
  scene
  say "One day, word arrived that a single one of the lost ships had limped back into port."
  say "The merchant saddled his horse to claim what cargo remained. His eldest daughters clamored for silk gowns and jewels."
  say "But Beauty asked for only one small thing."
  speak "Beauty" "Bring me a single rose, Father. None grow near our new home, and I miss them dearly." "$BEAUTY"
  pause
}

scene_three() {
  scene
  say "At the port, creditors had already seized every last crate. The merchant turned for home with empty pockets and a heavy heart."
  say "Then a storm rose. Snow swallowed the road, and his horse lost its way among the trees."
  say "Half-frozen, he saw a light glowing through the dark, and stumbled upon a castle, its great gates standing open."
  echo
  art "$GRAY" <<'ART'
            |T|             |T|             |T|
           _|_|_           _|_|_           _|_|_
          |     |         |     |         |     |
          |  +  |_________|  +  |_________|  +  |
       ___|     |    _    |     |    _    |     |___
      |         |   | |   |     |   | |   |         |
      |   []    |   |_|   |  +  |   |_|   |    []   |
      |_________|_________|_____|_________|_________|
ART
  echo
  say "Inside, a fire crackled and a table stood laid with hot supper, though not a single soul could be seen. Grateful beyond words, the merchant ate, and slept."
  pause
}

scene_four() {
  scene
  say "At dawn the storm had vanished, and a garden lay in glorious bloom outside his window."
  say "Remembering his promise, the merchant plucked a single rose."
  say "At once, a terrible roar shook the air."
  echo
  art "$BEAST" <<'ART'
                       \         /
                        \_     _/
                        (o)   (o)
                       /    ^    \
                      |   '-----'  |
                       \   WWWWW   /
                        '---------'
ART
  echo
  say "A Beast loomed before him -- fanged, towering, robed like a lord."
  speak "The Beast" "I gave you shelter and food, and you repay me by stealing the one thing I love. For this, you shall die!" "$BEAST"
  pause
}

scene_five() {
  scene
  say "The merchant fell to his knees and begged for mercy, explaining the rose was a gift for his youngest daughter."
  say "The Beast grew quiet, and thought for a long moment."
  speak "The Beast" "Then go home. But one of your daughters must return in your place, of her own free will -- or you yourself must come back to die. You have three days." "$BEAST"
  pause
}

scene_six() {
  scene
  say "The merchant returned and, weeping, told his family everything. He meant only to bid them farewell."
  say "But when Beauty heard that her small wish had cost her father his life, she rose without a moment's hesitation."
  speak "Beauty" "It was my wish that brought this sorrow. I will go, and gladly, if it spares you." "$BEAUTY"
  say "And though they all wept, she set out for the castle alone."
  pause
}

scene_seven() {
  scene
  say "To Beauty's great surprise, the Beast did her no harm at all."
  say "He gave her fine rooms, gardens to wander, and shelves of wonderful books. He asked for nothing -- only that she dine with him each evening."
  say "He was gruff, and fearsome to look upon, yet his words were gentle and edged with sadness. And every night, he asked her the same question."
  speak "The Beast" "Beauty, will you marry me?" "$BEAST"
  speak "Beauty" "No, Beast." "$BEAUTY"
  say "Always she answered kindly, and always the same. Yet as the weeks passed, she found herself waiting for his company -- and missing it when he was gone."
  pause
}

scene_eight() {
  scene
  say "One evening the Beast gave her a mirror that could show her anything she wished to see."
  say "In its glass she saw her father, grey and ill with grief, certain that she was lost forever."
  speak "Beauty" "Please -- let me go to him. Only for a week. I give you my word I will return." "$BEAUTY"
  say "The Beast's heart sank, but he loved her far too well to refuse."
  speak "The Beast" "Go. But if you do not return, I fear I shall die of sorrow. Take this ring; turn it upon your finger, and you will be home at once." "$BEAST"
  pause
}

scene_nine() {
  scene
  say "Beauty's father wept for joy to see her alive and well."
  say "But her sisters, jealous of her fine clothes and kind heart, secretly schemed to keep her past the appointed week -- hoping the Beast would grow angry and punish her."
  say "Caught up in the warmth of home, Beauty let the days slip quietly by."
  pause
}

scene_ten() {
  scene
  say "On the tenth night, she dreamed of the Beast lying still in his garden, near death."
  say "She woke with a cry, turned the ring upon her finger, and in a single heartbeat stood once more at the castle gates."
  say "She ran to the rose garden -- and there she found him, collapsed beside the wilting roses, barely breathing."
  pause
}

scene_eleven() {
  scene
  speak "Beauty" "Oh, please do not die! I was a fool to leave you. I know now what I could not say before -- I love you." "$BEAUTY"
  say "And as her tears fell upon him, a warm light bloomed all around them."
  echo
  art "$GOLD" <<'ART'
                      .   *       .    *
                   *    \   |   /    *
                      .   \  |  /   .
                  *  - - -  (*)  - - -  *
                      '   /  |  \   '
                   *    /   |   \    *
                      *       .    *   .
ART
  echo
  say "The fur, the fangs, the terrible shape -- all melted away. In her arms lay a young prince, gazing up at her with wonder."
  speak "The Prince" "A cruel enchantment bound me in that monstrous form, until someone could love me for my heart alone. You have set me free." "$PRINCE"
  pause
}

scene_twelve() {
  scene
  say "They were married beneath the roses, and the castle filled once more with light and laughter and song."
  echo
  art "$ROSE" <<'ART'
                      ,d88b.d88b,
                      88888888888
                      `Y8888888Y'
                        `Y888Y'
                          `Y'
ART
  echo
  say "And they lived, as such tales always promise, happily ever after."
  echo; echo
  center "~  T H E   E N D  ~" "$BOLD$ROSE"
  echo; echo
  if [[ -z "${AUTO:-}" ]]; then center "( press Enter to close )" "$GRAY"; read -r _; fi
  echo
}

# ----------------------------------------------------------------------
# Run the show
# ----------------------------------------------------------------------
main() {
  title_screen
  scene_one
  scene_two
  scene_three
  scene_four
  scene_five
  scene_six
  scene_seven
  scene_eight
  scene_nine
  scene_ten
  scene_eleven
  scene_twelve
}

main