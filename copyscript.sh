export smpath=`pwd`
export myfile=`echo $smpath | sed 's/\/home\/jon\/grmhd/joncalc2tavg.txt/'`
echo $myfile
scp joncalc2tavg.txt metric:research/spinup/$myfile

