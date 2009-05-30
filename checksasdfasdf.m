		#
		!cat 0_fail.out* > fail
		#da 0_fail.out.0000
		da fail
		lines 1 10000000
		read {t 1 nstep 2 ti 3 tj 4 pflag 5}
		#
		set use=( (ABS(atan(r/h)-pi/4)<pi/150)&&(r>8)) ? 1 : 0
		set itr=sqrt(r**2+h**2) if(use)
		set it1=errorstress3 if(use)
		set it2=normstress3 if(use)
		set it3=force3 if(use)
		#
		
