# =============================================================== #
#
# 
# PERSONAL $HOME/jduan.sh sbatch FILE for Slurm  on BlueBear HPC
# By Mon-ius(https://github.com/Mon-ius)
# Last modified: Thu April 23 14:04:47  2020
#
# Create the file manually or run the one click script.
#
#
# =============================================================== #
#!/bin/bash 
#SBATCH --job-name=duanj 
#SBATCH --qos bbpowergpu 
#SBATCH --gres gpu:v100:1 
#SBATCH --cpus-per-task=20
#SBATCH --time=00:10:00 
#SBATCH --mail-type ALL 
module purge; module load bluebear; 
module load bear-apps/2019b; 
module load PyTorch/1.4.0-fosscuda-2019b-Python-3.7.4; 
module load IPython/7.9.0-fosscuda-2019b-Python-3.7.4; 
module load BEAR-Python-DataScience/2019b-fosscuda-2019b-Python-3.7.4-ppc64le;
export XDG_RUNTIME_DIR="" 
port=8080 
sport=2020 
/usr/bin/ssh -Nf -R $port:127.0.0.1:$port bb-pg-login02 
/usr/bin/ssh -Nf -R $sport:127.0.0.1:22 bb-pg-login02 
nvidia-smi 
echo 2333 
jupyter notebook --no-browser --port $port --notebook-dir=$(pwd) 