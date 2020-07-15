#!/bin/bash

#SBATCH --job-name=code-sever
#SBATCH --qos castlespowergpu
#SBATCH --gres gpu:v100:2
#SBATCH --time=9-23:59:00
#SBATCH --cpus-per-task=30
#SBATCH --mem=200G

module purge; module load bluebear;
module load bear-apps/2019b;
module load PyTorch/1.4.0-fosscuda-2019b-Python-3.7.4;
module load IPython/7.9.0-fosscuda-2019b-Python-3.7.4;
module load git
module load VSCode/3.4.0-GCCcore-8.3.0

nvidia-smi 

port=8081
export PASSWORD=duanj
work_dir="$HOME/project-cs"
data_dir="$HOME/.local/share/bc_uob_codeserver"

if  ! [ -d $work_dir ]; then
    mkdir $work_dir
fi

code-server \
    --auth=password \
    --port=$port \
    --disable-telemetry \
    --extra-extensions-dir="$data_dir/extensions" \
    --user-data-dir="$data_dir" \
    "$work_dir"

cat $HOME/.config/code-server/config.yaml