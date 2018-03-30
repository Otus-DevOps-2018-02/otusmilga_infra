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

run_c git clone -b monolith https://github.com/express42/reddit.git
cd reddit
run_c bundle install
run_c puma -d

if [[ $state_fail -eq 1 ]]; then
    echo "[FAIL] Script $0 failed. Check error log below."
    exit 1
else
    echo "[OK]:Monolith reddit_app(https://github.com/express42/reddit.git) installed and started."
fi
exit 0

