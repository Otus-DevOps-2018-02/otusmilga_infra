#!/usr/bin/env bash

function run_c {
    cmd_output=$($@)
    local status=$?
    if [ $status -ne 0 ]; then
        echo "[FAILED]... $@"
	state_fail=1
    fi
    echo "[OK]... $@" >&2
}

run_c sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
run_c sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'
run_c sudo apt -yes update
run_c sudo apt install -y mongodb-org
run_c sudo systemctl start mongod
run_c sudo systemctl enable mongod

if [[ $state_fail -eq 1 ]]; then
    echo "[FAIL] Script $0 failed. Check error log below."
    exit 1
else
    echo ""
    echo "[OK]:mongo installed"
fi
exit 0

