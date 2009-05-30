spindown 0      # 18 values
		# sign change for da/dt -> dj/dt
		#
		set a={-0.938 0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5 0.6 0.75 0.875 0.895 0.9 0.938 0.969}
		set hor={0.211 0.266 0.280 0.280 0.299 0.308 0.323 0.253 0.261 0.185 0.204 0.220 0.248 0.261 0.266 0.261 0.270 0.270}
		set adotomdot={5.583 3.049 2.921 2.713 2.597 2.439 2.302 2.217 1.975 1.986 1.665 1.347 0.808 0.152 0.204 0.118 -0.067 -0.217}
		ctype default pl 0 a adotomdot
		#
		set a2={-0.938 0.0}
		set adotomdot2={5.583 3.049}
		#
		set a3={0.0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5 0.6 0.75 0.875 0.895 0.9 0.938 0.969}
		set adotomdot3={3.049 2.921 2.713 2.597 2.439 2.302 2.217 1.975 1.986 1.665 1.347 0.808 0.152 0.204 0.118 -0.067 -0.217}
		set hor3={0.266 0.280 0.280 0.299 0.308 0.323 0.253 0.261 0.185 0.204 0.220 0.248 0.261 0.266 0.261 0.270 0.270}
		#
		# bardeen
		#
		set  thindisk={3.4641  3.32219  3.17924  3.03517  2.88988  2.74327  2.59521  2.44555  \
		       2.29411  1.98498  1.66544  1.15715  0.684885  0.601515  0.58014  0.408228  \
		    0.247391}
		ctype default pl 0 a3 adotomdot3
		ctype blue plo 0 a3 thindisk
		    #		
		#
		#lsq a2 adotomdot2 a2 lsqda2 rms2
		#lsq a3 adotomdot3 a3 lsqda3 rms3
		lsq a3 thindisk a3 lsqthindisk rmsthindisk
		set myrms=$rms
		set mym=$a
		set myb=$b
		set sigm=$sig_a
		set sigb=$sig_b
		set chisq=$CHI2
		#ctype red plo 0 a lsqda
		#
spindowndiff    0
		set diff=thindisk-adotomdot3
		ctype default pl 0 hor3 diff
		#
		set hor4={0 0.266 0.280 0.280 0.299 0.308 0.323 0.253 0.261 0.185 0.204 0.220 0.248 0.261 0.266 0.261 0.270 0.270}
		set diff4=1,18,1
		set diff4={0 0.4151 \
		   0.4012 \
		   0.4662 \
		   0.4382 \
		   0.4509 \
		   0.4413 \
		   0.3782 \
		   0.4705 \
		   0.3081 \
		   0.32 \
		   0.3184 \
		   0.3491 \
		   0.5329 \
		   0.3975 \
		   0.4621 \
		   0.4752 \
		   0.4644 }
		#
		lsq hor3 diff hor3 lsqdiff rmsdiff
		ctype red plo 0 hor3 lsqdiff
		set myrms=$rms
		set mym=$a
		set myb=$b
		set sigm=$sig_a
		set sigb=$sig_b
		set chisq=$CHI2
		print {mym myb}
		#
		ctype default pl 0 hor4 diff4
		lsq hor4 diff4 hor4 lsqdiff4 rmsdiff4
		ctype red plo 0 hor4 lsqdiff4
		set myrms=$rms
		set mym=$a
		set myb=$b
		set sigm=$sig_a
		set sigb=$sig_b
		set chisq=$CHI2
		print {mym myb}
		
