 # pass a single input which is the path to mha
# source /home/alastair/git/alastairhmoore/openMHA/bin/thismha.sh
echo $PATH
echo $LD_LIBRARY_PATH

source $1/bin/thismha.sh
echo $PATH
echo $LD_LIBRARY_PATH

sudo env "PATH=$PATH" env "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"  mha ?read:mha.cfg io.name=mha port=33337 cmd=start
