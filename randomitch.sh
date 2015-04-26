#!/bin/bash
#
# randomitch.sh
#
#Authors:
#
#   DragonStuff @DragonStuff
#

####  CONSTANTS  ####
USAGE="Usage: ./ [-q] "

####    FLAGS    ####
#All flags are = 0 for on
#Quiet mode
QUIET=1

#### GLOBAL VARS ####

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

#[DESCRIPTION]
#@param:
#        $1
#        $2
#
#@return:
#        - var1
#        - var2
#
#@global:
#        - var1
#        - var2
function name {
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
}

main "${@}"

// TODO: Test
http://itch.io/games/price-free.xml
