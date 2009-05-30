mdotvsr 0       # a=0.998 model
		set outflow=( ( ((rho+u+p)/rho)*ud0<-1)&&(uu1>0)) ? 1 : 0
		set inflow = outflow ? 0 : 1
		#
		set massfluxoutflow=outflow ? rho*uu1  : 0
		set massfluxinflow=inflow ? rho*uu1  : 0
		#
		gcalc2 3 0 pi/2 massfluxoutflow massfluxoutvsr
		gcalc2 3 0 pi/2 massfluxinflow massfluxinvsr
		#
		#
		# -.1 on horizon for a=0.998 model
		# -.17 on horizon for a=.9375 456^2 model
		#set mdothor=.17
		#set ratio=massfluxvsr/mdothor
		#
		#pl 0 newr ratio
		#
 		ctype default pl 0 newr massfluxoutvsr 1101 1 40 1E-3 10
 		ctype red pl 0 newr massfluxinvsr 1111 1 40 1E-3 10
		#
		set myfit=0.13*(newr/6.8)**(3/4)
		ctype red pl 0 newr myfit 1111 1 40 1E-3 10
		set myfit=0.13*(newr/6.8)**(1)
		ctype blue pl 0 newr myfit 1111 1 40 1E-3 10
		#
		set massfluxgen=rho*uu1
		gcalc2 3 0 pi/2 massfluxgen massfluxgenvsr
		#
		#print {newr massfluxgenvsr}
		#
		#
		#
		#
		stresscalc 1
		#
		#gcalc2 3 0 pi/2 Tud10MA Tud10MAvsr
		#
		set kethermalflux=(outflow ) ? Tud10MA+massfluxgen : 0
		#
		gcalc2 3 0 pi/2 kethermalflux kethermalfluxvsr
		#
		set ratio=kethermalfluxvsr/mdothor
		pl 0 newr ratio
		#
		#
		gcalc2 3 0 pi/2 Tud10EM Tud10EMvsr
		#
		set emflux=(outflow ) ? Tud10EM : 0
		#
		gcalc2 3 0 pi/2 emflux emfluxvsr
		#
		set ratio=emfluxvsr/mdothor
		pl 0 newr ratio
		#
		#
		greaddumpfull dumptavg2040v2
		#
