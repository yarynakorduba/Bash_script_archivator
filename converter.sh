#!/bin/bash
cd ~
declare DIR=OpSys;
declare DAYS=1;
declare EXT=zip;

while getopts 'p:i:c:' opt; do #gives an ability to specify the path and the unique number starting point
  case $opt in
    p)
      echo "PATH: " $OPTARG
      cd
      DIR=$OPTARG
      cd $OPTARG
      echo " -p: Path chosen!" >&2
      ;;
    i)
      DAYS=$OPTARG
      echo " -i: Number of days chosen!" >&2	
      ;;
    c)
      EXT=$OPTARG
      echo " -c: EXT chosen!" >&2	
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

for f in *.*

	do
		 let AGE=($(($(date "+%s") - $(date -r $f "+%s"))) / 86400)
                 echo $AGE;
		 DIR=$(dirname $(readlink -f $f)) 
		 DIR1=${DIR:1}                    #cuts from the first element of the string 
		 DIR2=${DIR1////-}                #changes all / into -
		 echo Days $DAYS
		 DATE=$(date "+%S_%M_%H-%d-%m-%y")

		if [ "$AGE" -gt "$DAYS" ]; then
                        echo YES
			$EXT $DIR2-$DATE.$EXT $f
		fi	
done	 
