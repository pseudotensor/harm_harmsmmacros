pl	1	#
		rd $1
		pla dm 3
		pla de 2
		pla dl 1
		window 1 1 1 1
		#
pla	2	#
		limits t $1
		window 1 3 1 $2
		box
		xla t
		yla $1
		connect t $1
		#
plotc         0 #
		smstart
		ctype default pl 0 t da
		ctype red plo 0 myt lsqda
		#
rdeners 0       #
		jre gener.m
		define a (0.0)
		define which (0)
		rd ener.out-a.0-256by256-fl46
		define a (0.5)
		define which (1)
		rd ener.out-a.5-256by256-fl46
		define a (0.75)
		define which (2)
		rd ener.out-a.75-256by256-fl46
		define a (0.875)
		define which (3)
		rd ener.out-a.875-256by256-fl46
		define a (0.875)
		define which (4)
		rd ener.out-a.875-200by100-fl46
		define a (0.9)
		define which (5)
		rd ener.out-a.9-256by256-fl46
		define a (0.911612)
		define which (6)
		rd ener.out-a.911612-200by100-fl46
		define a (0.9375)
		define which (7)
		rd ener.out-a.9375-256by256-fl46
		define a (0.9375)
		define which (8)
		rd ener.out-a.9375-256by256-fl46-rout400
		define a (0.9375)
		define which (9)
		rd ener.out-a.9375-256by256-fl46-R0.5
		define a (0.9375)
		define which (10)
		rd ener.out-a.9375-256by256-fl46-rin1.5rh
		define a (0.9375)
		define which (11)
		rd ener.out-a.9375-256by256-fl46-rin1.05rh
		define a (0.9375)
		define which (12)
		rd ener.out-a.9375-256by256-fl46-rin.7rh
		define a (0.9375)
		define which (13)
		rd ener.out-a.9375-456by456-fl46
		define a (0.96875)
		define which (14)
		rd ener.out-a.96875-256by256-fl46
rd	1	#
		da $1
                lines 1 10000000
		#read {t 1 mass 2 angmom 3 energy 4 pointa 5 pointb 6 dm 7 de 8 dl 9}
                #READ '' { t mass angmom energy pointa pointb dm de dl }
                read '%g %g %g %g %g %g %g %g %g' { t mass angmom energy pointa pointb dm de dl }
		set dm$which=dm
		set de$which=de
		set dl$which=dl
		set eff = 1. - de/dm
		set dem = de/dm
		set dlm = dl/dm
		#set da = dl/(2.*$a*de)
		set da = dl-2.*$a*de
		set dam = (dl-2.0*$a*de)/dm
		set eff$which=eff
		set dem$which=dem
		set dlm$which=dlm
		set da$which=da
		set dam$which=dam
                set myomegak= sqrt(1.0/(6.0**3 * (1.0-2/6.0)**2 ) )
                set myliscovar=6.0**2.0*myomegak
		define mylisco (myliscovar)
                set rat = dlm/($mylisco)
		set myt=t if(t>=500)
		set myda=da if(t>=500)
		set mydam=dam if(t>=500)
		set mydm=dm if(t>=500)
		set myde=de if(t>=500)
		set mydl=dl if(t>=500)
		#
		set mya=$a
		lsq myt myda myt lsqda rms
		set myrms=$rms
		set mym=$a
		set myb=$b
		set sigm=$sig_a
		set sigb=$sig_b
		set chisq=$CHI2
		lsq myt mydam myt lsqdam rmsm
		set myrmsm=$rmsm
		set mymm=$a
		set mybm=$b
		set sigmm=$sig_a
		set sigbm=$sig_b
		set chisqm=$CHI2
		#
		avg myt myda mydaavg
		avg myt mydam mydamavg
		avg myt mydm mydmavg
		avg myt myde mydeavg
		avg myt mydl mydlavg
		set daodm=mydaavg/mydmavg
		set deodm=mydeavg/mydmavg
		set dlodm=mydlavg/mydmavg
		print + lsqfitda.dat {mya mydaavg mym myb myrms chisq}
		print + lsqfitdam.dat {mya mydamavg mymm mybm myrmsm chisqm}
		print + daodm.dat {mya daodm mydmavg deodm dlodm}
		#
