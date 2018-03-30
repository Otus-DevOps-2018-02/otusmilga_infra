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
    echo "${green}[OK]${reset}... $@ >&2"
}

run_c git clone -b monolith https://github.com/express42/reddit.git
cd reddit
run_c bundle install
run_c puma -d

if [[ $state_fail -eq 1 ]]; then
    echo ""
    echo "${red}[FAIL]${reset} Script $0 failed. Check error log below."
    exit 1
else
    echo ""
    echo "${green}[OK]${reset}:Monolith reddit_app(https://github.com/express42/reddit.git) installed and started."
fi
exit 0

