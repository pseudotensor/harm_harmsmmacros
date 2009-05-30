magdiss 0       #
		#
		jrdp dump0020
		#
		set alphamag=ABS(B1)*ABS(B3)/(bsq)
		set taumagdiss=r**2*ABS(omega3)/cs2/alphamag
		#
		# doesn't really work
		# setlimits Rin Rout 1.56 1.58 -1 1
		# plflim 0 x1 r h taumagdiss 1
		#
		# this works!
		set hor=0.05
		gcalc2 3 2 hor alphamag alphamagvsr
		#
		#
		define x1label "r"
		define x2label "\alpha_{mag}"
		ctype default pl 0 newr alphamagvsr 1101 1.0 Rout 1E-5 1
		#


		# fits a=0
		#
		# below 2 work for dump0020
		# for#
		# emf:/fs2/jon/grmhd-1024x128-hor-.05-a.0-fl68-hslopefix
		#
		set it=0.003*(newr/10)**(-2.4)
		ctype red pl 0 newr it 1110
		#
		# below also works for dump0015
		set it2=.027*(newr/4.5)**(-3.9)
		ctype red pl 0 newr it2 1110
		#


		
		# a=0 for a=0.9375 comparison
		#
		set it=0.13*(newr/2.1)**(-2.4)
		ctype red pl 0 newr it 1110
		#
		# below also works for dump0015
		set it2=.53*(newr/2.1)**(-3.9)
		ctype red pl 0 newr it2 1110
		#

		
		# fits a=0.9375 t=500
		#
		set it=0.023*(newr/2.1)**(-9.2)
		ctype red pl 0 newr it 1110
		#
		set it2=0.025*(newr/2.1)**(-2.1)
		ctype red pl 0 newr it2 1110

		#
		#gcalc2 3 2 hor taumagdiss taumagdissvsr
		#ctype default pl 0 newr taumagdissvsr 1100



		#
		gcalc2 3 2 hor omega3 omega3vsr
		ctype default pl 0 newr omega3vsr 1100

		

		#
		gcalc2 3 2 hor cs2 cs2vsr
		ctype default pl 0 newr cs2vsr 1100

