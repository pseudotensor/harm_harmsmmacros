baniset 0  # using 456^2 simulations
		#
		jrdp dump0040
		#
		set C=2.99792458E10
		set KB=1.3807E-16
		set MP=1.67262158E-24
		set myrho=rho
		set mytemp=p/rho
		set myv1=uu1
		set myv2=uu2
		#
		greaddump dumptavg2040v2withhead
		set myv12=uu1
		set myv22=uu2
		set myrho2=rho
		set mytemp2=p/rho
		#
output 0                #
		define print_noheader (0)
		print "dumps/disk.dat" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		 {ti tj r h myrho myrho2 mytemp mytemp2 myv1 myv12 myv2 myv22}
