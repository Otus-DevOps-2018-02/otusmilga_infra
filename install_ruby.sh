#!/usr/bin/env bash

function run_c {
    cmd_output=$($@)
    local status=$?
    if [ $status -ne 0 ]; then
        echo "[FAILED]... $@"
	state_fail=1
    fi
    echo "[OK]... $@"
}

run_c sudo apt-get --yes update 
run_c sudo apt-get install --yes ruby-full ruby-bundler build-essential
run_c ruby -v 
run_c bundle -v

if [[ $state_fail -eq 1 ]]; then
    echo ""
    echo "[FAIL] Script $0 failed. Check error log below."
    exit 1
else
    echo ""
    echo "[OK]:Ruby: ruby with bundler installed"
fi
exit 0

