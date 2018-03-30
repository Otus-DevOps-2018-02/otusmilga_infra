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

run_c sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
run_c sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
run_c sudo apt-get --yes update
run_c sudo apt-get install --yes mongodb-org
run_c sudo systemctl start mongod
run_c sudo systemctl enable mongod

MONGO_VER=$(mongod --version | head -n 1 | awk {'print $3'} )

if [[ $state_fail -eq 1 ]]; then
    echo ""
    echo "${red}[FAIL]${reset} Script $0 failed. Check error log below."
    exit 1
else
    echo ""
    echo "${green}[OK]${reset}:mongo(${MONGO_VER}) installed"
fi
exit 0

