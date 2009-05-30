readall 0       # Charles, just run this macro ... don't run doall, that's for me.
		# Most variables are comprehensible by name, those that aren't aren't too important.
		read1
		read2
		read3
		readr
		#
doall 0         #
		#
		define averagetype (2)
		define rinner (_Rin)
		# using outer-most radius, but can plot only portion of this (say up to 2.5 or the ISCO).
		define router (_Rout)
		set hor=0.3
		#
		# read in as if not tavg file
		greaddump dumptavg2040v2
		plotsvsr1
		print1
		#
		# not having absolute values for Tud makes it not easily usable for inflow model comparison for the stress terms.
		# I'm working on doing all the calculations in C for
		# faster processing.  At this point the below type calculations takes about 96 minutes
		# Each gcalc2 for the entire radial range takes 31 seconds on my computer (31/60*(42+112+32)~96 minutes
		#
		# read in as if not tavg file
		readg42 tavg42.txt
		plotsvsr2
		print2
		#
		# read in as IF tavg file, hence tavg's below for plotsvsr3
		readg3 tavg3.txt
		plotsvsr3
		print3
		#
		printr
		#
		#
		#
		#
plotsvsr1 0     #
		# in all of the below "gcalc2 8"  takes the theta average
		# and gives something back vs radius for the specified range in theta
		# around the equator (+-hor) and from $rinner to $router only
		#
		# the $averagetype is set to volume-type average with
		# a gdet factor.  In general not including the gdet factor makes small
		# differences, and in different cases makes more or less sense for a
		# particular variable
		#
		# I can of course use a different type of average and give you that data instead
		#
		gcalc2 8 $averagetype hor rho rhovsr $rinner $router
		gcalc2 8 $averagetype hor u uvsr $rinner $router
                gcalc2 8 $averagetype hor v1 v1vsr $rinner $router
                gcalc2 8 $averagetype hor v2 v2vsr $rinner $router
                gcalc2 8 $averagetype hor v3 v3vsr $rinner $router
		gcalc2 8 $averagetype hor B1 B1vsr $rinner $router
		gcalc2 8 $averagetype hor B2 B2vsr $rinner $router
		gcalc2 8 $averagetype hor B3 B3vsr $rinner $router
		gcalc2 8 $averagetype hor divb divbvsr $rinner $router
		gcalc2 8 $averagetype hor uu0 uu0vsr $rinner $router
		gcalc2 8 $averagetype hor uu1 uu1vsr $rinner $router
		gcalc2 8 $averagetype hor uu2 uu2vsr $rinner $router
		gcalc2 8 $averagetype hor uu3 uu3vsr $rinner $router
		gcalc2 8 $averagetype hor ud0 ud0vsr $rinner $router
		gcalc2 8 $averagetype hor ud1 ud1vsr $rinner $router
		gcalc2 8 $averagetype hor ud2 ud2vsr $rinner $router
		gcalc2 8 $averagetype hor ud3 ud3vsr $rinner $router
		gcalc2 8 $averagetype hor bu0 bu0vsr $rinner $router
		gcalc2 8 $averagetype hor bu1 bu1vsr $rinner $router
		gcalc2 8 $averagetype hor bu2 bu2vsr $rinner $router
		gcalc2 8 $averagetype hor bu3 bu3vsr $rinner $router
		gcalc2 8 $averagetype hor bd0 bd0vsr $rinner $router
		gcalc2 8 $averagetype hor bd1 bd1vsr $rinner $router
		gcalc2 8 $averagetype hor bd2 bd2vsr $rinner $router
		gcalc2 8 $averagetype hor bd3 bd3vsr $rinner $router
		gcalc2 8 $averagetype hor v1m v1mvsr $rinner $router
		gcalc2 8 $averagetype hor v1p v1pvsr $rinner $router
		gcalc2 8 $averagetype hor v2m v2mvsr $rinner $router
		gcalc2 8 $averagetype hor v2p v2pvsr $rinner $router
		#
		gcalc2 8 $averagetype hor bsq bsqvsr $rinner $router
		gcalc2 8 $averagetype hor aphi aphivsr $rinner $router
		gcalc2 8 $averagetype hor omega3 omega3vsr $rinner $router
		gcalc2 8 $averagetype hor K Kvsr $rinner $router
		gcalc2 8 $averagetype hor va2 va2vsr $rinner $router
		gcalc2 8 $averagetype hor cs2 cs2vsr $rinner $router
		gcalc2 8 $averagetype hor cms2 cms2vsr $rinner $router
		#
		gcalc2 8 $averagetype hor sonicv1p sonicv1pvsr $rinner $router
		gcalc2 8 $averagetype hor alfvenv1p alfvenv1pvsr $rinner $router
		gcalc2 8 $averagetype hor fastv1p fastv1pvsr $rinner $router
		#
		gcalc2 8 $averagetype hor sonicv1m sonicv1mvsr $rinner $router
		gcalc2 8 $averagetype hor alfvenv1m alfvenv1mvsr $rinner $router
		gcalc2 8 $averagetype hor fastv1m fastv1mvsr $rinner $router
		#
plotsvsr2 0     #
		#
		gcalc2 8 $averagetype hor Tud00part0 Tud00part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part1 Tud00part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part2 Tud00part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part3 Tud00part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part4 Tud00part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part5 Tud00part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud00part6 Tud00part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part0 Tud01part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part1 Tud01part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part2 Tud01part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part3 Tud01part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part4 Tud01part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part5 Tud01part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud01part6 Tud01part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part0 Tud02part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part1 Tud02part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part2 Tud02part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part3 Tud02part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part4 Tud02part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part5 Tud02part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud02part6 Tud02part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part0 Tud03part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part1 Tud03part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part2 Tud03part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part3 Tud03part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part4 Tud03part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part5 Tud03part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud03part6 Tud03part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part0 Tud10part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part1 Tud10part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part2 Tud10part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part3 Tud10part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part4 Tud10part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part5 Tud10part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud10part6 Tud10part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part0 Tud11part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part1 Tud11part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part2 Tud11part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part3 Tud11part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part4 Tud11part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part5 Tud11part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud11part6 Tud11part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part0 Tud12part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part1 Tud12part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part2 Tud12part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part3 Tud12part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part4 Tud12part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part5 Tud12part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud12part6 Tud12part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part0 Tud13part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part1 Tud13part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part2 Tud13part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part3 Tud13part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part4 Tud13part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part5 Tud13part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud13part6 Tud13part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part0 Tud20part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part1 Tud20part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part2 Tud20part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part3 Tud20part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part4 Tud20part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part5 Tud20part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud20part6 Tud20part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part0 Tud21part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part1 Tud21part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part2 Tud21part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part3 Tud21part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part4 Tud21part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part5 Tud21part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud21part6 Tud21part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part0 Tud22part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part1 Tud22part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part2 Tud22part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part3 Tud22part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part4 Tud22part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part5 Tud22part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud22part6 Tud22part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part0 Tud23part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part1 Tud23part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part2 Tud23part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part3 Tud23part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part4 Tud23part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part5 Tud23part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud23part6 Tud23part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part0 Tud30part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part1 Tud30part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part2 Tud30part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part3 Tud30part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part4 Tud30part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part5 Tud30part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud30part6 Tud30part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part0 Tud31part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part1 Tud31part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part2 Tud31part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part3 Tud31part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part4 Tud31part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part5 Tud31part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud31part6 Tud31part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part0 Tud32part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part1 Tud32part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part2 Tud32part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part3 Tud32part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part4 Tud32part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part5 Tud32part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud32part6 Tud32part6vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part0 Tud33part0vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part1 Tud33part1vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part2 Tud33part2vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part3 Tud33part3vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part4 Tud33part4vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part5 Tud33part5vsr $rinner $router
		gcalc2 8 $averagetype hor Tud33part6 Tud33part6vsr $rinner $router
		#
plotsvsr3 0     # the tavg's are as readg3 reads the names
		#
		 gcalc2 8 $averagetype hor uu1tavg uu1vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd23tavg fdd23vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd02tavg fdd02vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd13tavg fdd13vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd01tavg fdd01vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd03tavg fdd03vsr $rinner $router
		 gcalc2 8 $averagetype hor fdd12tavg fdd12vsr $rinner $router
		 gcalc2 8 $averagetype hor omega3tavg omega3vsr $rinner $router
		 gcalc2 8 $averagetype hor mfltavg mflvsr $rinner $router
		 gcalc2 8 $averagetype hor lfltavg lflvsr $rinner $router
		 gcalc2 8 $averagetype hor efltavg eflvsr $rinner $router
		 gcalc2 8 $averagetype hor efl2tavg efl2vsr $rinner $router
		 gcalc2 8 $averagetype hor v1ptavg v1pvsr $rinner $router
		 gcalc2 8 $averagetype hor wf1tavg wf1vsr $rinner $router
		 gcalc2 8 $averagetype hor wf2tavg wf2vsr $rinner $router
		 gcalc2 8 $averagetype hor einftavg einfvsr $rinner $router
		 gcalc2 8 $averagetype hor linftavg linfvsr $rinner $router
		 gcalc2 8 $averagetype hor auu1tavg auu1vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd23tavg afdd23vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd02tavg afdd02vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd13tavg afdd13vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd01tavg afdd01vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd03tavg afdd03vsr $rinner $router
		 gcalc2 8 $averagetype hor afdd12tavg afdd12vsr $rinner $router
		 gcalc2 8 $averagetype hor amfltavg amflvsr $rinner $router
		 gcalc2 8 $averagetype hor alfltavg alflvsr $rinner $router
		 gcalc2 8 $averagetype hor aefltavg aeflvsr $rinner $router
		 gcalc2 8 $averagetype hor aefl2tavg aefl2vsr $rinner $router
		 gcalc2 8 $averagetype hor awf1tavg awf1vsr $rinner $router
		 gcalc2 8 $averagetype hor awf2tavg awf2vsr $rinner $router
		 gcalc2 8 $averagetype hor girattavg giratvsr $rinner $router
		 gcalc2 8 $averagetype hor magpartavg magparvsr $rinner $router
		#
		#
readr  0       #
		da r.txt
		lines 1 10000000
		read '%g %g' {newr newx1}
printr  0       #
		print r.txt '%21.15g %21.15g\n' {newr newx1}
		#
read1  0        #
		#
		# 42 columns
		da varvsr1.txt
		lines 1 10000000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {rhovsr uvsr v1vsr v2vsr v3vsr B1vsr B2vsr B3vsr divbvsr uu0vsr uu1vsr uu2vsr uu3vsr ud0vsr ud1vsr ud2vsr ud3vsr bu0vsr bu1vsr bu2vsr bu3vsr bd0vsr bd1vsr bd2vsr bd3vsr v1mvsr v1pvsr v2mvsr v2pvsr bsqvsr aphivsr omega3vsr Kvsr va2vsr cs2vsr cms2vsr sonicv1pvsr alfvenv1pvsr fastv1pvsr sonicv1mvsr alfvenv1mvsr fastv1mvsr}
	        #
print1  0       #
		#
		print varvsr1.txt '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {rhovsr uvsr v1vsr v2vsr v3vsr B1vsr B2vsr B3vsr divbvsr uu0vsr uu1vsr uu2vsr uu3vsr ud0vsr ud1vsr ud2vsr ud3vsr bu0vsr bu1vsr bu2vsr bu3vsr bd0vsr bd1vsr bd2vsr bd3vsr v1mvsr v1pvsr v2mvsr v2pvsr bsqvsr aphivsr omega3vsr Kvsr va2vsr cs2vsr cms2vsr sonicv1pvsr alfvenv1pvsr fastv1pvsr sonicv1mvsr alfvenv1mvsr fastv1mvsr}
		#
read2      0    #
		# 112 columns
		da varvsr2.txt
		lines 1 10000000
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {Tud00part0vsr Tud00part1vsr  Tud00part2vsr  Tud00part3vsr  Tud00part4vsr  Tud00part5vsr  Tud00part6vsr \
		     Tud01part0vsr Tud01part1vsr  Tud01part2vsr  Tud01part3vsr  Tud01part4vsr  Tud01part5vsr  Tud01part6vsr \
		     Tud02part0vsr Tud02part1vsr  Tud02part2vsr  Tud02part3vsr  Tud02part4vsr  Tud02part5vsr  Tud02part6vsr \
		     Tud03part0vsr Tud03part1vsr  Tud03part2vsr  Tud03part3vsr  Tud03part4vsr  Tud03part5vsr  Tud03part6vsr \
		    Tud10part0vsr Tud10part1vsr  Tud10part2vsr  Tud10part3vsr  Tud10part4vsr  Tud10part5vsr  Tud10part6vsr \
		     Tud11part0vsr Tud11part1vsr  Tud11part2vsr  Tud11part3vsr  Tud11part4vsr  Tud11part5vsr  Tud11part6vsr \
		     Tud12part0vsr Tud12part1vsr  Tud12part2vsr  Tud12part3vsr  Tud12part4vsr  Tud12part5vsr  Tud12part6vsr \
		     Tud13part0vsr Tud13part1vsr  Tud13part2vsr  Tud13part3vsr  Tud13part4vsr  Tud13part5vsr  Tud13part6vsr \
		    Tud20part0vsr Tud20part1vsr  Tud20part2vsr  Tud20part3vsr  Tud20part4vsr  Tud20part5vsr  Tud20part6vsr \
		     Tud21part0vsr Tud21part1vsr  Tud21part2vsr  Tud21part3vsr  Tud21part4vsr  Tud21part5vsr  Tud21part6vsr \
		     Tud22part0vsr Tud22part1vsr  Tud22part2vsr  Tud22part3vsr  Tud22part4vsr  Tud22part5vsr  Tud22part6vsr \
		     Tud23part0vsr Tud23part1vsr  Tud23part2vsr  Tud23part3vsr  Tud23part4vsr  Tud23part5vsr  Tud23part6vsr \
		    Tud30part0vsr Tud30part1vsr  Tud30part2vsr  Tud30part3vsr  Tud30part4vsr  Tud30part5vsr  Tud30part6vsr \
		     Tud31part0vsr Tud31part1vsr  Tud31part2vsr  Tud31part3vsr  Tud31part4vsr  Tud31part5vsr  Tud31part6vsr \
		     Tud32part0vsr Tud32part1vsr  Tud32part2vsr  Tud32part3vsr  Tud32part4vsr  Tud32part5vsr  Tud32part6vsr \
		     Tud33part0vsr Tud33part1vsr  Tud33part2vsr  Tud33part3vsr  Tud33part4vsr  Tud33part5vsr  Tud33part6vsr }
 	         tudpart2whole 0
		 #
		 #
tudpart2whole 1     #
		# gives rest of linear combinations not affected by averaging
		#
		# the below myabs is for future absolute value versions of the time average (i.e. time averaging the absolute value since this is often important for inflow model comparison)
		if($1==1) { define myabs ('a') }
		if($1==0) { define myabs (' ') }
		#
		    set Tud00MAvsr$myabs=Tud00part0vsr$myabs+Tud00part1vsr$myabs+Tud00part2vsr$myabs+Tud00part4vsr$myabs
		    set Tud00EMvsr$myabs=Tud00part3vsr$myabs+Tud00part5vsr$myabs+Tud00part6vsr$myabs
		    set Tud01MAvsr$myabs=Tud01part0vsr$myabs+Tud01part1vsr$myabs+Tud01part2vsr$myabs+Tud01part4vsr$myabs
		    set Tud01EMvsr$myabs=Tud01part3vsr$myabs+Tud01part5vsr$myabs+Tud01part6vsr$myabs
		    set Tud02MAvsr$myabs=Tud02part0vsr$myabs+Tud02part1vsr$myabs+Tud02part2vsr$myabs+Tud02part4vsr$myabs
		    set Tud02EMvsr$myabs=Tud02part3vsr$myabs+Tud02part5vsr$myabs+Tud02part6vsr$myabs
		    set Tud03MAvsr$myabs=Tud03part0vsr$myabs+Tud03part1vsr$myabs+Tud03part2vsr$myabs+Tud03part4vsr$myabs
		    set Tud03EMvsr$myabs=Tud03part3vsr$myabs+Tud03part5vsr$myabs+Tud03part6vsr$myabs
		    #
		    set Tud10MAvsr$myabs=Tud10part0vsr$myabs+Tud10part1vsr$myabs+Tud10part2vsr$myabs+Tud10part4vsr$myabs
		    set Tud10EMvsr$myabs=Tud10part3vsr$myabs+Tud10part5vsr$myabs+Tud10part6vsr$myabs
		    set Tud11MAvsr$myabs=Tud11part0vsr$myabs+Tud11part1vsr$myabs+Tud11part2vsr$myabs+Tud11part4vsr$myabs
		    set Tud11EMvsr$myabs=Tud11part3vsr$myabs+Tud11part5vsr$myabs+Tud11part6vsr$myabs
		    set Tud12MAvsr$myabs=Tud12part0vsr$myabs+Tud12part1vsr$myabs+Tud12part2vsr$myabs+Tud12part4vsr$myabs
		    set Tud12EMvsr$myabs=Tud12part3vsr$myabs+Tud12part5vsr$myabs+Tud12part6vsr$myabs
		    set Tud13MAvsr$myabs=Tud13part0vsr$myabs+Tud13part1vsr$myabs+Tud13part2vsr$myabs+Tud13part4vsr$myabs
		    set Tud13EMvsr$myabs=Tud13part3vsr$myabs+Tud13part5vsr$myabs+Tud13part6vsr$myabs
		    #
		    set Tud20MAvsr$myabs=Tud20part0vsr$myabs+Tud20part1vsr$myabs+Tud20part2vsr$myabs+Tud20part4vsr$myabs
		    set Tud20EMvsr$myabs=Tud20part3vsr$myabs+Tud20part5vsr$myabs+Tud20part6vsr$myabs
		    set Tud21MAvsr$myabs=Tud21part0vsr$myabs+Tud21part1vsr$myabs+Tud21part2vsr$myabs+Tud21part4vsr$myabs
		    set Tud21EMvsr$myabs=Tud21part3vsr$myabs+Tud21part5vsr$myabs+Tud21part6vsr$myabs
		    set Tud22MAvsr$myabs=Tud22part0vsr$myabs+Tud22part1vsr$myabs+Tud22part2vsr$myabs+Tud22part4vsr$myabs
		    set Tud22EMvsr$myabs=Tud22part3vsr$myabs+Tud22part5vsr$myabs+Tud22part6vsr$myabs
		    set Tud23MAvsr$myabs=Tud23part0vsr$myabs+Tud23part1vsr$myabs+Tud23part2vsr$myabs+Tud23part4vsr$myabs
		    set Tud23EMvsr$myabs=Tud23part3vsr$myabs+Tud23part5vsr$myabs+Tud23part6vsr$myabs
		    #
		    set Tud30MAvsr$myabs=Tud30part0vsr$myabs+Tud30part1vsr$myabs+Tud30part2vsr$myabs+Tud30part4vsr$myabs
		    set Tud30EMvsr$myabs=Tud30part3vsr$myabs+Tud30part5vsr$myabs+Tud30part6vsr$myabs
		    set Tud31MAvsr$myabs=Tud31part0vsr$myabs+Tud31part1vsr$myabs+Tud31part2vsr$myabs+Tud31part4vsr$myabs
		    set Tud31EMvsr$myabs=Tud31part3vsr$myabs+Tud31part5vsr$myabs+Tud31part6vsr$myabs
		    set Tud32MAvsr$myabs=Tud32part0vsr$myabs+Tud32part1vsr$myabs+Tud32part2vsr$myabs+Tud32part4vsr$myabs
		    set Tud32EMvsr$myabs=Tud32part3vsr$myabs+Tud32part5vsr$myabs+Tud32part6vsr$myabs
		    set Tud33MAvsr$myabs=Tud33part0vsr$myabs+Tud33part1vsr$myabs+Tud33part2vsr$myabs+Tud33part4vsr$myabs
		    set Tud33EMvsr$myabs=Tud33part3vsr$myabs+Tud33part5vsr$myabs+Tud33part6vsr$myabs
		    #
		    set Tud00vsr$myabs=Tud00MAvsr$myabs+Tud00EMvsr$myabs
		    set Tud01vsr$myabs=Tud01MAvsr$myabs+Tud01EMvsr$myabs
		    set Tud02vsr$myabs=Tud02MAvsr$myabs+Tud02EMvsr$myabs
		    set Tud03vsr$myabs=Tud03MAvsr$myabs+Tud03EMvsr$myabs
		    #
		    set Tud10vsr$myabs=Tud10MAvsr$myabs+Tud10EMvsr$myabs
		    set Tud11vsr$myabs=Tud11MAvsr$myabs+Tud11EMvsr$myabs
		    set Tud12vsr$myabs=Tud12MAvsr$myabs+Tud12EMvsr$myabs
		    set Tud13vsr$myabs=Tud13MAvsr$myabs+Tud13EMvsr$myabs
		    #
		    set Tud20vsr$myabs=Tud20MAvsr$myabs+Tud20EMvsr$myabs
		    set Tud21vsr$myabs=Tud21MAvsr$myabs+Tud21EMvsr$myabs
		    set Tud22vsr$myabs=Tud22MAvsr$myabs+Tud22EMvsr$myabs
		    set Tud23vsr$myabs=Tud23MAvsr$myabs+Tud23EMvsr$myabs
		    #
		    set Tud30vsr$myabs=Tud30MAvsr$myabs+Tud30EMvsr$myabs
		    set Tud31vsr$myabs=Tud31MAvsr$myabs+Tud31EMvsr$myabs
		    set Tud32vsr$myabs=Tud32MAvsr$myabs+Tud32EMvsr$myabs
		    set Tud33vsr$myabs=Tud33MAvsr$myabs+Tud33EMvsr$myabs
		    #
print2     0   #
		# 112 columns
		#
		print varvsr2.txt '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {Tud00part0vsr Tud00part1vsr  Tud00part2vsr  Tud00part3vsr  Tud00part4vsr  Tud00part5vsr  Tud00part6vsr \
		     Tud01part0vsr Tud01part1vsr  Tud01part2vsr  Tud01part3vsr  Tud01part4vsr  Tud01part5vsr  Tud01part6vsr \
		     Tud02part0vsr Tud02part1vsr  Tud02part2vsr  Tud02part3vsr  Tud02part4vsr  Tud02part5vsr  Tud02part6vsr \
		     Tud03part0vsr Tud03part1vsr  Tud03part2vsr  Tud03part3vsr  Tud03part4vsr  Tud03part5vsr  Tud03part6vsr \
		    Tud10part0vsr Tud10part1vsr  Tud10part2vsr  Tud10part3vsr  Tud10part4vsr  Tud10part5vsr  Tud10part6vsr \
		     Tud11part0vsr Tud11part1vsr  Tud11part2vsr  Tud11part3vsr  Tud11part4vsr  Tud11part5vsr  Tud11part6vsr \
		     Tud12part0vsr Tud12part1vsr  Tud12part2vsr  Tud12part3vsr  Tud12part4vsr  Tud12part5vsr  Tud12part6vsr \
		     Tud13part0vsr Tud13part1vsr  Tud13part2vsr  Tud13part3vsr  Tud13part4vsr  Tud13part5vsr  Tud13part6vsr \
		    Tud20part0vsr Tud20part1vsr  Tud20part2vsr  Tud20part3vsr  Tud20part4vsr  Tud20part5vsr  Tud20part6vsr \
		     Tud21part0vsr Tud21part1vsr  Tud21part2vsr  Tud21part3vsr  Tud21part4vsr  Tud21part5vsr  Tud21part6vsr \
		     Tud22part0vsr Tud22part1vsr  Tud22part2vsr  Tud22part3vsr  Tud22part4vsr  Tud22part5vsr  Tud22part6vsr \
		     Tud23part0vsr Tud23part1vsr  Tud23part2vsr  Tud23part3vsr  Tud23part4vsr  Tud23part5vsr  Tud23part6vsr \
		    Tud30part0vsr Tud30part1vsr  Tud30part2vsr  Tud30part3vsr  Tud30part4vsr  Tud30part5vsr  Tud30part6vsr \
		     Tud31part0vsr Tud31part1vsr  Tud31part2vsr  Tud31part3vsr  Tud31part4vsr  Tud31part5vsr  Tud31part6vsr \
		     Tud32part0vsr Tud32part1vsr  Tud32part2vsr  Tud32part3vsr  Tud32part4vsr  Tud32part5vsr  Tud32part6vsr \
		     Tud33part0vsr Tud33part1vsr  Tud33part2vsr  Tud33part3vsr  Tud33part4vsr  Tud33part5vsr  Tud33part6vsr }
		     #
		     #
read3      0   #
		da varvsr3.txt
		lines 1 10000000
		#
		# 32 columns
		#
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		     {uu1vsr fdd23vsr fdd02vsr fdd13vsr fdd01vsr fdd03vsr fdd12vsr omega3vsr mflvsr \
		       lflvsr eflvsr efl2vsr v1pvsr wf1vsr wf2vsr einfvsr linfvsr auu1vsr \
		    afdd23vsr afdd02vsr afdd13vsr afdd01vsr afdd03vsr afdd12vsr amflvsr alflvsr aeflvsr aefl2vsr awf1vsr awf2vsr \
		    giratvsr magparvsr}
		    #
print3     0   # 
		#
		print varvsr3.txt '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {uu1vsr fdd23vsr fdd02vsr fdd13vsr fdd01vsr fdd03vsr fdd12vsr omega3vsr mflvsr \
		       lflvsr eflvsr efl2vsr v1pvsr wf1vsr wf2vsr einfvsr linfvsr auu1vsr \
		    afdd23vsr afdd02vsr afdd13vsr afdd01vsr afdd03vsr afdd12vsr amflvsr alflvsr aeflvsr aefl2vsr awf1vsr awf2vsr \
		    giratvsr magparvsr}
		    #
fooall 0        #
		#
		set r=newr
		set x1=newx1
		#
		# 1
		#
		set rho=rhovsr
		set u=uvsr
                set v1=v1vsr
                set v2=v2vsr
                set v3=v3vsr
		set B1=B1vsr
		set B2=B2vsr
		set B3=B3vsr
		set divb=divbvsr
		set uu0=uu0vsr
		set uu1=uu1vsr
		set uu2=uu2vsr
		set uu3=uu3vsr
		set ud0=ud0vsr
		set ud1=ud1vsr
		set ud2=ud2vsr
		set ud3=ud3vsr
		set bu0=bu0vsr
		set bu1=bu1vsr
		set bu2=bu2vsr
		set bu3=bu3vsr
		set bd0=bd0vsr
		set bd1=bd1vsr
		set bd2=bd2vsr
		set bd3=bd3vsr
		set v1m=v1mvsr
		set v1p=v1pvsr
		set v2m=v2mvsr
		set v2p=v2pvsr
		#
		set bsq=bsqvsr
		set aphi=aphivsr
		set omega3=omega3vsr
		set K=Kvsr
		set va2=va2vsr
		set cs2=cs2vsr
		set cms2=cms2vsr
		#
		set sonicv1p=sonicv1pvsr
		set alfvenv1p=alfvenv1pvsr
		set fastv1p=fastv1pvsr
		#
		set sonicv1m=sonicv1mvsr
		set alfvenv1m=alfvenv1mvsr
		set fastv1m=fastv1mvsr
		#
		# 2
		#
		set Tud00part0=Tud00part0vsr
		set Tud00part1=Tud00part1vsr
		set Tud00part2=Tud00part2vsr
		set Tud00part3=Tud00part3vsr
		set Tud00part4=Tud00part4vsr
		set Tud00part5=Tud00part5vsr
		set Tud00part6=Tud00part6vsr
		set Tud01part0=Tud01part0vsr
		set Tud01part1=Tud01part1vsr
		set Tud01part2=Tud01part2vsr
		set Tud01part3=Tud01part3vsr
		set Tud01part4=Tud01part4vsr
		set Tud01part5=Tud01part5vsr
		set Tud01part6=Tud01part6vsr
		set Tud02part0=Tud02part0vsr
		set Tud02part1=Tud02part1vsr
		set Tud02part2=Tud02part2vsr
		set Tud02part3=Tud02part3vsr
		set Tud02part4=Tud02part4vsr
		set Tud02part5=Tud02part5vsr
		set Tud02part6=Tud02part6vsr
		set Tud03part0=Tud03part0vsr
		set Tud03part1=Tud03part1vsr
		set Tud03part2=Tud03part2vsr
		set Tud03part3=Tud03part3vsr
		set Tud03part4=Tud03part4vsr
		set Tud03part5=Tud03part5vsr
		set Tud03part6=Tud03part6vsr
		set Tud10part0=Tud10part0vsr
		set Tud10part1=Tud10part1vsr
		set Tud10part2=Tud10part2vsr
		set Tud10part3=Tud10part3vsr
		set Tud10part4=Tud10part4vsr
		set Tud10part5=Tud10part5vsr
		set Tud10part6=Tud10part6vsr
		set Tud11part0=Tud11part0vsr
		set Tud11part1=Tud11part1vsr
		set Tud11part2=Tud11part2vsr
		set Tud11part3=Tud11part3vsr
		set Tud11part4=Tud11part4vsr
		set Tud11part5=Tud11part5vsr
		set Tud11part6=Tud11part6vsr
		set Tud12part0=Tud12part0vsr
		set Tud12part1=Tud12part1vsr
		set Tud12part2=Tud12part2vsr
		set Tud12part3=Tud12part3vsr
		set Tud12part4=Tud12part4vsr
		set Tud12part5=Tud12part5vsr
		set Tud12part6=Tud12part6vsr
		set Tud13part0=Tud13part0vsr
		set Tud13part1=Tud13part1vsr
		set Tud13part2=Tud13part2vsr
		set Tud13part3=Tud13part3vsr
		set Tud13part4=Tud13part4vsr
		set Tud13part5=Tud13part5vsr
		set Tud13part6=Tud13part6vsr
		set Tud20part0=Tud20part0vsr
		set Tud20part1=Tud20part1vsr
		set Tud20part2=Tud20part2vsr
		set Tud20part3=Tud20part3vsr
		set Tud20part4=Tud20part4vsr
		set Tud20part5=Tud20part5vsr
		set Tud20part6=Tud20part6vsr
		set Tud21part0=Tud21part0vsr
		set Tud21part1=Tud21part1vsr
		set Tud21part2=Tud21part2vsr
		set Tud21part3=Tud21part3vsr
		set Tud21part4=Tud21part4vsr
		set Tud21part5=Tud21part5vsr
		set Tud21part6=Tud21part6vsr
		set Tud22part0=Tud22part0vsr
		set Tud22part1=Tud22part1vsr
		set Tud22part2=Tud22part2vsr
		set Tud22part3=Tud22part3vsr
		set Tud22part4=Tud22part4vsr
		set Tud22part5=Tud22part5vsr
		set Tud22part6=Tud22part6vsr
		set Tud23part0=Tud23part0vsr
		set Tud23part1=Tud23part1vsr
		set Tud23part2=Tud23part2vsr
		set Tud23part3=Tud23part3vsr
		set Tud23part4=Tud23part4vsr
		set Tud23part5=Tud23part5vsr
		set Tud23part6=Tud23part6vsr
		set Tud30part0=Tud30part0vsr
		set Tud30part1=Tud30part1vsr
		set Tud30part2=Tud30part2vsr
		set Tud30part3=Tud30part3vsr
		set Tud30part4=Tud30part4vsr
		set Tud30part5=Tud30part5vsr
		set Tud30part6=Tud30part6vsr
		set Tud31part0=Tud31part0vsr
		set Tud31part1=Tud31part1vsr
		set Tud31part2=Tud31part2vsr
		set Tud31part3=Tud31part3vsr
		set Tud31part4=Tud31part4vsr
		set Tud31part5=Tud31part5vsr
		set Tud31part6=Tud31part6vsr
		set Tud32part0=Tud32part0vsr
		set Tud32part1=Tud32part1vsr
		set Tud32part2=Tud32part2vsr
		set Tud32part3=Tud32part3vsr
		set Tud32part4=Tud32part4vsr
		set Tud32part5=Tud32part5vsr
		set Tud32part6=Tud32part6vsr
		set Tud33part0=Tud33part0vsr
		set Tud33part1=Tud33part1vsr
		set Tud33part2=Tud33part2vsr
		set Tud33part3=Tud33part3vsr
		set Tud33part4=Tud33part4vsr
		set Tud33part5=Tud33part5vsr
		set Tud33part6=Tud33part6vsr
		#
		# 3
		 set uu1=uu1vsr
		 set fdd23=fdd23vsr
		 set fdd02=fdd02vsr
		 set fdd13=fdd13vsr
		 set fdd01=fdd01vsr
		 set fdd03=fdd03vsr
		 set fdd12=fdd12vsr
		 set omega3=omega3vsr
		 set mfl=mflvsr
		 set lfl=lflvsr
		 set efl=eflvsr
		 set efl2=efl2vsr
		 set v1p=v1pvsr
		 set wf1=wf1vsr
		 set wf2=wf2vsr
		 set einf=einfvsr
		 set linf=linfvsr
		 set auu1=auu1vsr
		 set afdd23=afdd23vsr
		 set afdd02=afdd02vsr
		 set afdd13=afdd13vsr
		 set afdd01=afdd01vsr
		 set afdd03=afdd03vsr
		 set afdd12=afdd12vsr
		 set amfl=amflvsr
		 set alfl=alflvsr
		 set aefl=aeflvsr
		 set aefl2=aefl2vsr
		 set awf1=awf1vsr
		 set awf2=awf2vsr
		 set girat=giratvsr
		 set magpar=magparvsr
		#
redog3  0 #
		avgtimeg3 'dump' 20 40
		printg3 tavg3.txt
		jre forgammie.m
		define averagetype (2)
		define rinner (_Rin)
		# using outer-most radius, but can plot only portion of this (say up to 2.5 or the ISCO).
		define router (_Rout)
		set hor=0.3
		readg3 tavg3.txt
		plotsvsr3
		print3
		#



		
