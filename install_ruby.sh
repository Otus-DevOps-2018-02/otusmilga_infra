#!/usr/bin/env bash

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

function run_c {
    cmd_output=$($@)
    local status=$?
    if [ $status -ne 0 ]; then
        echo "${red}[FAILED]${reset}... $@"
	state_fail=1
    fi
    echo "${green}[OK]${reset}... $@" >&2
}

run_c sudo apt-get --yes update 
run_c sudo apt-get install --yes ruby-full ruby-bundler build-essential
run_c ruby -v 
run_c bundle -v

BUNDLER_VER='bundle -v'
RUBY_VER=$(ruby -v | awk {'print $2'})
RUBY_DEST=$(which ruby)
BUNDLER_VER=$(bundle -v | awk {'print $3'})

if [[ $state_fail -eq 1 ]]; then
    echo ""
    echo "${red}[FAIL]${reset} Script $0 failed. Check error log below."
    exit 1
else
    echo ""
    echo "${green}[OK]${reset}:Ruby: ${RUBY_VER} ruby at ${RUBY_DEST} installed with bundler (${BUNDLER_VER})"
fi
exit 0

