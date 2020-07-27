#!/bin/bash
module purge; module load bluebear;
module load bear-apps/2019b;
module load BEAR-Python-DataScience/2019b-fosscuda-2019b-Python-3.7.4-ppc64le;
module load git;
module load VSCode/3.4.0-GCCcore-8.3.0;

tmux new -s vscode

port=8081
export PASSWORD=duanj
work_dir="$HOME/projects"
data_dir="$HOME/.vscode"

/usr/bin/ssh -Nf -R $port:127.0.0.1:$port bb-pg-login01

if  ! [ -d $work_dir ]; then
    mkdir $work_dir
fi

if  ! [ -d $data_dir ]; then
    mkdir $data_dir
fi

code-server \
    --auth=password \
    --port=$port \
    --disable-telemetry \
    --extra-extensions-dir="$data_dir/extensions" \
    --user-data-dir="$data_dir" \
    "$work_dir"


