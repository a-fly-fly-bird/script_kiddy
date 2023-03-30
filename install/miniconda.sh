apt install -y wget
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
# -b – install in batch mode, more in bash miniconda.sh -h
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
# ~/miniconda3/bin/conda init zsh
source ~/.bashrc
conda config --set auto_activate_base false
