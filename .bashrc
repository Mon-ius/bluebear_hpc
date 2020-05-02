# =============================================================== #
#
# 
# PERSONAL $HOME/.bashrc FILE for bash-V3.0+ on BlueBear HPC
# By Mon-ius(https://github.com/Mon-ius)
# Last modified: Thu April 23 14:04:47  2020
#
# append the content manually or run the one click script.
#
#
# =============================================================== #

if [[ $(hostname -s) = bear* ]]; then
    module purge; module load bluebear;
    module load bear-apps/2019b &> /dev/null;
    module load PyTorch/1.4.0-fosscuda-2019b-Python-3.7.4 IPython/7.9.0-fosscuda-2019b-Python-3.7.4 Qt5/5.13.1-GCCcore-8.3.0 &> /dev/null;
fi