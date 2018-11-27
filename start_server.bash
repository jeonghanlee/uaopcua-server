#!/bin/bash
#
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Tuesday, November 27 10:30:59 CET 2018
#   version : 0.0.1

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"
declare -gr SC_LOGDATE="$(date +%y%m%d%H%M)"


EXIST=1
NON_EXIST=0

SUDO="sudo"

function pushd { builtin pushd "$@" > /dev/null; }
function popd  { builtin popd  "$@" > /dev/null; }


function die
{
    error=${1:-1}
    ## exits with 1 if error number not given
    shift
    [ -n "$*" ] &&
	printf "%s%s: %s\n" "$scriptname" ${version:+" ($version)"} "$*" >&2
    exit "$error"
}


## if [[ $(checkIfFile "${release_file}") -eq "$NON_EXIST" ]]; then
#   NON_EXIT
## fi

function checkIfFile
{
    local file=$1
    local result=""
    if [ ! -e "$file" ]; then
	result=$NON_EXIST
	# doesn't exist
    else
	result=$EXIST
	# exist
    fi
    echo "${result}"	 
};


function checkIfVar()
{

    local var=$1
    local result=""
    if [ -z "$var" ]; then
	result=$NON_EXIST
	# doesn't exist
    else
	result=$EXIST
	# exist
    fi
    echo "${result}"
}

function start_server
{
    pushd "${HOME}/.wine/drive_c/Program Files/UnifiedAutomation/UaAnsiCServer/bin"
    wine uaserverc.exe &
    popd
}


function stop_server
{
    local pid=NON_EXIST;
    pid=$(ps a |grep uaserverc.exe | grep -v "grep" | awk '{print $1}')
    if [[ $(checkIfVar "${pid}") -eq "$NON_EXIST" ]]; then
	printf ">> Server is not running\n";
    else
	printf ">> Server is running with %s\n" "${pid}"
	printf "   Killing the running server ....\n"
	kill -9 ${pid}
    fi
}


function install_ini
{
    local settings=settings.ini
    local settings_path=${SC_TOP}/.ini
    
    pushd "${HOME}/.wine/drive_c/Program Files/UnifiedAutomation/UaAnsiCServer/bin"
    if [[ $(checkIfFile "${settings}") -eq "$EXIST" ]]; then
	printf "We've found %s, create the existent backup, and move it to %s with the suffix\n" "${settings}" "${settings_path}"
	mv ${settings} ${settings_path}/${settings}_${SC_LOGDATE}
    fi
   
    install -m 644 ${settings_path}/${settings} "${HOME}/.wine/drive_c/Program Files/UnifiedAutomation/UaAnsiCServer/bin"
}

case "$1" in
    start)
	start_server
	;;
    stop)
	stop_server
	;;
    restart)
	stop_server
	start_server
	;;
    install)
	install_ini
	;;
     *)
	echo "Usage: $0 {start|stop|restart|install}"
	exit 2
esac

exit





