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

nvidia-smi 

install_dir="$HOME/.local/codeServer"
work_dir="$HOME/project-cs"
data_dir="$HOME/.local/share/bc_uob_codeserver"
client="$HOME/.yarn/bin/code-server"

# rm -rf $install_dir $HOME/.cache $HOME/.yarn* $HOME/.npm $HOME/.config

getCodeSever () {
    mkdir -p "$data_dir/extensions"
    mkdir $install_dir && cd $install_dir
    wget http://nodejs.org/dist/v14.3.0/node-v14.3.0-linux-ppc64le.tar.gz && tar -xvf ./*.tar.gz > /dev/null
    cd $install_dir/node-v14.3.0-linux-ppc64le/bin
    export PATH=$(pwd):$PATH
    npm install -g yarn > /dev/null
    yarn global add code-server > /dev/null
} 

if  ! [ -d $work_dir ]; then
    mkdir $work_dir
fi

if  ! [ -d $install_dir ] ||  ! [ -f $client ] ; then
    getCodeSever
else
    export PATH=$install_dir/node-v14.3.0-linux-ppc64le/bin:$PATH
    >&1 echo -e '\033[1;32m'Success! '\033[0m' The code-sever already installed:'\033[4;34m'$client'\033[0m'
fi

port=8081
export PASSWORD=duanj
$client \
    --auth=password \
    --port=$port \
    --disable-telemetry \
    --extra-extensions-dir="$data_dir/extensions" \
    --user-data-dir="$data_dir" \
    "$work_dir"

cat $HOME/.config/code-server/config.yaml