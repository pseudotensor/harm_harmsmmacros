rebecaphi1 0   #
		define DOGCALC 0
		jrdp3duold dump0133
		#
		fieldcalc 0 aphi
		plc 0 aphi
		define cres 90
		#
		#
		# do this for now because aphi generates 2D data
		define nz 1
		set _n3=$nz
		#
		set _MBH=1
		set _QBH=0
		jre fieldline.m
		setupbasicdirs
		#
		interps3d aphi 256 512 0 20 -10 10
		readinterp3d aphi
		#
		plc 0 iaphi
		#
