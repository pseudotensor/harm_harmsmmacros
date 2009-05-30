export smpath=`pwd`
export myfile=`echo $smpath | sed 's/\/home\/jon\/grmhd/joncalc3tavg.txt/'`
echo $myfile
scp joncalc3tavg.txt metric:research/bz/$myfile

