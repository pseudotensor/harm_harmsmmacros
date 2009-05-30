	#
		#
		#
		# gammie check on why omega vs r is not constant (i.e. why trends in the magnetic terms
		#
		#
		#
bphivstpreall   2 #
		avgtimeg3 'dump' $1 $2
		define fname ('tavg3' + sprintf('%d',$1) + sprintf('%d',$2) + '.txt') 
		printg3 $fname
		avgtimegfull 'dump' $1 $2
		define fname ('dumptavg' + sprintf('%d',$1) + sprintf('%d',$2)) 
		gwritedump dumptavg$fname		
		avgtimeg4 'dump' $1 $2
		define fname ('tavg42' + sprintf('%d',$1) + sprintf('%d',$2) + '.txt') 
		printg42 $fname
bphivstdoall1  2  #
		#
		#
		bphivstpre $1 $2
		bphivstplot1
		bphivstdo 'dump' $1 $2
		printbphinogvst $1 $2
		readbphinogvst $1 $2
		#printbphivst $1 $2
		#readbphivst $1 $2
		plotbphivst2
		bphivstplay $1 $2
		bphivstplot2
		bphivstplot3
		#
bphivstdoall2  2  #
		#
		bphivstpre2 $1 $2
		bphivstplot1
		bphivstdo2 'dump' $1 $2
		# set dtotal=1500
		printbphivst2
		readbphivst2
		# now some calculations
		define doprint (1)
		plotbphivst22
		gammieconsistent1
		gammieconsistent2
		#
bphivstpre   2  #
		#
		set hor=0.3
		set timediff=50
		define fname ('dumptavg'+sprintf('%d',$1)+sprintf('%d',$2))
		jrdp $fname
		define fname ('tavg3' + sprintf('%d',$1) + sprintf('%d',$2) + '.txt') 
		readg3 $fname
		gammienew
		#
		gcalc2 8 4 hor afdd12tavg afdd12tavgvsr $rhor (risco)
		gcalc2 8 4 hor fdd12tavg fdd12tavgvsr $rhor (risco)
		#
		set gB3=gdet*B3
		gcalc2 8 4 hor gB3 gB3vsr $rhor (risco)
		set agB3=ABS(gdet*B3)
		gcalc2 8 4 hor agB3 agB3vsr $rhor (risco)
		#
		#
bphivstpre2   2         #
		#
		set hor=0.3
		set timediff=1
		define fname ('dumptavg'+sprintf('%d',$1)+sprintf('%d',$2))
		jrdp $fname
		define fname ('tavg3' + sprintf('%d',$1) + sprintf('%d',$2) + '.txt') 
		readg3 $fname
		gammienew
		#
		gcalc2 8 4 hor afdd12tavg afdd12tavgvsr $rhor risco
		gcalc2 8 4 hor fdd12tavg fdd12tavgvsr $rhor risco
		#
		set gB3=gdet*B3
		gcalc2 8 4 hor gB3 gB3vsr $rhor risco
		set agB3=ABS(gdet*B3)
		gcalc2 8 4 hor agB3 agB3vsr $rhor risco
		#
bphivstplot1   0     #
		#
		# note that agB3 is not the same as afdd12tavg because agB3 is sum of B3 and ABS in the end, while afdd12 is sum of abs of fdd12
		# gB3vsr and fdd12tavgvsr are and should be identical
		#
		define x1label "r c^2/(GM)"
		define x2label "\sqrt{(-g)}B^{\phi}--various forms"
		ctype default pl 0 newr afdd12tavgvsr 0001 $rhor (risco) -.1 hor
		ctype blue plo 0 newr fdd12tavgvsr
		ctype cyan plo 0 newr gB3vsr
		ctype green plo 0 newr agB3vsr
		#
		#
bphivstdo   3     #
                set h1=$1
		define DOGCALC (1)
		#
                #
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1		
                do iiii=numstart,numend,1 {
                  set h2=sprintf('%04d',$iiii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  bzeflux
		  #
		  set gB3=gdet*B3
		  set agB3=ABS(gdet*B3)
		  gcalc2 8 4 hor gB3 gB3vsr$iiii $rhor (risco)
		  gcalc2 8 4 hor agB3 agB3vsr$iiii $rhor (risco)
		  ctype red plo 0 newr agB3vsr$iiii
		  ctype yellow plo 0 newr gB3vsr$iiii
		}
		#
bphivstdo2   3     # used for consistency check, and all really use is initial and final times, and make sure no rend in time
                set h1=$1
		define DOGCALC (1)
		#
                #
		set agB3avg=0
		set gB3avg=0
		set dtotal=0
		#
		set numstart=$2
		set numend=$3
                set numtotal=numend-numstart+1
		#
		set mytime=1,numtotal,1
		set mytime=mytime*0
		set gB3avgvst=mytime*0
		set agB3avgvst=mytime*0
		#
                do iiii=numstart,numend,1 {
                  set h2=sprintf('%04d',$iiii)
                  set _fname=h1+h2
                  define filename (_fname)
		  jrdp $filename
		  bzeflux
		  #
		  set mytime[$iiii-numstart]=_t
		  if($iiii==numstart) { set dtotal=_t }
		  if($iiii==numend) { set dtotal=_t-dtotal }
		  set gB3=gdet*B3
		  set agB3=ABS(gdet*B3)
		  # volume inegral
		  joncalc3 2 7 $rhor risco hor gB3 gB3avg$iiii
		  set gB3avgvst[$iiii-numstart]=gB3avg$iiii
		  set gB3avg=gB3avg+gB3avg$iiii
		  joncalc3 2 7 $rhor risco hor agB3 agB3avg$iiii
		  set agB3avgvst[$iiii-numstart]=agB3avg$iiii
		  set agB3avg=agB3avg+agB3avg$iiii
		}
		set gB3avg=gB3avg/dtotal
		set agB3avg=agB3avg/dtotal
		#
printbphivst2 0 #
		print "./dumps/bphiavg" '%g %g %g\n' {mytime gB3avgvst agB3avgvst}
		#
readbphivst2 0 #
		da ./dumps/bphiavg
		read '%g %g %g\n' {mytime gB3avgvst agB3avgvst}
		#
plotbphivst22 0   # used with above
		#
		define x1label "t c^3/(GM)"
		define x2label "a/gB3avgvst"
		define tinner (mytime[0])
		define touter (mytime[dimen(mytime)-1])
		if($doprint){ device postencap gB3avgvst.eps }
		ctype default pl 0 mytime agB3avgvst 0001 $tinner $touter -1.5 1.5
		set myagB3avgvst=ABS(gB3avgvst)
		ctype red plo 0 mytime gB3avgvst
		ctype cyan plo 0 mytime myagB3avgvst
		lsqplot mytime agB3avgvst
		lsqplot mytime gB3avgvst
		lsqplot mytime myagB3avgvst
		if($doprint){ device X11 }
		#
		set tinnergB3=gB3avgvst[0]/dtotal
		set toutergB3=gB3avgvst[dimen(gB3avgvst)-1]/dtotal
		set tinneragB3=agB3avgvst[0]/dtotal
		set touteragB3=agB3avgvst[dimen(agB3avgvst)-1]/dtotal
		set diffgB3=toutergB3-tinnergB3
		set diffagB3=touteragB3-tinneragB3
		print bphieqn.txt {toutergB3 tinnergB3 diffgB3 touteragB3 tinneragB3 diffagB3}
		print + bphieqn.txt '\n' {}
		#
gammieconsistent2 0 # check via point or spatial averages rather than surface terms
		# we assume d/dt term vanishes here
		#
		dercalc 0 fdd02tavg dfdd02tavg
		dercalc 0 fdd01tavg dfdd01tavg
		#
		gcalc5 $rhor risco (pi/2-hor) (pi/2+hor) dfdd02tavgx dfdd02tavgxavg
		gcalc5 $rhor risco (pi/2-hor) (pi/2+hor) dfdd01tavgy dfdd01tavgyavg
		#
		gcalc52 $rhor risco (pi/2-hor) (pi/2+hor) dfdd02tavgx dfdd02tavgx2avg
		gcalc52 $rhor risco (pi/2-hor) (pi/2+hor) dfdd01tavgy dfdd01tavgy2avg
		#
		set total1=-dfdd02tavgxavg+dfdd01tavgyavg
		set total2=-dfdd02tavgx2avg+dfdd01tavgy2avg
		#
		#
		set frac1two=-dfdd02tavgxavg/total1
		set frac1three=dfdd01tavgyavg/total1
		set frac2two=-dfdd02tavgx2avg/total2
		set frac2three=dfdd01tavgy2avg/total2
		#
		dercalc 0 afdd02tavg dafdd02tavg
		dercalc 0 afdd01tavg dafdd01tavg
		#
		gcalc5 $rhor risco (pi/2-hor) (pi/2+hor) dafdd02tavgx dafdd02tavgxavg
		gcalc5 $rhor risco (pi/2-hor) (pi/2+hor) dafdd01tavgy dafdd01tavgyavg
		#
		gcalc52 $rhor risco (pi/2-hor) (pi/2+hor) dafdd02tavgx dafdd02tavgx2avg
		gcalc52 $rhor risco (pi/2-hor) (pi/2+hor) dafdd01tavgy dafdd01tavgy2avg
		#
		set totala1=-dafdd02tavgxavg+dafdd01tavgyavg
		set totala2=-dafdd02tavgx2avg+dafdd01tavgy2avg
		#
		set fraca1two=-dafdd02tavgxavg/totala1
		set fraca1three=dafdd01tavgyavg/totala1
		set fraca2two=-dafdd02tavgx2avg/totala2
		set fraca2three=dafdd01tavgy2avg/totala2
		#
		#print {total1 totala1 total2 totala2}
		print {frac1two frac1three}
		print {frac2two frac2three}
		print {fraca1two fraca1three}
		print {fraca2two fraca2three}
		#
		#
gammieconsistent1 0 # check via surface terms
		gcalc2 8 4 hor fdd02tavg fdd02tavgvsr $rhor risco
		gcalc2 8 4 hor afdd02tavg afdd02tavgvsr $rhor risco
		#
		define x1label "r c^2/(GM)"
		define x2label "a/fdd02tavgvsr"
		if($doprint){ device postencap fdd02tavgvsr.eps }
		ctype default pl 0 newr afdd02tavgvsr 0001 $rhor risco -0.01 0.1
		set myafdd02tavgvsr=ABS(fdd02tavgvsr)
		ctype red plo 0 newr fdd02tavgvsr
		ctype cyan plo 0 newr myafdd02tavgvsr
		lsqplot newr afdd02tavgvsr
		lsqplot newr fdd02tavgvsr
		lsqplot newr myafdd02tavgvsr
		if($doprint){ device X11 }
		#
		set rinnerfdd02=fdd02tavgvsr[0]
		set routerfdd02=fdd02tavgvsr[dimen(fdd02tavgvsr)-1]
		set difffdd02=routerfdd02-rinnerfdd02
		set rinnerafdd02=afdd02tavgvsr[0]
		set routerafdd02=afdd02tavgvsr[dimen(afdd02tavgvsr)-1]
		set diffafdd02=routerafdd02-rinnerafdd02
		print + bphieqn.txt {routerfdd02 rinnerfdd02 difffdd02 routerafdd02 rinnerafdd02 diffafdd02}
		print + bphieqn.txt '\n' {}
		#		
		gcalc62 $rhor risco (pi/2-hor) (pi/2+hor) fdd01tavg fdd01tavgvsth
		gcalc62 $rhor risco (pi/2-hor) (pi/2+hor) afdd01tavg afdd01tavgvsth
		#
		if($doprint){ device postencap fdd01tavgvsth.eps }
		ctype default pl 0 newh afdd01tavgvsth 0001 (pi/2-hor) (pi/2+hor) -0.01 0.04
		ctype red plo 0 newh fdd01tavgvsth
		set newafdd01tavgvsth=ABS(fdd01tavgvsth)
		ctype cyan plo 0 newh newafdd01tavgvsth
		lsqplot newh afdd01tavgvsth
		lsqplot newh fdd01tavgvsth
		lsqplot newh newafdd01tavgvsth
		ctype magenta vertline (pi/2)
		if($doprint){ device X11 }
		#
		set thinnerfdd01=fdd01tavgvsth[0]
		set thouterfdd01=fdd01tavgvsth[dimen(fdd01tavgvsth)-1]
		set difffdd01=thouterfdd01-thinnerfdd01
		set thinnerafdd01=afdd01tavgvsth[0]
		set thouterafdd01=afdd01tavgvsth[dimen(afdd01tavgvsth)-1]
		set diffafdd01=thouterafdd01-thinnerafdd01
		set finaldiff=diffgB3+difffdd02-difffdd01
		set finaldiffa=diffagB3+diffafdd02-diffafdd01
		#
		print + bphieqn.txt {thouterfdd01 thinnerfdd01 difffdd01 thouterafdd01 thinnerafdd01 diffafdd01}
		print + bphieqn.txt '\n' {}
		#
		print + bphieqn.txt {finaldiff finaldiffa}
		print + bphieqn.txt '\n' {}
		#
		set oneplus=toutergB3/finaldiff
		set oneplusa=touteragB3/finaldiffa
		set oneminus=tinnergB3/finaldiff
		set oneminusa=tinneragB3/finaldiffa
		#
		set twoplus=routerfdd02/finaldiff
		set twoplusa=routerafdd02/finaldiffa
		set twominus=rinnerfdd02/finaldiff
		set twominusa=rinnerafdd02/finaldiffa
		#
 		set threeplus=thouterfdd01/finaldiff
		set threeplusa=thouterafdd01/finaldiffa
		set threeminus=thinnerfdd01/finaldiff
		set threeminusa=thinnerafdd01/finaldiffa
		#
		print + bphieqn.txt {oneplus oneminus oneplusa oneminusa}
		print + bphieqn.txt '\n' {}
		print + bphieqn.txt {twoplus twominus twoplusa twominusa}
		print + bphieqn.txt '\n' {}
		print + bphieqn.txt {threeplus threeminus threeplusa threeminusa}
		print + bphieqn.txt '\n' {}
		!scp bphieqn.txt metric:research/papers/bz/
		if($doprint){\
		       !scp gB3avgvst.eps metric:research/papers/bz/
		       !scp fdd02tavgvsr.eps metric:research/papers/bz/
		       !scp fdd01tavgvsth.eps metric:research/papers/bz/
		    }
		#
printbphivst 2  # # actually vs r and t, each file a single time vs. r
		set numstart=$1
		set numend=$2
                set numtotal=numend-numstart+1
		do iiii=numstart,numend,1 {
		   set crap1=gB3vsr$iiii
		   set crap2=agB3vsr$iiii
		   define crap3 ($iiii)
		   print "./dumps/bphivst$!crap3" '%g %g %g\n' {newr crap1 crap2}
		}
		#
readbphivst 2  #
		set numstart=$1
		set numend=$2
                set numtotal=numend-numstart+1
		do iiii=numstart,numend,1 {
		   da ./dumps/bphivst$iiii
		   lines 1 1000000
		   read '%g %g %g' {newr crap1 crap2}
		   set gB3vsr$iiii=crap1
		   set agB3vsr$iiii=crap2
		}
		#
printbphinogvst 2  # # actually vs r and t, each file a single time vs. r
		set numstart=$1
		set numend=$2
                set numtotal=numend-numstart+1
		do iiii=numstart,numend,1 {
		   set crap1=gB3vsr$iiii
		   set crap2=agB3vsr$iiii
		   define crap3 ($iiii)
		   print "./dumps/bphinogvst$!crap3" '%g %g %g\n' {newr crap1 crap2}
		}
		#
readbphinogvst 2  #
		set numstart=$1
		set numend=$2
                set numtotal=numend-numstart+1
		do iiii=numstart,numend,1 {
		   da ./dumps/bphinogvst$iiii
		   lines 1 1000000
		   read '%g %g %g' {newr crap1 crap2}
		   set gB3vsr$iiii=crap1
		   set agB3vsr$iiii=crap2
		}
		#
bphivstplay 2   #
		bphivstplot1
		set numstart=$1
		set numend=$2
                set numtotal=numend-numstart+1
		#
		set bphi1=newr*0
		set numbphi1=0
		set bphi2=newr*0
		set numbphi2=0
		set bhpi3=newr*0
		set numbphi3=0
		set mytime=0,numtotal-1,1
		set godavglist=0,numtotal-1,1
		#
                do iiii=numstart,numend,1 {
		  #
		  if($iiii<numend*1/3) {\
		         ctype red plo 0 newr agB3vsr$iiii
		         set bphi1=bphi1+agB3vsr$iiii
		         set numbphi1=numbphi1+1
		      }
		  if(($iiii>=numend*1/3)&&($iiii<numend*2/3)) {\
		         ctype yellow plo 0 newr agB3vsr$iiii
		         set bphi2=bphi2+agB3vsr$iiii
		         set numbphi2=numbphi2+1
		      }
		  if($iiii>=numend*2/3) {\
		         ctype blue plo 0 newr agB3vsr$iiii
		         set bphi3=bphi3+agB3vsr$iiii
		         set numbphi3=numbphi3+1
		      }
		      set mytime[$iiii-numstart]=$iiii*timediff
		      set godr=newr if((newr>$rhor)&&(newr<risco))
		      set god$iiii=agB3vsr$iiii if((newr>$rhor)&&(newr<risco))
		      avg godr god$iiii godavg
		      set godavglist[$iiii-numstart]=godavg
		      #		      
		   }
		   set bphi1=bphi1/numbphi1
		   set bphi2=bphi2/numbphi2
		   set bphi3=bphi3/numbphi3
		   #
bphivstplot2  0    # requires bphivstplay first
		#
		   # now average each and plot each
		   bphivstplot1
		   ctype red plo 0 newr bphi1
		   ctype yellow plo 0 newr bphi2
		   ctype blue plo 0 newr bphi3
		   #
		   set mygod0=afdd12tavgvsr if((newr>$rhor)&&(newr<risco))
		   set mygod1=bphi1 if((newr>$rhor)&&(newr<risco))
		   set mygod2=bphi2 if((newr>$rhor)&&(newr<risco))
		   set mygod3=bphi3 if((newr>$rhor)&&(newr<risco))
		   set mygodr=newr if((newr>$rhor)&&(newr<risco))
		   #
		   avg mygodr mygod0 mygod0avg
		   avg mygodr mygod1 mygod1avg
		   avg mygodr mygod2 mygod2avg
		   avg mygodr mygod3 mygod3avg
		   print {mygod0avg mygod1avg mygod2avg mygod3avg}
		#
lsqplot    2    #
		lsq $1 $2 $1 $1lsq rms
		ctype blue plo 0 $1 $1lsq
		avg $1 $1lsq lsqavg
		# construct same-mean realizations at 95% confidence
		set it=($a+2*$sig_a)*$1
		avg $1 it itavg
		set newit=it-itavg+lsqavg
		# construct same-mean realizations at 95% confidence
		set it=($a-2*$sig_a)*$1
		avg $1 it itavg
		set newit2=it-itavg+lsqavg
		ctype green plo 0 $1 newit
		ctype green plo 0 $1 newit2
		 set mym=$a
		 set myb=$b
		 set myrms=$rms
		 set sigm=$sig_a
		 set sigb=$sig_b
		 set chisq=$CHI2
		 prob_chisq $CHI2 (dimen($1)-2) myprob
		 set pvalue=$myprob
		 print {mym sigm myb sigb myrms chisq pvalue}
		 #
bphivstplot3  0 #
		define doprint (0)
		if($doprint) { device postencap bphivstsimplevst.eps}
		ctype default
		define x1label "t c^3/(GM)"
		define x2label "|\sqrt{(-g)}B^{\phi}|"
		pl 0 mytime godavglist
		smooth godavglist sgodavglist 8
		ctype red plo 0 mytime sgodavglist
		lsq mytime godavglist mytime godavglistit rms
		ctype blue plo 0 mytime godavglistit
		avg mytime godavglistit godavglistitavg
		# construct same-mean realizations at 95% confidence
		set it=($a+2*$sig_a)*mytime
		avg mytime it itavg
		set newit=it-itavg+godavglistitavg
		# construct same-mean realizations at 95% confidence
		set it=($a-2*$sig_a)*mytime
		avg mytime it itavg
		set newit2=it-itavg+godavglistitavg
		ctype green plo 0 mytime newit
		ctype green plo 0 mytime newit2
		 set mym=$a
		 set myb=$b
		 set myrms=$rms
		 set sigm=$sig_a
		 set sigb=$sig_b
		 set chisq=$CHI2
		 prob_chisq $CHI2 (dimen(mytime)-2) myprob
		 set pvalue=$myprob
		 print {mym sigm myb sigb myrms chisq pvalue}
		 if($doprint){\
		        device X11
		        !scp  bphivstsimplevst.eps metric:research/papers/bz/
		     }
		     #
		     #
frhthetaflux 0  #
		setlimits $rhor risco (pi/2-hor*1.01) (pi/2-hor*.99) 0 0.08
		ctype default plflim 0 x1 r h afdd01tavg 0
		set newr1=rnew
		set newfun1=newfun
		avg newr1 newfun1 newfun1avg
                #
		setlimits $rhor risco (pi/2+hor*.99) (pi/2+hor*1.01) 0 0.08
		ctype red plflim 0 x1 r h afdd01tavg 0 001
		set newr2=rnew
		set newfun2=newfun
		avg newr2 newfun2 newfun2avg
		#
jonrand       1 #
		it=RANDOM($1)
		it2=exp(-it**2)
		#
makerandlist  0 #
		erase
		set numpoints=30
		set x=1,numpoints,1
		set y=gaussdev(numpoints)
		lsq x y x myy rms
		echo $a $b $rms $sig_a $sig_b $CHI2
		#ctype default pl 0 x y
		ctype red pl 0 x myy 0001 1 numpoints -1 1
		prob_chisq $CHI2 (numpoints-2) myprob
		echo $myprob
		#
manylists    0  #
                do iiii=0,1000,1 {
		   makerandlist
		}
lena1        0  #
		set a=-.9
		set b=3
		set numpoints=30
		set y=gaussdev(numpoints)		
		set z=a*y+b
		set y2=gaussdev(numpoints)
		set z2=z+y2
		set newy=y
		ctype default pl 0 y z
		ctype blue points y z2
		#
		lsq y z2 y z2fit rms
		ctype red plo 0 y z2fit
		prob_chisq $CHI2 (numpoints-2) results
		echo $results
		#
