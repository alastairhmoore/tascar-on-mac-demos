 # pass a single input which is the path to mha
source /Users/amoore1/git/alastairhmoore/openMHA/bin/thismha.sh
echo $PATH
echo $LD_LIBRARY_PATH

# source $1/bin/thismha.sh
# echo $PATH
# echo $LD_LIBRARY_PATH

mha ?read:hrtf_receiver_with_mha_script.cfg io.name=mha port=33337 cmd=start
