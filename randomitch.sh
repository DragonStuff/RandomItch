#!/bin/bash
#
# randomitch.sh
#
#Authors:
#
#   DragonStuff @DragonStuff
#

####  CONSTANTS  ####
USAGE="Usage: ./randomitch.sh [-q] [genre] [browser]"

####    FLAGS    ####
#All flags are = 0 for on
#Quiet mode
QUIET=1

#### GLOBAL VARS ####
XML_Free_Page = "http://itch.io/games/price-free.xml"
XML_Newest_Page = "http://itch.io/games/newest/price-free.xml"
XML_Featured_Page = "http://itch.io/feed/featured/price-free.xml"

# Genres
XML_Action_Page = "http://itch.io/games/genre-action/price-free.xml"
XML_Platformer_Page = "http://itch.io/games/genre-platformer/price-free.xml"
XML_Shooter_Page = "http://itch.io/games/genre-shooter/price-free.xml"
XML_Adventure_Page = "http://itch.io/games/genre-adventure/price-free.xml"
XML_RPG_Page = "http://itch.io/games/genre-rpg/price-free.xml"
XML_Simulation_Page = "http://itch.io/games/genre-simulation/price-free.xml"
XML_Strategy_Page = "http://itch.io/games/genre-strategy/price-free.xml"
XML_Other_Page = "http://itch.io/games/genre-other/price-free.xml"
XML_Puzzle_Page = "http://itch.io/games/genre-puzzle/price-free.xml"

# Browser Variable to Global
Browser = $2

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
  local f = $1
  # It appears that the XML pages display 30 games, so let's generate a random number less than or equal to this.
  elementNumber = $(( r %= 30 ))

  # Now grab the Game($elementNumber)
  
  # Then call openGameInBrowser(url)

}

function openGameInBrowser() {
  # TODO (DragonStuff): Check whether the site is actually operating or not. Whatever.
  local f = $1
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
        echoerr ${USAGE}
        exit 1
    fi
    randomGame($1);
}

main "${@}"
