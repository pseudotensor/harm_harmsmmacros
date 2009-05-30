ldotvst 0        #
		# /mnt/disk/runbhgrmhd/grmhd-800x400-hor.05-a0-fl68-real
		riscocalc 0 risco
		elinfcalc risco einf linf
		print {risco einf linf}
		#
		gammieenero3
		set ratdlm=dlm/linf
		ctype default pl 0 t ratdlm
		#
		set ratdem=dem/einf
		ctype red plo 0 t ratdem
		#
ldotvst2 0        #
		# palantiri:/raid1/jmckinne/td2048by256
		riscocalc 0 risco
		elinfcalc risco einf linf
		print {risco einf linf}
		#
		jrdpener 0 2000
		set ratdlm=dlm/linf
		ctype default pl 0 t ratdlm 0001 0 2000 0 1.5
		#
		set ratdem=dem/einf
		ctype red plo 0 t ratdem
		#
ldotvsr 0               #
		# /mnt/disk/runbhgrmhd/grmhd-800x400-hor.05-a0-fl68-real
		#
		jrdp2d dump0005
		stresscalc 1
		#
		#
stressvsr1    0         #
		#
		jre punsly.m
		setdxdxpold
		#
		set iinner=0
                set iouter=$nx-1
                define mynx ($nx)
		set ivsr=0,$mynx-1
		set newx1=0,$mynx-1
		set newr=0,$mynx-1
                #
		#
		#set myfunc=(tj==$ny/2) ? ju3test : 0
		set myfunc=ju3
		#
		do ii=iinner,iouter,1 {
		   set use = ((abs(h-0.5*pi)<=pi/2) && $ii>=ti) ? 1 : 0
		   #set use = ((abs(h-0.5*pi)<=0.6) && $ii>=ti) ? 1 : 0
		   #
		   #set use=((lbrel<1.0) && $ii>=ti) ? 1 : 0
		   #
		   #
		   set ivsr[$ii-iinner]=SUM(myfunc*$dx1*$dx2*gdet*use)
		   #set ivsr[$ii-iinner]=SUM(myfunc*gdet*use)
		   #set ivsr[$ii-iinner]=SUM(myfunc*r**2*sin(h)*dr*dh*use)
		   #
		   set newrtemp=r if((ti==$ii)&&(tj==0))
		   set newx1temp=x1 if((ti==$ii)&&(tj==0))
		   set newx1[$ii-iinner]=newx1temp
		   set newr[$ii-iinner]=newrtemp
		   #
		}
		#
timedep0     2  #
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# /mnt/disk/runbhgrmhd/grmhd-800x400-hor.05-a0-fl68-real
		#
		#/mnt/data1/jon/rundata/grmhd-a.35-256by256-fl46
		#
		# gammiegrid gdump
		#
		define nz (1)
		jre gtwodavgs.m
		define startdump $1
		# for snapshot, choose enddup of 15 or 16
		define enddump $2
		avgtimegfull 'dump' $startdump $enddump
		#
		set h1='dumpavg'
		set h2='$!startdump'
		set h3='$!enddump'
		set h4='n2.txt'
		#
		set _fname=h1+h2+h3+h4
		define filename (_fname)
		gwritedumpfull $filename
		#
		greaddumpfull2 $filename
		#
doall1 0        #
		# for H/R=0.3 case
		set myhor=0.3
		define extentplot (pi/2)
		#
		# for H/R=0.05 case
		set myhor=0.05
		define extentplot (0.3)
		#
		#timedep0 5 6
		#quant0
		#quant1
		#device postencap horsnapthina0.eps
		#plquant0
		#plquant1
		#device X11
		#
		# assume timedep0 already called
		#timedep0 5 20
		quant0
		quant1
		device postencap hortavgthina0.eps
		plquant0
		plquant1
		device X11
		#
		# based only on averages
		quant3
		device postencap ldotfracthina0.eps
		plquant3
		device X11
		#
		dumpquant3
		#
		device postencap ldotfracfullthetathina0.eps
		plquant32
		device X11
		dumpquant32
		#
		# based only on averages
		quant4
		device postencap mdotfracthina0.eps
		plquant4
		device X11
		dumpquant4
		#
		device postencap mdotfracfullthetathina0.eps
		plquant42
		device X11
		dumpquant42
		#
		device postencap alphamagthina0.eps
		jre ramesh_disk.m
		alphaplot0 myhor
		jre niayesh.m
		device X11
		#
quant0 0        #
		#
		# gammiegrid gdump
		#
		#
		set orthofactor=sqrt(gv311)*sqrt(gn333)
		#
		#set alphamag2=alphamag2*orthofactor
		#
		#
		# HOR
		#
		define HOR0 (myhor)
		#
		# over some known thickness
		gcalc2 3 2 $HOR0 hor1tavg hor1vsr
		#
		# over some known thickness
		set mycs=sqrt(cs2tavg)
		gcalc2 3 2 $HOR0 mycs mycsvsr
		set myvphi=omega3tavg*sqrt(gv333)
		gcalc2 3 2 $HOR0 myvphi myvphivsr
		#
		set hor2vsr=mycsvsr/myvphivsr
		#
		# over some equatorial slice (even # of zones)
		set mycstavg1=sqrt(cs2tavg) if(tj==$ny/2)
		set mycstavg2=sqrt(cs2tavg) if(tj==$ny/2-1)
		set mycstavg=0.5*(mycstavg1+mycstavg2)
		#
		set myvphitavg1=sqrt(gv333)*omega3tavg if(tj==$ny/2)
		set myvphitavg2=sqrt(gv333)*omega3tavg if(tj==$ny/2-1)
		set myvphitavg3=0.5*(myvphitavg1+myvphitavg2)
		#
		set hor3vsr=mycstavg/myvphitavg3
		#
plquant0 0      #
		fdraft
		define x2label "\theta-\pi/2"
		define x1label "r c^2/GM"
		ctype default pl 0 newr hor1vsr 1001 Rin Rout -$extentplot $extentplot
		ctype red pl 0 newr hor2vsr 1011 Rin Rout -$extentplot $extentplot
		ctype blue pl 0 newr hor3vsr 1011 Rin Rout -$extentplot $extentplot
		#
quant1 0        #
		#
		# density vesions of H/R
		#
		define HOR0 (pi/2)
		#
		# over some known thickness
		set rhomoment0=rhotavg*(h-pi/2)
		gcalc2 3 2 $HOR0 rhomoment0 rhomoment0vsr
		gcalc2 3 2 $HOR0 rhotavg rhovsr
		#
		# \theta of disk away from equator
		set theta0diff=rhomoment0vsr/rhovsr
		#
		set rhomoment1=rhotavg*(h-pi/2)**2
		gcalc2 3 2 $HOR0 rhomoment1 rhomoment1vsr
		#
		set hor4vsr = sqrt(rhomoment1vsr/rhovsr)
		#
		#
		#
plquant1 0      #
		ctype green pl 0 newr hor4vsr 1011 Rin Rout -$extentplot $extentplot
		ctype yellow pl 0 newr theta0diff 1011 Rin Rout -$extentplot $extentplot
		#
quant3 0        #
		# Show various angular momentum terms
		#
		#
		set ldotadv1=magenthalpytavg*uu1tavg*ud3tavg
		set ldotadv2=magenthalpytavg*auu1tavg*aud3tavg
		set ldotadv3=ldotadvtavg
		set ldotadv4=aldotadvtavg
		#
		# not really ext
		set ldotma=ldotextmatavg
		set ldotem=ldotextemtavg
		set ldottot=ldotma+ldotem
		#
		set mygdet=gdet*dV/area
		#
		define HOR0 (myhor)
		#
		gcalc2 3 3 $HOR0 mygdet mygdetvsr1
		#
		# over some known thickness
		gcalc2 3 2 $HOR0 ldotadv1 ldotadv1vsr1
		gcalc2 3 2 $HOR0 ldotadv2 ldotadv2vsr1
		gcalc2 3 2 $HOR0 ldotadv3 ldotadv3vsr1
		# below quantity used for normalization of rest since most regular and simplest quantity
		gcalc2 3 2 $HOR0 ldotadv4 ldotadv4vsr1
		gcalc2 3 2 $HOR0 ldottot ldottotvsr1
		gcalc2 3 2 $HOR0 ldotma ldotmavsr1
		gcalc2 3 2 $HOR0 ldotem ldotemvsr1
		#
		define HOR0 (pi/2)
		#
		gcalc2 3 2 $HOR0 mygdet mygdetvsr2
		#
		# over some known thickness
		gcalc2 3 2 $HOR0 ldotadv1 ldotadv1vsr2
		gcalc2 3 2 $HOR0 ldotadv2 ldotadv2vsr2
		gcalc2 3 2 $HOR0 ldotadv3 ldotadv3vsr2
		# below quantity used for normalization of rest since most regular and simplest quantity
		gcalc2 3 2 $HOR0 ldotadv4 ldotadv4vsr2
		gcalc2 3 2 $HOR0 ldottot ldottotvsr2
		gcalc2 3 2 $HOR0 ldotma ldotmavsr2
		gcalc2 3 2 $HOR0 ldotem ldotemvsr2
		#
		#
plquant3 0      #
		set q1=ldotadv1vsr1/ldotadv4vsr1
		set q2=ldotadv2vsr1/ldotadv4vsr1
		set q3=ldotadv3vsr1/ldotadv4vsr1
		set q4=ldottotvsr1/ldotadv4vsr1
		set q5=ldotmavsr1/ldotadv4vsr1
		set q6=ldotemvsr1/ldotadv4vsr1
		#
		fdraft
		define x2label "\dot{L}/\dot{L}_{\rm fid}"
		define x1label "r c^2/GM"
		#
		ctype default pl 0 newr q1 1001 Rin Rout -2 2
		ctype red pl 0 newr q2 1011 Rin Rout -2 2
		ctype blue pl 0 newr q3 1011 Rin Rout -2 2
		ctype green pl 0 newr q4 1011 Rin Rout -2 2
		ctype yellow pl 0 newr q5 1011 Rin Rout -2 2
		ctype magenta pl 0 newr q6 1011 Rin Rout -2 2
		#
		ctype default ltype 1 vertline (LG(risco))
		ltype 0
		#
dumpquant3 0    #
		define print_noheader (1)
		print "ldotfrac.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {newr ldotadv1vsr1 ldotadv1vsr1 ldotadv3vsr1 ldotadv4vsr1 ldottotvsr1 ldotmavsr1 ldotemvsr1 \
		       mygdetvsr1 }
		       #
plquant32 0     #
		#
		set q1=ldotadv1vsr2/ldotadv4vsr2
		set q2=ldotadv2vsr2/ldotadv4vsr2
		set q3=ldotadv3vsr2/ldotadv4vsr2
		set q4=ldottotvsr2/ldotadv4vsr2
		set q5=ldotmavsr2/ldotadv4vsr2
		set q6=ldotemvsr2/ldotadv4vsr2
		#
		fdraft
		define x2label "\dot{L}/\dot{L}_{fid}"
		define x1label "r c^2/GM"
		#
		ctype default pl 0 newr q1 1001 Rin Rout -2 2
		ctype red pl 0 newr q2 1011 Rin Rout -2 2
		ctype blue pl 0 newr q3 1011 Rin Rout -2 2
		ctype green pl 0 newr q4 1011 Rin Rout -2 2
		ctype yellow pl 0 newr q5 1011 Rin Rout -2 2
		ctype magenta pl 0 newr q6 1011 Rin Rout -2 2
		#
		ctype default ltype 1 vertline (LG(risco))
		ltype 0
		#
dumpquant32 0    #
		define print_noheader (1)
		print "ldotfracfull.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {newr ldotadv1vsr2 ldotadv1vsr2 ldotadv3vsr2 ldotadv4vsr2 ldottotvsr2 ldotmavsr2 ldotemvsr2 \
		       mygdetvsr2 }
		       #
		       #
		       #
		       #
quant4 0        #
		# Show mdot in various ways
		#
		#
		set mdot1=rhotavg*uu1tavg
		set mdot2=rhotavg*auu1tavg
		set mdot3=mdottavg
		#
		set mygdet=gdet*dV/area
		#
		define HOR0 (myhor)
		#
		gcalc2 3 3 $HOR0 mygdet mygdetvsr1
		#
		# over some known thickness
		gcalc2 3 2 $HOR0 mdot1 mdot1vsr1
		gcalc2 3 2 $HOR0 mdot2 mdot2vsr1
		gcalc2 3 2 $HOR0 mdot3 mdot3vsr1
		#
		define HOR0 (pi/2)
		#
		gcalc2 3 2 $HOR0 mygdet mygdetvsr2
		#
		# over some known thickness
		gcalc2 3 2 $HOR0 mdot1 mdot1vsr2
		gcalc2 3 2 $HOR0 mdot2 mdot2vsr2
		gcalc2 3 2 $HOR0 mdot3 mdot3vsr2
		#
		#
plquant4 0      #
		set q1=mdot1vsr1
		set q2=mdot2vsr1
		set q3=mdot3vsr1
		#
		fdraft
		define x2label "\dot{M}"
		define x1label "r c^2/GM"
		#
		ctype default pl 0 newr q1 1001 Rin Rout -1E-2 1E-2
		ctype red pl 0 newr q2 1011 Rin Rout -1E-2 1E-2
		ctype blue pl 0 newr q3 1011 Rin Rout -1E-2 1E-2
		#
		ctype default ltype 1 vertline (LG(risco))
		ltype 0
		#
dumpquant4 0    #
		define print_noheader (1)
		print "mdotfrac.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {newr mdot1vsr1 mdot2vsr1 mdot3vsr1 mygdetvsr1 }
		       #
plquant42 0     #
		#
		set q1=mdot1vsr2
		set q2=mdot2vsr2
		set q3=mdot3vsr2
		#
		fdraft
		define x2label "\dot{M}"
		define x1label "r c^2/GM"
		#
		ctype default pl 0 newr q1 1001 Rin Rout -1E-2 1E-2
		ctype red pl 0 newr q2 1011 Rin Rout -1E-2 1E-2
		ctype blue pl 0 newr q3 1011 Rin Rout -1E-2 1E-2
		#
		ctype default ltype 1 vertline (LG(risco))
		ltype 0
		#
dumpquant42 0    #
		define print_noheader (1)
		print "mdotfracfull.txt" '%21.15g %21.15g %21.15g %21.15g %21.15g\n' \
		    {newr mdot1vsr2 mdot2vsr2 mdot3vsr2 mygdetvsr2 }
		   #
mydmplot 0       #
		device postencap dm.eps
		 define x1label "t c^3/GM"
		 define x2label "\dot{M}"
		 #
		 pl 0 t dm 0101 0 2000 1E-8 5
		 #
		 device X11
		 #
densityvsr 0     #
		# thick disk a=0.9375
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#greaddumpfull2 dumpavg1525n2.txt
		#
		# thin disk
		#jrdp2d dump0000
		#greaddumpfull2 dumpavg1530n2.txt
		#
		#
 		#/mnt/data1/jon/rundata/grmhd-a.35-256by256-fl46
		# jrdp2d dump0000
		# greaddumpfull2 dumpavg1525n2.txt
		#
		#/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# jrdp2d dump0000
		# greaddumpfull2 dumpavg1525n2.txt
		# greaddumpfull2 dumpavg1525n3.txt
		#
		define HOR0 (0.01)
		#
		gcalc2 3 2 $HOR0 rho rhovsr
		#
		#
		defaults
		fdraft
		define x1label "R c^2/GM"
		define x2label "\rho"
		ctype default
		pl 0 newr rhovsr 1100
		#
		ctype red
		vertline (LG(risco))
		#
realrhovsr 1    # take proper sum
		#
		#
		# dMvsr is each shell's contribution to M(r)
		gcalc2 3 0 pi/2 rho DMvsr
		set DMvsr=DMvsr*$dx1
		#
		set Mvsr=DMvsr*0
		#
 		do iii=0,$nx-1,1 {\
		       #
		       echo $iii
		       do iiii=0,$iii,1 {\
		              #echo $iii $iiii
		        set Mvsr[$iii]=Mvsr[$iii]+DMvsr[$iiii]
		    }
		}
		#
		# now find \Sigma(r) = dM/dr
		der newr Mvsr dnewr sigmavsr
		set Sigmavsr=sigmavsr/(2*pi*dnewr)
		#
plSigmavsr 0    #
		defaults
		fdraft
		define x1label "R c^2/GM"
		define x2label "\Sigma = (dM/dr)/(2\pi r)"
		ctype default
		pl 0 dnewr Sigmavsr 1100
		#
		ctype red
		vertline (LG(risco))
		#
plSigmaovsr 0 #
		defaults
		fdraft
		define x1label "R c^2/GM"
		define x2label "\Sigma/r"
		ctype default
		set Sigmavsr2=Sigmavsr/dnewr
		pl 0 dnewr Sigmavsr2 1100
		#
		ctype red
		vertline (LG(risco))
		#
omega3vsr 0     #
		# thick disk a=0.9375
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#greaddumpfull2 dumpavg1525n2.txt
		#
		# thin disk
		#jrdp2d dump0000
		#greaddumpfull2 dumpavg1530n2.txt
		#
		#
 		#/mnt/data1/jon/rundata/grmhd-a.35-256by256-fl46
		# jrdp2d dump0000
		# greaddumpfull2 dumpavg1525n2.txt
		#
		#/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# jrdp2d dump0000
		# greaddumpfull2 dumpavg1525n2.txt
		# greaddumpfull2 dumpavg1525n3.txt
		#
		define HOR0 (0.01)
		#
		gcalc2 3 2 $HOR0 omega3 omega3vsr
		#
		#
		defaults
		fdraft
		define x1label "R c^2/GM"
		define x2label "\Omega"
		ctype default
		pl 0 newr omega3vsr 1100
		#
		ctype red
		vertline (LG(risco))
		#
		print omega3vsr_a0.txt {newr omega3vsr}
		#
coolplot 0      #
		jrdp3duold dump0008
		#
		#
		#device postencap angulardist.eps
		#
		define x1label "\theta"
		define x2label "\rho, p, b^2/2"
		set myrho=rho*.003
		setlimits 8 8.2 0 pi 0 1 ctype default plflim 0 x2 r h myrho 0
		setlimits 8 8.2 0 pi 0 1 ctype red plflim 0 x2 r h p 0 001
		set pb=bsq/2
		setlimits 8 8.2 0 pi 0 1 ctype blue plflim 0 x2 r h pb 0 001
		#
		#device X11
		#
		#
		#!cp angulardist.eps ~/
		#
		
