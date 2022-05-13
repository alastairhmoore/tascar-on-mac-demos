date_cmd=gdate # use this one on macos
# date_cmd=date # use this one on linux
EXPID=01
FRAGSIZE=128
SRATE=48000
INFILE="pink_noise"  # 1 second long - relatively quick to render (about 19 seconds)
# INFILE="male_speech" # 30 seconds long - will take a long time to render with not visual indication it is working

CHANMAP=720-723 # 720 virtual speaker feeds can be ignored, 4 microphones output of convolution come next
SCN_FILES="rotating_receiver_nsp_720_speaker_conv.tsc rotating_receiver_vbap_720_speaker_conv.tsc"

for FILE in $SCN_FILES
do
   start_time=$($date_cmd +%s.%3N)
   echo tascar_renderfile --dynamic --srate $SRATE --inputfile $INFILE.wav --outputfile out_${EXPID}__${INFILE}__$FILE.wav  --fragsize $FRAGSIZE --channelmap $CHANMAP $FILE
   tascar_renderfile --dynamic --srate $SRATE --inputfile $INFILE.wav --outputfile out_${EXPID}__${INFILE}__$FILE.wav  --fragsize $FRAGSIZE --channelmap $CHANMAP $FILE
   end_time=$($date_cmd +%s.%3N)
   elapsed=$(echo "scale=3; $end_time - $start_time" | bc)
   echo ==========
   echo =
   echo $FILE $elapsed
   echo =
   echo ==========
done
