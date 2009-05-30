# 35
		# macro read "/home/jon/research/pnmhd/bin/avgwrite.m"
avgwrite 0 #
           PRINT \
		avg.dat '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g \
		%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g \
		%21.15g %21.15g %21.15g \
		%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g \
		%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g \
		\n' \
		{rtime entime betime cs2time stime vtimex vtimey vtimez \
		b2time btimex btimey btimez vatime vatimex \
		FPEtimex FPEtimey FPEtimez \
		FME1timex FME1timey FME1timez FME2timex FME2timey FME2timez \
		atvtimex atvtimey atvtimez aphitimex aphitimey aptimex aptimey abptimex abptimey atbtimex atbtimey atbtimez }
		#
avgread 0 #
		da avg.dat
		read {rtime 1 entime 2 betime 3 cs2time 4 stime 5 vtimex 6 vtimey 7 vtimez 8 \
		b2time 9 btimex 10 btimey 11 btimez 12 vatime 13 vatimex 14 \
		FPEtimex 15 FPEtimey 16 FPEtimez 17 \
		FME1timex 18 FME1timey 19 FME1timez 20 FME2timex 21 FME2timey 22 FME2timez 23 \
		atvtimex 24 atvtimey 25 atvtimez 26 aphitimex 27 aphitimey 28 aptimex 29 aptimey 30 abptimex 31 abptimey 32 atbtimex 33 atbtimey 34 atbtimez 35 }
		#
avgcalc 0   #
		set lrtime=LG(rtime)
		set lentime=LG(entime)
		set lb2time=LG(b2time)
		set FMEtimex=FME1timex+FME2timex
		set FMEtimey=FME1timey+FME2timey
		set FMEtimez=FME1timez+FME2timez
		set FEtimex=FPEtimex+FMEtimex
		set FEtimey=FPEtimey+FMEtimey
		set FEtimez=FPEtimez+FMEtimez
		set amagtimex=abptimex+atbtimex
		set amagtimey=abptimey+atbtimey
		set amagtimez=atbtimez
		set totacctimex=atvtimex+aphitimex+aptimex+abptimex+atbtimex
		set totacctimey=atvtimey+aphitimey+aptimey+abptimey+atbtimey
		set totacctimez=atvtimez+atbtimez
avgcontout 1 # avgcontout lrtime
		device postencap $1.eps
		plc 0 $1
		device X11
		#
avgcontfull 0 #
		define cres 100
		avgcalc
		define jet 0
		avgcontout lrtime
		avgcontout lentime
		avgcontout betime
		avgcontout cs2time
		avgcontout stime
		define jet 1
		avgcontout vtimex
		define jet 1
		avgcontout vtimey
		define jet 1
		avgcontout vtimez
		define jet 0
		avgcontout lb2time
		avgcontout btimex
		avgcontout btimey
		avgcontout btimez
		avgcontout vatime
		avgcontout vatimex
		avgcontout FME1timex
		avgcontout FME1timey
		avgcontout FME1timez
		avgcontout FME2timex
		avgcontout FME2timey
		avgcontout FME2timez
		avgcontout FMEtimex
		avgcontout FMEtimey
		avgcontout FMEtimez
		avgcontout FEtimex
		avgcontout FEtimey
		avgcontout FEtimez
		avgcontout atvtimex
		avgcontout atvtimey
		avgcontout atvtimez
		avgcontout aphitimex
		avgcontout aphitimey
		avgcontout aptimex
		avgcontout aptimey
		avgcontout abptimex
		avgcontout abptimey
		avgcontout atbtimex
		avgcontout atbtimey
		avgcontout atbtimez
		avgcontout totacctimex
		avgcontout totacctimey
		avgcontout totacctimez
		#
avg2normal 0    # sets average values to normal variable names for easy use with other functions
		set r=rtime
		set en=entime
		set Be=betime
		set cs2=cs2time
		set entropy=stime
		set vx=vtimex
		set vy=vtimey
		set vz=vtimez
		set b2=b2time
		set bx=btimex
		set by=btimey
		set bz=btimez
		set va=vatime
		set vax=vatimex
		set FPEx=FPEtimex
		set FPEy=FPEtimey
		set FPEz=FPEtimez
		set FME1x=FME1timex
		set FME1y=FME1timey
		set FME1z=FME1timez
		set FME2x=FME2timex
		set FME2y=FME2timey
		set FME2z=FME2timez
		set atvx=atvtimex
		set atvy=atvtimey
		set atvz=atvtimez
		set aphix=aphitimex
		set aphiy=aphitimey
		set apx=aptimex
		set apy=aptimey
		set abpx=abptimex
		set abpy=abptimey
		set atbx=atbtimex
		set atby=atbtimey
		set atbz=atbtimez
		#
lastmacro    0   #
		#
		
