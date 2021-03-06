#!/bin/bash

#SBATCH --job-name=code-sever
#SBATCH --qos castlespowergpu
#SBATCH --gres gpu:v100:2
#SBATCH --time=9-23:59:00
#SBATCH --cpus-per-task=30
#SBATCH --mem=200G

module purge; module load bluebear;
module load bear-apps/2019b;
module load BEAR-Python-DataScience/2019b-fosscuda-2019b-Python-3.7.4-ppc64le;
module load git;
module load VSCode/3.4.0-GCCcore-8.3.0;

nvidia-smi

# rm -rf $install_dir $HOME/.cache $HOME/.yarn* $HOME/.npm $HOME/.config
port=8081
export PASSWORD=duanj
work_dir="$HOME/projects"
data_dir="$HOME/.vscode"

if  ! [ -d $work_dir ]; then
    mkdir $work_dir
fi

if  ! [ -d $data_dir ]; then
    mkdir $data_dir
fi

# Noticed that the python plugin need to be downgraded to 2020.5.x, the 2020.6.x has bugs not yet fixed.

code-server \
    --auth=password \
    --port=$port \
    --disable-telemetry \
    --extra-extensions-dir="$data_dir/extensions" \
    --user-data-dir="$data_dir" \
    "$work_dir"

cat $HOME/.config/code-server/config.yaml