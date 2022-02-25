EXPID=01
DURATION=0
FRAGSIZE=128
SRATE=48000
INFILE="male_speech.wav"
FILES="rotating_receiver_nsp_720_speaker_conv.tsc"

for FILE in $FILES
do
   start_time=$(date +%s.%3N)
   echo tascar_renderfile --dynamic --srate $SRATE --inputfile $INFILE --outputfile out_${EXPID}_$FILE.wav  --duration $DURATION --fragsize $FRAGSIZE $FILE
   tascar_renderfile --dynamic --srate $SRATE --inputfile $INFILE --outputfile out_${EXPID}_$FILE.wav  --duration $DURATION --fragsize $FRAGSIZE $FILE
   end_time=$(date +%s.%3N)
   elapsed=$(echo "scale=3; $end_time - $start_time" | bc)
   echo ==========
   echo =
   echo $FILE $elapsed
   echo =
   echo ==========
done
