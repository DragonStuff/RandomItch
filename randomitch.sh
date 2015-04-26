#!/bin/bash
#
# randomitch.sh
#
# Terrible Coding done by:
#
#   DragonStuff @DragonStuff
#

####  CONSTANTS  ####
USAGE="Usage: ./randomitch.sh [-q] [genre] [browser]\n  Standard Genres: XML_Free_Page/XML_Newest_Page/XML_Featured_Page/\n  Specific Genres: XML_Action_Page/XML_Platformer_Page/XML_Shooter_Page/XML_Adventure_Page/XML_RPG_Page/XML_Simulation_Page/XML_Strategy_Page/XML_Other_Page/XML_Puzzle_Page\n"

####    FLAGS    ####
#All flags are = 0 for on
#Quiet mode
QUIET=1

#### GLOBAL VARS ####
echo XML_Free_Page="http://itch.io/games/price-free.xml" > types.txt
echo XML_Newest_Page="http://itch.io/games/newest/price-free.xml" >> types.txt
echo XML_Featured_Page="http://itch.io/feed/featured/price-free.xml" >> types.txt

# Genres
echo XML_Action_Page="http://itch.io/games/genre-action/price-free.xml" >> types.txt
echo XML_Platformer_Page="http://itch.io/games/genre-platformer/price-free.xml" >> types.txt
echo XML_Shooter_Page="http://itch.io/games/genre-shooter/price-free.xml" >> types.txt
echo XML_Adventure_Page="http://itch.io/games/genre-adventure/price-free.xml" >> types.txt
echo XML_RPG_Page="http://itch.io/games/genre-rpg/price-free.xml" >> types.txt
echo XML_Simulation_Page="http://itch.io/games/genre-simulation/price-free.xml" >> types.txt
echo XML_Strategy_Page="http://itch.io/games/genre-strategy/price-free.xml" >> types.txt
echo XML_Other_Page="http://itch.io/games/genre-other/price-free.xml" >> types.txt
echo XML_Puzzle_Page="http://itch.io/games/genre-puzzle/price-free.xml" >> types.txt

# Browser Variable to Global
Browser=$2

####  FUNCTIONS  ####

function echoerr {
    if [[ ! ${QUIET} = 0 ]]; then
        if [[ ! -z ${TERM} ]]; then
            tput setaf 1
        fi
        echo "ERROR: "${@} 1>&2
        if [[ ! -z ${TERM} ]]; then
            tput sgr0
        fi
    fi
}

function echowarn {
    if [[ ! ${QUIET} = 0 ]]; then
        if [[ ! -z ${TERM} ]]; then
            tput setaf 3
        fi
        echo "WARNING: "${@}
        if [[ ! -z ${TERM} ]]; then
            tput sgr0
        fi
    fi
}

function echosucc {
    if [[ ! ${QUIET} = 0 ]]; then
        if [[ ! -z ${TERM} ]]; then
            tput setaf 2
        fi
        echo ${@}
        if [[ ! -z ${TERM} ]]; then
            tput sgr0
        fi
    fi
}

# Variables
#@param:
#        $1 Genre
#        $2 Browser

function randomGame() {
  local f=$1
  rm -f database_raw.txt
  wget -q -O database_raw.txt $(cat types.txt | grep $f | sed "s/^$f\=//")


  # XML Prettifier - Works perfectly!
  FILE_SIZE=$(du -k database_raw.txt | cut -f1)
  TMPNAME=$(basename $0)-$(basename database_raw.txt)
  TMPFILE=$(mktemp $TMPNAME.XXX) || exit 1

  echo "Prettifying itch.io's API: $INPUT_FILE ($FILE_SIZE Kbytes)..."
  xmllint --format database_raw.txt --output $TMPFILE
  mv $TMPFILE database_raw.txt

  # Now replace the database with links
  cat database_raw.txt | grep "<link>" | sed 's|</b>|-|g' | sed 's|<[^>]*>||g' > database_parsed.txt

  # Remove first line as it is a link of the actual page:
  tail -n +2 "database_parsed.txt"
  # It appears that the XML pages display 30 games, so let's generate a random number less than or equal to this.
  elementNumber=$(shuf -i 1-30 -n 1)
  # Now grab the Game($elementNumber)
  gameID=$(awk "NR==$elementNumber" database_parsed.txt)
  # Then call openGameInBrowser(url)
  # openGameInBrowser($url);
  echo -e YOUR GAME IS: $gameID
}

function openGameInBrowser() {
  # TODO (DragonStuff): Check whether the site is actually operating or not. Whatever.
  local f=$1
  # Check for existance of browser and open the game
  command -v $Browser >/dev/null && $Browser $f || echo "Browser: $Browser not found."
}

####   GETOPTS   ####
while getopts ":q" opt; do
    case $opt in
        q)
            QUIET=0
            ;;
        *)
            echoerr ${USAGE}
            exit 1
            ;;
    esac
done

####    MAIN     ####
function main {
    #shift after reading getopts
    shift $(($OPTIND - 1))
    #no args after flags, present usage message
    if [[ ${#@} = 0 ]]; then
        echo -e ${USAGE}
        exit 1
    fi
    randomGame $1
}

main "${@}"
