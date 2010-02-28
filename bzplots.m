bzplot76 0       #
		# ergo neg. energy plot
		#
		location 6000 31000 6000 31000
		#device postencap2 iTdd00total.eps
		#device postencap2 iTdd00total256fid.eps
		device postencap2 iTdd00total456fidzoom.eps
		#
		# use avgtimeg4 or readg4
		jrdp dump0000
		readg4
		#
		# reset parameters if not parameter to interp (otherwise reread/recreate g4)
		define cres 25
		#define cres (-0.005491515691)
		interpsingle EINFtavg
		#
		fdraft
		define coord (1)
		define x1label " "
		define x2label " "
		location 6000 31000 6000 31000
		#location 3500 31000 3500 31000
		# XLABEL \raise-500My X-axis Label
		define POSCONTCOLOR "red"
		ltype 0 plc 0 iEINFtavg 001 0 1 0 2
		#ltype 0 plc 0 iEINFtavg
		angle 0
		define x1label "R/M"
		xla $x1label
		define x2label "z/M"
		#angle 360
		yla $x2label
		plcergo3
		#
		device X11
		#!gv iTdd00total.eps
		#!scp iTdd00total.eps metric:research/papers/bz/
		#!gv iTdd00total256fid.eps
		#!scp iTdd00total256fid.eps metric:research/papers/bz/
		!gv iTdd00total456fidzoom.eps
		!scp iTdd00total456fidzoom.eps metric:research/papers/bz/
		#
		#
		#
bzplot77pre 0       #
		# field line plot
		 fdraft
		 location 6000 31000 3500 31000
		 define x1label "r"
		 define x2label "\theta"
		 ltype 0 plc 0 aphitavg
		 #
bzplot77 0       #
		#
		 # dual panel plot for paper
		 # field line plot in cartesian interpolated map
		#
		window 1 1 1 1
		erase
		fdraft
		#
		#location 6000 31000 6000 31000
		#device postencap2 aphi2panel.eps
		device postencap aphi2panel.eps
		#
		define xin 0
		define xout (_Rout)
		define yin (-_Rout)
		define yout (_Rout)
		limits $xin $xout $yin $yout
		define x_gutter 0.3
		window 2 1 1 1 box 1 2 0 0
		define cres 20
		#define cres (-0.005491515691)
		jrdp dump0000
		fieldcalc fl0 fl0
		interpsingle fl0
		set plotvar=ifl0
		#
		#fdraft
		define coord (1)
		define x1label " "
		define x2label " "
		#location 6000 31000 6000 31000
		#location 3500 31000 3500 31000
		# XLABEL \raise-500My X-axis Label
		ltype 0 plc 0 plotvar 010
		angle 0
		define x1label "R c^2/(GM)"
		xla $x1label
		define x2label "z c^2/(GM)"
		#angle 360
		yla $x2label
		#
		limits $xin $xout $yin $yout
		#limits 0 _Rout -_Rout _Rout
		define x_gutter 0.3
		window 2 1 2 1 box 1 0 0 0
		define cres 20
		#define cres (-0.005491515691)
		jrdp dump0040
		fieldcalc fl40 fl40
		interpsingle fl40
		set plotvar=ifl40
		#
		#fdraft
		define coord (1)
		define x1label " "
		define x2label " "
		#location 6000 31000 6000 31000
		#location 3500 31000 3500 31000
		# XLABEL \raise-500My X-axis Label
		ltype 0 plc 0 plotvar 010
		angle 0
		define x1label "R c^2/(GM)"
		xla $x1label
		#define x2label "z c^2/(GM)"
		#angle 360
		#yla $x2label
		#
		#
		device X11
		!scp aphi2panel.eps metric:research/papers/bz/
		#
		#
bzplot78 0              #
		#
		# for paper
		# field line plot in cartesian interpolated map
		#
		#
		fdraft
		erase
		window 1 1 1 1
		location 6000 31000 6000 31000		
		device postencap2 itavgaphi.eps
		#device postencap2 itavgaphizoom.eps
		#device postencap2 i30aphi.eps
		#device postencap2 i40rout400aphi.eps
		#device postencap2 i32rout400aphi.eps
		#device postencap2 i25rout400lrho.eps
		#device postencap2 itavga0.5aphi.eps
		#device postencap2 i0aphi.eps
		#
		define cres 20
		#define cres (-0.005491515691)
		jrdp dump0000
		gammienew
		readtavgfl tavgfl aphitavg
		interpsingle aphitavg
		#jrdp1coli itavgfl iaphi
		#jrdp1coli i1fline iaphi
		#jrdp1coli ifl32 iaphi
		#jrdp1coli ifl20 iaphi
		#jrdp1coli ilrho ilrho
		#jrdp1coli itavgfl2 iaphi
		set plotvar=iaphitavg
		#
		define coord (1)
		define x1label " "
		define x2label " "
		location 6000 31000 6000 31000
		#location 3500 31000 3500 31000
		# XLABEL \raise-500My X-axis Label
		ltype 0 plc 0 plotvar
		angle 0
		define x1label "R c^2/(GM)"
		xla $x1label
		define x2label "z c^2/(GM)"
		#angle 360
		yla $x2label
		#
		device X11
		#!gv itavgaphi.eps
		!scp itavgaphi.eps metric:research/papers/bz/
		#!gv itavga0.5aphi.eps
		#!scp itavga0.5aphi.eps metric:research/papers/bz/
		#!gv i40rout400aphi.eps
		#!scp i40rout400aphi.eps metric:research/papers/bz/
		#!gv i32rout400aphi.eps
		#!scp i32rout400aphi.eps metric:research/papers/bz/
		#!gv i25rout400lrho.eps
		#!scp i25rout400lrho.eps metric:research/papers/bz/
		#!gv i30aphi.eps
		#!gv i40aphi.eps
		#!gv i0aphi.eps
		#!gv itavgaphizoom.eps
		#
bzplot79 0              #
		#
		# field line collimation vs. a
		#ltype 0 plc 0 iaphi 001 0 (1.45) 0 (1.45)
		#ltype 0 plc 0 iaphi 001 0 (1.0) 0 (1.0)
		ltype 0 plc 0 iaphi
		set myaphi=0.08        #a=0.9375 456^2
		#set myaphi=0.029 # a=0.5 256^2
		set lev=myaphi-1E-5,myaphi+1E-5,2E-5
		levels lev
		ctype blue contour
		#
		#
		#
bzplot80 0      #
		# vs. theta plots (old)
		 gcalc4 $rhor eflem eflemvsth
		 pl 0 newh eflemvsth
		 # and time averaged
		 joncalc4tavg $rhor 10 40
		 #
		 fdraft
		 location 6000 31000 3500 31000
		 define x1label " "
		 define x2label " "
		 ltype 0 ctype default pl 0 newh eflemvsthtavg
		 set it2=-1.0E-3*cos(newh)**2*sin(newh)**2
		 ltype 1 plo 0 newh it2
		 set it3=-1.0E-3*sin(newh)**2
		 ltype 2 plo 0 newh it3
		 define x1label "\theta"
		 define x2label " "
		 location 6000 31000 3500 31000
		 labelaxes 0
		 define x1label " "
		 define x2label "F_E^r (r_+)"
		 location 4800 31000 15000 31000
		 labelaxes 0
		 #
		 #
		 #
bzplot81 0             #
		#
		# wf vs theta
		pl 0 newh wfoomegahvsthtavg 0001 0 pi -1 1
		xlabel "\theta"
		ylabel "\omega/\Omega_H"
		#
		ctype default ltype 0 pl 0 newh brvsthtavg
		set it=0.1*cos(newh)
		ltype 1 plo 0 newh it
		set it2=0.1*cos(newh)/ABS(cos(newh))
		ltype 2 plo 0 newh it2
		xlabel "\theta"
		ylabel "B^r"
		#
		 pl 0 newh eflmavsthtavg
		 xlabel "\theta"
		 ylabel "E^r (r_+) (ma)"
		#
		#
		setlimits ($rhor) (1.2*$rhor) 0 pi 0 1 plflim 0 x2 r h lbrel 0
		#grmhd-a.9375-256by256-fl46=R1
		#grmhd-a.9375-256by256-newfl=R2
		# R2 max~4
		# R1 max~2
		# R1&R2 pretty uniform at pole
		#
		bzeflux
		# eflem, bzksp, -8.9E-4cos^2sin^2 and -1.1E-3...
		#
		 #device postencap erfit.eps
		  setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype default plflim 0 x2 r h eflem 0
		  #setlimits ($rhor) (1.01*$rhor) 2.5 pi 0 1 ctype default plflim 0 x2 r h eflem 0
		  setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype red plflim 0 x2 r h bzksp 0 001
		  set it1=-8.9E-4*cos(h)**2*sin(h)**2
		  setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype blue plflim 0 x2 r h it1 0 001
		  set it2=-1.1E-3*cos(h)**2*sin(h)**2
		  setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype green plflim 0 x2 r h it2 0 001
		  set it3=-1.1E-3*sin(h)**2
		  setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype cyan plflim 0 x2 r h it3 0 001
		  #
		# monopole plot
		set myb1=0.1
		set mywf2=0.156
		#set monobz=myb*mywf2*sin(h)**2*(myb1*(r-R0)*(-a+2*M*r*mywf2)+B3*Delta)
		# on horizon only
		set monobz=myb*mywf2*sin(h)**2*(myb1*(r-R0)*(-a+2*M*r*mywf2))
		setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype yellow plflim 0 x2 r h monobz 0 001		
		#
		gcalc2 4 pi/2 eflem eflemvsr
		gcalc2 4 pi/2 eflma eflmavsr
		gcalc2 4 pi/2 bzksp bzkspvsr
		gcalc2 4 pi/2 it1 it1vsr
		gcalc2 4 pi/2 it2 it2vsr
		gcalc2 4 pi/2 it3 it3vsr
		gcalc2 4 pi/2 monobz monobzvsr
		print {newr eflemvsr bzkspvsr it1vsr it2vsr it3vsr monobzvsr}
		#   newr    eflemvsr    bzkspvsr      it1vsr      it2vsr      it3vsr   monobzvsr
		#           1.33   -0.002087    -0.00211  -0.0005541  -0.0006848   -0.004593   -0.004526
		 #
		 gcalc2 4 1.14 eflem eflemvsr
		gcalc2 4 1.14 bzksp bzkspvsr
		gcalc2 4 1.14 it1 it1vsr
		gcalc2 4 1.14 it2 it2vsr
		gcalc2 4 1.14 it3 it3vsr
		gcalc2 4 1.14 monobz monobzvsr
		  #device X11		 
		#
		#               omega's
		set it1=.124*x1/x1
		set it2=.156*x1/x1
		setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype default plflim 0 x2 r h omegaf2 0
		setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype red plflim 0 x2 r h it1 0 001
		setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 ctype blue plflim 0 x2 r h it2 0 001
		gcalc2 4 1.14 omegaf2 omegaf2vsr
		joncalc2 ($rhor) (1.2*$rhor) .4
		# rat14=|uu1*bu3-uu3*bu1|/|B1|==omegaf2 in gtwod.m
		# rat15=|uu2*bu3-uu3*bu2|/|B2|==omegaf1 in gtwod.m
		# gives omegaf2~0.124 omegaf1~0.061
		#
		# omegaf2/omegah ~ 0.5 for most of pole, high pole drops to 0
		set it=omegaf2/omegah
		setlimits ($rhor) (1.2*$rhor) 0 pi 0 1 ctype default plflim 0 x2 r h it 0
		#
		#
		#
		#
		# for paper
		# field theta dependence (B1, F_E^r and F_M^r)
		# tavg
		#
		jrdp dump0000 # need to grab any dump first
		gammienew
		joncalc4tavg	($rhor) 10 40
		#
		# gives:
		# eflemvsthtavg
		# eflmavsthtavg
		# brvsthtavg
		# wfoomegahvsthtavg
		#
bzplot82 0      #
		#
		# FOR brvsthtavg
		#
		#device postencap br256a0.9375.eps
		#device postencap br456a0.9375.eps
		device postencap br256a0.5.eps
		#
		# for a=0.5 with normal sigma
		set up=0.02
		set down=-0.02
		set one=0.065
		set two=0.84
		# for a=0.9375 with normal sigma (256^2)
		#set up=0.11
		#set down=-0.11
		#set one=0.275
		#set two=0.59
		# for a=0.9375 with normal sigma (456^2)
		#set up=0.15
		#set down=-0.15
		#set one=0.32
		#set two=0.59
		define x1label "\theta"
		define x2label "B^r"
		fdraft
		ltype 0
		ctype default pl 0 newh brvsthtavg 0001 0 pi down up
		set rp=1+sqrt(1-a**2)
		set sigma=rp**2+a**2*cos(newh)**2
		#set sigma=rp**2
		set mono=one/sigma
		set split=(pi/2-newh)/ABS(pi/2-newh)
		set it1=split*mono
		set it1pert=split*mono*(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3*cos(2*newh))))/(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3)))
		set it2=mono*cos(newh)
		set it3=split*mono*cos(newh)**2
		#ctype red plo 0 newh it1
		#ctype cyan plo 0 newh it1pert
		#ctype blue plo 0 newh it2
		#ctype green plo 0 newh it3
		#ltype 1 plo 0 newh it1
		ltype 1 plo 0 newh it1pert
		#ltype 3 plo 0 newh it2
		#ltype 2 plo 0 newh it3
		#
		device X11
		#!gv br256a0.9375.eps
		#!scp br256a0.9375.eps metric:research/papers/bz/
		!gv br256a0.5.eps
		!scp br256a0.5.eps metric:research/papers/bz/
		#!gv br456a0.9375.eps
		#!scp br456a0.9375.eps metric:research/papers/bz/
		#
bzplot83 0      #
		#
		# FOR br2vsthtavg
		#
		#device postencap br2256a0.9375.eps
		#device postencap br2456a0.9375.eps
		device postencap br2256a0.5.eps
		#
		# for a=0.5 with normal sigma
		set up=0.004
		set down=0
		#set one=0.065
		#set two=0.84
		# match the equalorialized value at the pole
		set one=0.0661
		set two=0.84
		# for a=0.9375 with normal sigma (256^2)
		#set up=0.11
		#set down=-0.11
		#set one=0.275
		#set two=0.59
		# for a=0.9375 with normal sigma (456^2)
		#set up=0.15
		#set down=-0.15
		#set one=0.32
		#set two=0.59
		define x1label "\theta"
		define x2label "({B^r})^2"
		fdraft
		location 6000 31000 6000 31000
		ltype 0
		set toplot=br2vsthtavg*($rhor)**2
                set newbr2=br2vsthtavg*0
                do iii=0,$ny/2,1 {
                  set newbr2[$iii]=0.5*(toplot[$iii]+toplot[$ny-1-$iii])
                }
		#ctype default pl 0 newh br2vsthtavg 0001 0 pi down up
		erase
		xla $x1label
		yla $x2label
		piplot down up
		ctype default pl 0 newh newbr2 0011 0 pi/2 down up
		#
		#ctype default pl 0 newh newbr2 0001 0 pi/2 down up
		set rp=1+sqrt(1-a**2)
		set sigma=rp**2+a**2*cos(newh)**2
		#set sigma=rp**2
		set mono=one/sigma
		set split=(pi/2-newh)/ABS(pi/2-newh)
		set it1=split*mono
		set it1pert=split*mono*(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3*cos(2*newh))))/(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3)))
		set it2=mono*cos(newh)
		set it3=split*mono*cos(newh)**2
		#ctype red plo 0 newh it1
		#ctype cyan plo 0 newh it1pert
		#ctype blue plo 0 newh it2
		#ctype green plo 0 newh it3
		#ltype 1 plo 0 newh it1
		set it1pertsq=it1pert**2*($rhor)**2
		ltype 1 plo 0 newh it1pertsq
		#ltype 3 plo 0 newh it2
		#ltype 2 plo 0 newh it3
		if(a==0.5) { set itinflow=newh*0+.000784*($rhor)**2 }
		ltype 2 plo 0 newh itinflow
		#
		device X11
		#!gv br2256a0.9375.eps
		#!scp br2256a0.9375.eps metric:research/papers/bz/
		!gv br2256a0.5.eps
		!scp br2256a0.5.eps metric:research/papers/bz/
		#!gv br2456a0.9375.eps
		#!scp br2456a0.9375.eps metric:research/papers/bz/
		#
bzplot84 0      #
		#
		# FOR eflemvsthtavg (directly should use values of b^r above, one and two constants )
		#
		jrdp dump0000
		gammienew
		joncalc4read
		#
		#device postencap fe256a0.9375.eps
		#device postencap fe456a0.9375.eps
		device postencap fe256a0.5.eps
		#
		# for a=0.5 with normal sigma
		set up=2E-5
		set down=-2E-5
		set one=0.0661
		# for a=0.9375 with normal sigma (256^2)
		#set up=1.5E-4
		#set down=-7E-4
		#set one=0.275
		# for a=0.9375 with normal sigma (456^2)
		#set up=4E-4
		#set down=-1E-4		        
		#set one=0.32
		define x1label "\theta"
		define x2label "F^{(EM)}_E"
		fdraft
		location 6000 31000 6000 31000
		ltype 0
                set neweflem=eflemvsthtavg*0
		# switch sign and change from [KSP]->[KS,BL]
		set toplot=-eflemvsthtavg*$rhor
                do iii=0,$ny/2,1 {
                  set neweflem[$iii]=0.5*(toplot[$iii]+toplot[$ny-1-$iii])
                }
		#ctype default pl 0 newh (-eflemvsthtavg) 0001 0 pi down up
		#
		erase
		xla $x1label
		yla $x2label
		piplot down up
		ctype default pl 0 newh neweflem 0011 0 pi/2 down up
		#
		set rp=1+sqrt(1-a**2)
		set sigma=rp**2+a**2*cos(newh)**2
		set omegah=a/(rp**2+a**2)
		set omegamono=a/8
		#set sigma=rp**2
		set mono=one/sigma
		set split=(pi/2-newh)/ABS(pi/2-newh)
		set wf2=wfoomegahvsthtavg*omegah
		smooth wf2 wf2s 30
		set it1=split*mono
		set eflemit1=($rhor-R0)*it1**2*(omegamono)*sin(newh)**2*(omegamono-omegah)*(rp**2+a**2)
		set it1pert=split*mono*(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3*cos(2*newh))))/(1+a**2*(1/8*(-cos(2*newh))+(pi**2/12-49/72)*(3)))
		set eflemit1pert=-($rhor-R0)*it1pert**2*(omegamono)*sin(newh)**2*(omegamono-omegah)*(rp**2+a**2)
		# can't use wf2 for omegaf since it causes too much noise in plot, must be bad idea
		set eflemit1pert2=($rhor-R0)*it1pert**2*(omegamono)*sin(newh)**2*(omegamono-omegah)*(rp**2+a**2)
		set it2=mono*cos(newh)
		set eflemit2=($rhor-R0)*it2**2*(omegamono)*sin(newh)**2*(omegamono-omegah)*(rp**2+a**2)
		set it3=split*mono*cos(newh)**2
		# a=0.5 256^2
		set it3=newh*0+8.05*10**(-6)*$rhor
		# do nothing
		# a=0.9375 256^2
		#set it3= (ABS(newh-pi/2)>pi/2-0.9) ? it3 : 0.05
		# a=0.9375 456^2
		#set it3= (ABS(newh-pi/2)>pi/2-0.9) ? it3 : 0.045 
		set eflemit3=($rhor-R0)*it3**2*(omegamono)*sin(newh)**2*(omegamono-omegah)*(rp**2+a**2)
		#
		#ctype red plo 0 newh it1
		#ctype cyan plo 0 newh it1pert
		#ctype blue plo 0 newh it2
		#ctype green plo 0 newh it3
		#ltype 1 plo 0 newh eflemit1
		#
		# normally for a=0.5
		set itgod=eflemit1pert*$rhor
		ltype 1 plo 0 newh itgod
		ltype 2 plo 0 newh it3
		#
		#ltype 2 plo 0 newh eflemit3
		#ltype 2 plo 0 newh eflemit1pert2
		#ltype 3 plo 0 newh eflemit2
		
		#
		device X11
		#!gv fe256a0.9375.eps
		#!scp fe256a0.9375.eps metric:research/papers/bz/
		!gv fe256a0.5.eps
		!scp fe256a0.5.eps metric:research/papers/bz/
		#!gv fe456a0.9375.eps
		#!scp fe456a0.9375.eps metric:research/papers/bz/
		#
		#
bzplot85 0      #
		# FOR wfoomegahvsthtavg
		#
		#device postencap wfowh256a0.9375.eps
		device postencap wfowh456a0.9375.eps
		#device postencap wfowh256a0.5.eps
		#
		# for a=0.5 with normal sigma
		#set up=2.0
		#set down=-2.0
		# for a=0.9375 with normal sigma (256^2)
		#set up=2.0
		#set down=-2.0
		# for a=0.9375 with normal sigma (456^2)
		set up=2.0
		set down=-2.0
		define x1label "\theta"
		define x2label "\omega / \Omega_H"
		fdraft
		ltype 0
		ctype default pl 0 newh wfoomegahvsthtavg 0001 0 pi down up
		set it1=newh*0+1/2
		set it2=a/8/omegah+newh*0
		set newitgammie=0.26/omegah+newh*0
		set itpara=((1/4)*sin(newh)**2*(1+LN(1+cos(newh))))/(4*LN(2)+sin(newh)**2+(sin(newh)**2-2*(1+cos(newh)))*LN(1+cos(newh)))
		set it3=a*itpara/omegah 
		set it4=itpara*4
		#ctype red plo 0 newh it1
		#ctype cyan plo 0 newh it1pert
		#ctype blue plo 0 newh it2
		#ctype green plo 0 newh it3
		ctype default ltype 1 plo 0 newh it1
		#ltype 3 plo 0 newh itpara
		#ctype default ltype 2 plo 0 newh it2
		#ltype 3 plo 0 newh it2
		#ctype red ltype 3 plo 0 newh it3
		ctype default ltype 3 plo 0 newh newitgammie
		#ctype green ltype 4 plo 0 newh it4
		#
		device X11
		#!gv wfowh256a0.9375.eps
		#!scp wfowh256a0.9375.eps metric:research/papers/bz/
		#!gv wfowh256a0.5.eps
		#!scp wfowh256a0.5.eps metric:research/papers/bz/
		!gv wfowh456a0.9375.eps
		!scp wfowh456a0.9375.eps metric:research/papers/bz/
		#
		#
bzplot86 0      #
		# FOR eflmavsttavg
		#
		#device postencap fm256a0.9375.eps
		device postencap fm456a0.9375.eps
		#device postencap fm256a0.5.eps
		#
		# for a=0.5 with normal sigma
		#set up=0.035
		#set down=1E-5
		# for a=0.9375 with normal sigma (256^2)
		#set up=0.035
		#set down=1E-5
		# for a=0.9375 with normal sigma (456^2)
		set up=0.035
		set down=1E-5
		define x1label "\theta"
		define x2label "-F^{(MA)}_E"
		fdraft
		ltype 0
                set neweflma=eflmavsthtavg*0
                do iii=0,$ny/2,1 {
                  set neweflma[$iii]=0.5*(eflmavsthtavg[$iii]+eflmavsthtavg[$ny-1-$iii])
                }
                # 
                #ctype default pl 0 newh eflmavsthtavg 0101 0 pi down up
                ctype default pl 0 newh neweflma 0101 0 pi/2 down up
		#
		device X11
		#!gv fm256a0.9375.eps
		#!scp fm256a0.9375.eps metric:research/papers/bz/
		#!gv fm256a0.5.eps
		#!scp fm256a0.5.eps metric:research/papers/bz/
		#!gv fm456a0.9375.eps
		!scp fm456a0.9375.eps metric:research/papers/bz/
		#
		#
bzplot87 0      #
		# angle of field w.r.t. monopole and multipole expansion
		set it=ATAN(B2/B1)
		ctype default setlimits ($rhor) (1.01*$rhor) 0 pi 0 1 plflim 0 x2 r h it 0
		set it=0*it
		ctype cyan setlimits ($rhor) (1.2*$rhor) 0 pi 0 1 plflim 0 x2 r h it 0 001
		#
		#
		set newh=h if(ti==0)
		set newtx2=tx2 if(ti==0)
		set newdh=dh if(ti==0)
		der newtx2 newh newtx2d newhd
		set newhd=newhd*$dx2
		#
		#set myb=ABS(brvsthtavg)
		set myb=brvsthtavg
		set x=cos(newh)
		set split=x/ABS(x)
		set split=x/x
		# pnp = ((2*n+1)*x*pn-n*pnm)/(n+1)
		set n=0 set norm0=(2*n+1)/2		set p0=1*split
		set n=1  set norm1=(2*n+1)/2		set p1=x
		set n=2  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n*split
		set n=3  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n
		set n=4  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n*split
		set n=5  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n
		set n=6  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n*split
		set n=7  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n
		set n=8  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n*split
		set n=9  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n
		set n=10  define l (n) define lm1 (n-1) define lm2 (n-2) set norm$l=(2*n+1)/2 set p$l=((2*n-1)*x*p$lm1-(n-1)*p$lm2)/n*split
		#
		set n=0 define l (n) set a$l=SUM(p0*myb*sin(newh)*newdh)*norm$l
		set n=1 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=2 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=3 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=4 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=5 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=6 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=7 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=8 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=9 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		set n=10 define l (n) set a$l=SUM(p$l*myb*sin(newh)*newdh)*norm$l
		print {a0 a1 a2 a3 a4 a5 a6 a7 a8 a9 a10}
		ctype default pl 0 newh myb
		set newb=a0*p0+a1*p1+a2*p2+a3*p3+a4*p4+a5*p5+a6*p6+a7*p7+a8*p8+a9*p9+a10*p10
		#set newb=a4*p4
		ctype red plo 0 newh newb
		#
		#
		set rp=1+sqrt(1-a**2)
		set sigma=rp**2+a**2*cos(h)**2
		set it1=0.1/sigma
		set it2=it1*cos(h)
		set it3=it1*(pi/2-h)/ABS(pi/2-h)*cos(h)**2
		define innerr (1.0*$rhor)
		define outerr (1.01*$rhor)
		setlimits ($innerr) ($outerr) 0 pi 0 1 ctype default plflim 0 x2 r h B1 0		
		setlimits ($innerr) ($outerr) 0 pi 0 1 ctype red plflim 0 x2 r h it1 0 001
		setlimits ($innerr) ($outerr) 0 pi 0 1 ctype red plflim 0 x2 r h it2 0 001
		setlimits ($innerr) ($outerr) 0 pi 0 1 ctype blue plflim 0 x2 r h it3 0 001
		# B1 ~ 0.08*Cos(theta)		
		# B1 ~ r^{-2.37} -> r^{-2.44} -> r^{-2.9} near inner radial edge at high pole
		#
		#
		# check for monopolicity
		set it=omegaf2*8/a
		setlimits ($rhor) (1.2*$rhor) 0 pi 0 1 ctype default plflim 0 x2 r h it 0
		# gives ~ 1.38 except very high poles drops to 0 
		#               #
bzplot88 0      #
		#		for paper (replaces below as more general)
		set pick=1
		set doeps=1
		#	
		da vsacleanreal.txt
		lines 1 100000
		read {a 9 empomat 61 emtomat 62}
		fdraft
		#rdraft
		if((pick==0)&&(doeps==1)) { device postencap empomatfull.eps }
		if((pick==1)&&(doeps==1)) { device postencap emtomatfull.eps }
		location 3500 31000 3500 31000
		define x1label "a"
		if(pick==0) { define x2label "{\dot{E}}_{EE(pole)}^r     /F_{ME(total)}^r" }
		#if(pick==1) { define x2label  "{\dot{E}}^{(EM)}  /{\dot{E}}^{(MA)}" }
		if(pick==1) { define x2label  "{\dot{E}}^{(EM)}/{\dot{E}}^{(MA)}" }
		if(pick==0) { limits a empomat erase labelaxes 0 }
		if(pick==1) { limits a emtomat erase labelaxes 0 }
		if(pick==0) { set myy=empomat }
		if(pick==1) { set myy=emtomat }
		location 5500 31000 3500 31000
		set rp=1+sqrt(1-a**2)
		set omegah=a/(a**2+rp**2)
		#
		if(pick==0) { set myfunc=1.29E-5-.0405711*(2-rp)**3 }
		if(pick==1) { 		set myfunc=-.0682134*(2-rp)**2 }
		#set myfunc=.0034418-.0682134*(2-rp)**2
		#
		box
		ctype default ltype 0 plo 0 a myy
		ctype default ltype 1 plo 0 a myfunc
		if(doeps==1) { device X11 }
		if(doeps==1) { !gv emtomatfull.eps }
		#
		#
		#
 bzplot89 0     #		
		# for paper (not really good anymore)
		#
		# for something vs. a in power law
		da smallexcel.txt
		lines 1 100000
		read {emomap 7 emomatot 8 wf1 9 wf2 10 b2poi 14 b2poc 15}
		fdraft
		set a=0,9,1
		set a[0]=0
		set a[1]=0.5
		set a[2]=0.75
		set a[3]=0.875
		set a[4]=0.894888
		set a[5]=0.9
		set a[6]=0.911612
		set a[7]=0.9375
		set a[8]=0.96875
		set a[9]=0.999
		set rp=1+sqrt(1-a**2)
		set omegah=a/(rp**2+a**2)
		#set it=abs(wf1/omegah)
		set it=emomatot
		#set it=emomap
		set lga=LG(ABS(a)) if(a>0.2)
		set lgit=LG(ABS(it)) if(a>0.2)
		# for emomap 456^2
		#ctype default pl 0 a it 1101 0.4 1.1 2E-2 0.4
		# for emomatot 456^2
		ctype default pl 0 a it 1101 0.4 1.1 1E-3 0.1
		erase
		#device postencap emomap.eps
		device postencap emomatot.eps
		box
		ptype 6 3
		points lga lgit
		  xlabel "a"
		  #ylabel "F_{EE(pole)}^r     /F_{ME(total)}^r"
		  ylabel  "F_^{(EM)}_E     /F^{(MA)}_E"
                  lsq lga lgit lga lsqit rms
		  set mym=$a
		  set myb=$b
		  set myrms=$rms
		  set sigm=$sig_a
		  set sigb=$sig_b
		  set chisq=$CHI2
		 print {lga mym myb myrms chisq}
		 set testit=a**(mym)*10**(myb) if(a>0.2)
		 set lgtestit=LG(testit)
		 ctype red pl 0 lga lgtestit 0010
		 print {lgit lsqit lgtestit}
		 device X11
		 !gv emomatot.eps
		 !scp emomatot.eps metric:research/papers/bz/
		 #!gv emomap.eps
		 #!scp emomap.eps metric:research/papers/bz/
		#
bzplot90 0      #
		#		inflow solution stuff
		#
		#
		#
		#
		#set hor=0.05
		set hor=0.7
		gcalc2 3 1 hor efl eflvsr
		gcalc2 3 2 hor omega3 omega3vsr
		gcalc2 3 1 hor lfl lflvsr
		gcalc2 3 2 hor einf einfvsr
		gcalc2 3 2 hor linf linfvsr
		gcalc2 3 1 hor mfl mflvsr
		set giratvsr2=-eflvsr/(omega3vsr*lflvsr+(einfvsr-linfvsr*omega3vsr)*mflvsr)
		pl 0 newr giratvsr2
		ctype default pl 0 newr giratvsr2 0001 ($rhor) 10 0.5 1.2
		ctype red vertline riscoretrograde
		ctype red vertline riscoprograde
		#
		#
		gcalc2 3 2 hor girat giratvsr
		pl 0 newr giratvsr
		#
		#
		#
		# avgtimeg3 'dump' 10 40
		#
		#
		#
		set hor=0.002
		ctype default setlimits ($rhor) 40 (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h wfc 1
		gcalc2 2 2 0.05 afdd23tavg afdd23tavgvsr
		#
bzdoallpre91 1  #
		set hor=$1
		set omegah=a/(2*rp)
		bzpre91 hor amfltavg mfltavg
		#
		bzpre91 hor alfltavg lfltavg
		#
		bzpre91 hor aefltavg efltavg
		#
		# this can be compared to above plot
		bzpre91 hor aefl2tavg efl2tavg
		#
		bzpre91 hor afdd23tavg fdd23tavg
		#
		bzpre91 hor afdd23tavg fdd23tavg
		#
		bzpre91 hor afdd02tavg fdd02tavg
		#
		set wfowh=afdd02tavgvsr/afdd23tavgvsr/omegah
		#
		set magparam=afdd23tavgvsr/amfltavgvsr
		set mymagparm=afdd23tavg/mfltavg
		#
		gcalc2 3 2 hor mymagparm mymagparmvsr
		set mymagparm2=fdd23tavg/mfltavg
		#
bzdoallplot91 1 #
		define doprint (1)
		set hor=$1
		set omegah=a/(2*rp)
		#
		if($doprint) { device postscript }
		bzplot91 hor amfltavg mfltavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		bzplot91 hor alfltavg lfltavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		bzplot91 hor aefltavg efltavg
		if($doprint) { device X11 }
		#
		# this can be compared to above plot
		if($doprint) { device postscript }
		bzplot91 hor aefl2tavg efl2tavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		bzplot91 hor afdd23tavg fdd23tavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		bzplot91 hor afdd23tavg fdd23tavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		bzplot91 hor afdd02tavg fdd02tavg
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		define x2label "wfowh"
		ctype default pl 0 newr wfowh 0001 $rhor  (1.5*risco)  -.1 1
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		define x2label "magparam"
		ctype default pl 0 newr magparam 0001 $rhor  (1.5*risco)  0 4
		if($doprint) { device X11 }
		if($doprint) { device postscript }
		define x2label "mymagparm"
		ctype default setlimits ($rhor)  (1.5*risco)  (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h mymagparm
		if($doprint) { device X11 }
		#
		if($doprint) { device postscript }
		define x2label "mymagparmvsr"
		ctype default pl 0 newr mymagparmvsr 0001 0  (1.5*risco)  -10 10 
		if($doprint) { device X11 }
		if($doprint) { device postscript }
		define x2label "mymagparm2"
		ctype default setlimits ($rhor)  (1.5*risco)  (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h mymagparm2
		if($doprint) { device X11 }
		#
		#
		# einf
		if($doprint) { device postscript }
		define x2label "einf"
		ctype default setlimits ($rhor)  (1.5*risco)  (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h einftavg
		ctype red vertline risco
		if($doprint) { device X11 }
		#
		# linf
		if($doprint) { device postscript }
		define x2label "linf"
		ctype default setlimits ($rhor)  (1.5*risco)  (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h linftavg
		ctype red vertline risco
		if($doprint) { device X11 }
		#
		# uu1=0 at isco?
		if($doprint) { device postscript }
		define x2label "uu1"
		ctype default setlimits ($rhor) (1.5*risco) (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h uu1tavg
		ctype red vertline risco
		if($doprint) { device X11 }
		#
		#
		#
bzdoall91 0     #
		set hor=0.05
		bzdoallpre91 hor
		bzdoallplot91 hor
		#
		set hor=0.3
		bzdoallpre91 hor
		bzdoallplot91 hor
		#
		#
		#
		#
bzpre91 3       # bzpre91 hor amfltavg mfltavg
		set hor=$1
		gcalc2 3 1 hor $2 $2vsr
		gcalc2 3 1 hor $3 $3vsr
		set first=$2vsr
		set second=$3vsr
		#
bzplot91 3      #
		set hor=$1
		set first=$2vsr
		set second=$3vsr
		define x1label "r c^2/(GM)"
		define x2label "$!!2"
		#
		set newnewr=newr if((newr>=_Rin)&&(newr<=risco)) 
		set new1=first if((newr>=_Rin)&&(newr<=risco)) 
		set new2=second if((newr>=_Rin)&&(newr<=risco)) 
		minmaxs newnewr new1		
		sort {mins}
		set down=mins[0]
		sort {maxes}
		set up=maxes[dimen(maxes)-1]
		avg newnewr new1 new1avg
		avg newnewr new2 new2avg
		set up=up/new1avg
		set down=down/new1avg
		set newnew1=first/new1avg
		set newnew2=second/new2avg
		ctype default pl 0 newr newnew1 0001 _Rin (1.5*risco) down up
		ctype red plo 0 newr newnew2
		ctype blue vertline $rhor
		ctype cyan vertline risco
		#		
		#
bzplot911    0  #
		#
		#
		#
bzplot92        0 #
		#
		#		in disk/inflow
		# wf and omega
		#
		# after doing avgtimeg3 'dump' 10 40
		# printg3
		#
		readg3
		bzeflux
		#
		# see radial dependence
		#
		set hor=0.005
		gcalc2 3 2 hor afdd23tavg afdd23tavgvsr
		gcalc2 3 2 hor afdd02tavg afdd02tavgvsr
		set awf2=afdd02tavg/afdd23tavg
		gcalc2 3 2 hor awf2 awf2vsr
		gcalc2 3 2 hor omega3tavg omega3tavgvsr
		#gcalc2 3 2 hor awftavg awftavgvsr
		#gcalc2 3 2 hor wftavg wftavgvsr
		#
		# different forms possible for omega/omegah
		#
		set wratvsr=afdd02tavgvsr/afdd23tavgvsr/omegah
		set omega3ratvsr=omega3tavgvsr/omegah
		set awftavgratvsr=awftavgvsr/omegah
		set wftavgratvsr=wftavgvsr/omegah
		set awf2ratvsr=awf2vsr/omegah
		#
bzplot93 0      #
		# wf vs theta
		jrdp dump0000
		gammienew
		readg3 tavg3.txt
		bzeflux
		#
		#device postencap wfowh2456a0.9375.eps
		#device postencap wfowh2256a0.9375.eps
		#device postencap wfowh2256a0.5.eps
		#device postencap wfowh2256a0.1.eps
		#
		#
		#different possible forms for omega
		set wf1c=fdd01tavg/fdd13tavg
		set awf1c=ABS(fdd01tavg/fdd13tavg)
		set wf1ca=afdd01tavg/afdd13tavg
		# wf1tavg, awf1tavg
		#
		set wf2c=fdd02tavg/fdd23tavg
		set awf2c=ABS(fdd02tavg/fdd23tavg)
		set wf2ca=afdd02tavg/afdd23tavg
		# wf2tavg, awf2tavg
		if(0) {\
		       # for single dump
		       set wf1ca=ABS(fdd01)/ABS(fdd13)
		       set wf2ca=ABS(fdd02)/ABS(fdd23)
		}
		#
		#
		# 1 or 2 (standard is 2)
		define wwf (2)
		set radius=1.0*$rhor
		#
		gcalc4 radius omega3tavg omega3tavgvsth
		if($wwf==1){\
		       gcalc4 radius wf1c wfcvsth
		       gcalc4 radius awf1c awfcvsth
		       gcalc4 radius wf1ca wfcavsth
		       gcalc4 radius wf1tavg wftavgvsth
		       gcalc4 radius awf1tavg awftavgvsth
		    }
		if($wwf==2){\
		       gcalc4 radius wf2c wfcvsth
		       gcalc4 radius awf2c awfcvsth
		       gcalc4 radius wf2ca wfcavsth
		       gcalc4 radius wf2tavg wftavgvsth
		       gcalc4 radius awf2tavg awftavgvsth
		    }
		 set ratc=wfcvsth/omegah
		 set ratac=awfcvsth/omegah
		 set ratca=wfcavsth/omegah
		 set ratt=wftavgvsth/omegah
		 set ratat=awftavgvsth/omegah
		 set rato3=omega3tavgvsth/omegah
		 #
		 # pick which one to plot
		 #
		 set toplot=ratca
		 #
		 #
		 #
		 # now plot
		 fdraft
		 #
		 define x1label "\theta"
		 define x2label "\omega/\Omega_H"
		 #
                 set newwfowh=toplot*0
                 do iii=0,$ny/2,1 {
                   set newwfowh[$iii]=0.5*(toplot[$iii]+toplot[$ny-1-$iii])
                 }
		 erase
		 xla $x1label
		 yla $x2label
		 set down=0
		 set up=1
		 ctype default
		 piplot down up
		 #ctype default ltype 0 pl 0 newh itca 0001 0 pi 0 1
                 ctype default ltype 0 pl 0 newh newwfowh 0011 0 pi/2 0 1
		 #
		 # other lines (analytics)
		 # bz ideal
		 set idealwfowh=0.5+toplot*0
		 # inflow
		 ctype default ltype 1 pl 0 newh idealwfowh 0010
		 if(a==0.5) { set gammiewfowh=0.811+toplot*0 }
		 if(a==0.9375) { set gammiewfowh=0.745+toplot*0 }
		 ctype default ltype 2 pl 0 newh gammiewfowh 0010
		 #
		 #
		 #
		 #
		 #device X11
		 #!gv wfowh2456a0.9375.eps
		 #!scp wfowh2456a0.9375.eps metric:research/papers/bz
		 #!scp wfowh2256a0.9375.eps metric:research/papers/bz
		 #!gv wfowh2256a0.5.eps
		 #!scp wfowh2256a0.5.eps metric:research/papers/bz
		 #!scp wfowh2256a0.1.eps metric:research/papers/bz
		 #
bzplot935
		 # so should time average conserved quantities, not omega, for more stable solution
		 # seems ratio of time average of absolute value works best for smooth solution (red)
		 # although of course this means something different
		 joncalc3 1 2 ($rhor) (1.2*$rhor) 0.7 wfca answer
		 set rat=answer/omegah print {rat}
		 #
		 joncalc3 1 3 ($rhor) (1.2*$rhor) 0.7 afdd02tavg answer1
		 joncalc3 1 3 ($rhor) (1.2*$rhor) 0.7 afdd23tavg answer2
		 set rat2=answer1/answer2/omegah print {rat2}
		#
		ctype default pl 0 newr eflvsr 0001 0 40 -1 1
		ctype red setlimits ($rhor) 40 (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h eflux 1 001
		#
		joncalc3 2 3 $rhor risco hor efla result
		#
		# this works, pure average of the ratio, since not geometric quantity anymore
		joncalc3 2 4 $rhor risco hor girat result
		# ~1.064 for a=0.9375 256^2
		# up to theta+-0.7.  After, 1/2 at theta+-0.8
		ctype default setlimits ($rhor) 40 (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h girat 1
		# for just equator
		ctype default setlimits ($rhor) 40 (pi/2-hor/30) (pi/2+hor/30) -1 1 plflim 0 x1 r h girat 1
		#
		gcalc4 risco girat giratvsth
		pl 0 newh giratvsth
		#
		#
		set fdd23=gdet*ABS(B1)
		set girat2=fdd23/mflux
		ctype default setlimits ($rhor) 40 (pi/2-hor) (pi/2+hor) -1 1 plflim 0 x1 r h girat2 1
		#
		set hor=0.7
		gcalc2 3 1 hor fdd23 fdd23vsr
		gcalc2 3 1 hor mflux mfluxvsr
		set girat2vsr=fdd23vsr/mfluxvsr
		pl 0 newr girat2vsr		
		ctype default pl 0 newr girat2vsr 0001 ($rhor) 10 -100 100
		ctype red vertline riscoretrograde
		ctype red vertline riscoprograde
		#
		#      
		#		
		#
		#
		#
bzplot94 0      # fast point contour for a single timeslice
		#
		#
		plcfastpoint
		fastrcalc risco 0.7 myfastr
		print {myfastr}
		#
		#
		#
bzplot95 0      #
		#		for paper, dot's vs. time
		# for 456^2
		ctype default
		gammieenerold2
		#
		fdraft
		ltype 0
		window 1 1 1 1
		notation -4 4 -4 4
		#myplotdo2
		erase
		#now setup
		device postencap 3dotpanel456a.9375.eps
		#
		#define x1label "t c^3/(GM)"
		#define x2label "\dot{M}_0 "
		#
		set mdot=dm
		set edot=de
		set ldot=dl
		set m0=-dm
                   limits t m0
                   window -8 -3 2:8 3 box 0 2 0 0
		   #yla -\dot{M}_0
		   relocate -500 1.5
		   putlabel 5 -\dot{M}_0
		   plo 0 t m0
		   ltype 2
                   set blah=(t+1E-6)/(t+1E-6)*0.35
                   plo 0 t blah
                   #
                   set tempf=edot/mdot
                   limits t 0 1.7
                   window -8 -3 2:8 2 box 0 2 0 0
		   define thisy (1.7/2)
		   relocate -500 $thisy
		   #putlabel 5 "\dot{E}/\dot{M}_0"
		   putlabel 5 "e"
		   #yla "\dot{E}/\dot{M}_0"
                   ltype 0
                   plo 0 t tempf
		   # dotted
                   ltype 1
                   set blah=(t+1E-6)/(t+1E-6)*(.821)
                   plo 0 t blah
		   # dashed
                   ltype 2
                   set blah=(t+1E-6)/(t+1E-6)*(.87)
                   plo 0 t blah
		   #relocate (25000 13800)
                   expand 1.1
		   #label thin disk
                   expand 1.5
                   #
		   set tempf=ldot/mdot
                   #limits t tempf
                   limits t 0 3.9
                   window -8 -3 2:8 1 box 1 2 0 0
		   define thisy (3.9/2)
		   relocate -500 $thisy
		   #putlabel 5 "\dot{L}/\dot{M}_0"
		   putlabel 5 "j"
		   #
		   #yla "\dot{L}/\dot{M}_0"
		   xla t c^3/(G M)
                   ltype 0
                   plo 0 t tempf
                   ltype 1
                   set blah=(t+1E-6)/(t+1E-6)*1.95
                   plo 0 t blah
                   ltype 2
                   set blah=(t+1E-6)/(t+1E-6)*1.46
                   plo 0 t blah
                   #relocate (25000 11000)
		   expand 1.1
		   #label thin disk
                   expand 1.5
                   device X11
		   #!gv 3dotpanel456a.9375.eps
		   !scp 3dotpanel456a.9375.eps metric:research/papers/bz
		   #
		# omega3/omegak
bzplot96        0 #
		 jrdp dump0005
		 gcalc2 3 2 0.57 omega3ok omega3okvsr5
		 jrdp dump0030		 
		 gcalc2 3 2 0.57 omega3ok omega3okvsr30
		 jrdp dump0020		 
		 gcalc2 3 2 0.57 omega3ok omega3okvsr20
		 jrdp dump0010		 
		 gcalc2 3 2 0.57 omega3ok omega3okvsr10
		 jrdp dump0000
		 gcalc2 3 2 0.57 omega3ok omega3okvsr0
		 jrdp dump0040
		 gcalc2 3 2 0.57 omega3ok omega3okvsr40
		 #
		define x1label "r c^2/(GM)"
		define x2label "\Omega/\Omega_K"		 
		#device postencap omega3oomegak.eps
		 ctype default pl 0 newr omega3okvsr0
		 ctype default ltype 1 plo 0 newr omega3okvsr40
		 ltype 0
		 ctype blue plo 0 newr omega3okvsr20
		 ctype green plo 0 newr omega3okvsr5
		 ctype red plo 0 newr omega3okvsr10
		 ctype cyan plo 0 newr omega3okvsr30
		 #device X11
		 #!scp omega3oomegak.eps metric:research/papers/bz
		 #
bzplot97pre12   0 # can redo if altered number of columns
		avgtimegfull 'dump' 20 40
		gfull2normal
		# includes bsq and aphi
		gwritedump dumptavg2040
		greaddump dumptavg2040 
		equatorequalize
		gwritedump dumptavg2040equalize
		#
bzplot97pre1    0    #
		 #
		# side cartoon for b^2/rho=1 and beta=1 and wind
		# shouldn't have to do everytime
		jrdp dump0000
		gammienew
		#
		# bzplot97pre12           # avoid if already have data
		#
		#
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle libeta
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle uu1
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle lbrel
		greaddumpold dumptavg2040equalize
		gammienew
		set outud0=(uu1>0.0) ? ud0 : 1
		interpsingle outud0
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle ud0
		greaddumpold dumptavg2040equalize
		gammienew
		#
bzplot97pre2    0    #
		# should really use time averaged aphi (check at least)
		#fieldcalc tavg2040 aphi
		interpsingle aphi
		#
		# now we have libeta and lbrel and ud0
		define cres 20
		plc 0 ioutud0 001 0 40 0 40
		set myoutud0=newfun
		#
		plc 0 iud0 001 0 40 0 40
		set myud0=newfun
		#
		plc 0 ilbrel 001 0 40 0 40
		set mylbrel=newfun
		#
		plc 0 ilibeta 001 0 40 0 40
		set mylibeta=newfun
		#
		#
		#
		# to plot do below
bzplot97do 0    #
		#
		set printeps=0
		#
		#
		#erase
		#
		fdraft
		#
		if (printeps==1) { device postencap f2abeta13.eps }
		#
		# the funnel-corona boundary
		set mybeta=1
		set mylev=lg(1/mybeta)
		set image[ix,iy] = mylibeta
		ltype 0 ctype default
		box
		xla "R c^2/(GM)"
		yla "z c^2/(GM)"
		set lev=mylev-1E-9,mylev+1E-9,2E-9
		levels lev		
		ctype magenta contour
		#
		#
		# the disk-corona boundary
		set mybeta=3
		set mylev=lg(1/mybeta)
		set image[ix,iy] = mylibeta
		ltype 0 ctype default
		box
		set lev=mylev-1E-12,mylev+1E-12,2E-12
		levels lev
		ctype cyan contour
		#
		# the beta=10 (libeta=1) boundary
		#set image[ix,iy] = mylibeta
		#ltype 0 ctype default
		#box
		#set lev=1-1E-9,1+1E-9,2E-9
		#levels lev
		#ctype blue contour
		#
		# the beta=100 (libeta=2) boundary
		#set image[ix,iy] = mylibeta
		#ltype 0 ctype default
		#box
		#set lev=2-1E-9,2+1E-9,2E-9
		#levels lev
		#ctype blue contour
		#
		# the b^2/rho=1/1000 boundary
		#set image[ix,iy] = mylbrel
		#ltype 0 ctype default
		#box
		#set lev=-3-1E-9,-3+1E-9,2E-9
		#levels lev
		#ctype red contour
		#
		## the b^2/rho=1/100 boundary
		#set image[ix,iy] = mylbrel
		#ltype 0 ctype default
		#box
		#set lev=-2-1E-9,-2+1E-9,2E-9
		#levels lev
		#ctype red contour
		#
		# the b^2/rho=1/10 boundary
		#set image[ix,iy] = mylbrel
		#ltype 0 ctype default
		#box
		#set lev=-1-1E-9,-1+1E-9,2E-9
		#levels lev
		#ctype red contour
		#
		# the b^2/rho=1 boundary
		set image[ix,iy] = mylbrel
		ltype 0 ctype default
		box
		set lev=-1E-9,1E-9,2E-9
		levels lev
		ctype red contour
		#
		set image[ix,iy] = myoutud0
		ltype 0 ctype default
                #
		# the wind
		set lev=-1-1E-9,-1+1E-9,2E-9
		levels lev
		ctype default contour
		#
		# the jet
		#set lev=$min,-2,(-2-$min)/10
		#levels lev
		#ctype green contour
                #
		set image[ix,iy] = myud0
		ltype 0 ctype default
		box
		minmax min max echo $min $max
		#
		#
		# the outer and inner radial edges
		set lev=0,1E-6,1E-6
		levels lev
		lweight 4 ctype default contour
                lweight 3
		#
		if(printeps==1) {\
		       device X11
		       !scp f2abeta13.eps metric:research/papers/bz/
		    }
		#
		#
bzplot98 0      #
		# time average of field plot for paper
		#
		#(from above interp)
		#
		#
		device postencap aphitavghalf.eps
		#
		define x1label "R c^2/(GM)"
		define x2label "z c^2/(GM)"
		plc 0 iaphi 001 0 40 0 40
		#
		device X11
		#
bzplot99 0      # for gammie
		device postencap thetacuthorizon.eps
		setlimits $rhor ($rhor*1.001) 0 pi/2 -5 4
		define x2label " "
		define x1label "\theta"
		erase
		limits 0 1.57 -5 4
		ctype default box
		#
		ctype default plflim 0 x2 r h ud0 1 001
		ctype blue plflim 0 x2 r h libeta 1 001 
		ctype red plflim 0 x2 r h lbrel 1 001
		device X11
		#
		set it=va2/cs2
		ctype default plflim 0 x2 r h it 0
		#
bzplotzeta  0   #
		# for paper
		# Zeta plot (i.e. J.F=0 test)
		# a=0.5 jcontest256by256-a.5
		jrdpcf dump0020
		gammienew
		interpsingle r
		define cres 25
		plc 0 ir 001 0 _Rout 0 _Rout
		set myr=newfun
		#
		gammienew
		# time average
		avgtimelaf 'dump' 10 20
		#
		#
		# equalize
		do ii=0,$nx*$ny*$nz-1,1 {
                   set indexi=INT($ii%$nx)
                   set indexj=INT(($ii%($nx*$ny))/$nx)
                   set indexk=INT($ii/($nx*$ny))
                   define tempi (indexi)
                   define tempj (indexj)
                   define tempk (indexk)
                   #
                   set symii=($ny-1-indexj)*$nx+indexi
                   #
                   if(indexi==0) { echo $tempj }
                   if(indexj<=$ny/2) {\
		    set laftime[$ii]=0.5*(laftime[$ii]+laftime[symii])
                    set lafatime[$ii]=0.5*(lafatime[$ii]+lafatime[symii])
                    set lafbtime[$ii]=0.5*(lafbtime[$ii]+lafbtime[symii])
		   }
                   if(indexj>$ny/2) {\
                    set laftime[$ii]=laftime[symii]
                    set lafatime[$ii]=lafatime[symii]
                    set lafbtime[$ii]=lafbtime[symii]
		   }
		}
		#
		interpsingle lafbtime
		define cres 25
		plc 0 ilafbtime 001 0 _Rout 0 _Rout
		set mylaf=newfun
		#
		fdraft
		erase
		device postencap forcefree.eps
		#
		set image[ix,iy] = mylaf
		define x1label " "
		define x2label " "
		xla "R c^2/(GM)"
		yla "z c^2/(GM)"
		box
		#
		#set lev=-4,-4+1E-6,1E-6
		#levels lev
		#contour
		#
		set lev=-3,-3+1E-6,1E-6
		levels lev
		contour
		#
		set lev=-2,-2+1E-6,1E-6
		levels lev
		contour
		#
		set lev=-1,-1+1E-6,1E-6
		levels lev
		contour
		#
		set image[ix,iy] = myr
		set lev=$rhor,$rhor+1E-6,1E-6
		levels lev
		contour
		#
		set lev=_Rout,_Rout+1E-6,1E-6
		levels lev
		contour
		#
		device X11
		!scp forcefree.eps metric:research/papers/bz/
		#
		#
omegaaphi  0    #
		#
		#
		# 4 gammie
		#jrdp dump0040
		jrdp dumptavg2040
		fieldcalc tavg40 aphi
		gammienew
		#equatorequalize
		bzeflux
		#
		# Rout=400 model
		set hin=2.7
		set hout=pi
		set loweraphi=.0125
		set upperaphi=0.016
		#
		# fiducial model
		# set hin=0
		# set hout=0.4
		# set loweraphi=0.002
		# set upperaphi=0.0035
		#
		plc 0 aphi 001 _Rin _Rout hin hout
		set myaphi=newfun
		plc 0 r 001 _Rin _Rout hin hout
		set myr=newfun
		plc 0 h 001 _Rin _Rout hin hout
		set myh=newfun
		plc 0 omegaf2 001 _Rin _Rout hin hout
		set myw=newfun
		plc 0 ti 001 _Rin _Rout hin hout
		set myti=newfun
		plc 0 tj 001 _Rin _Rout hin hout
		set mytj=newfun
		plc 0 uu1 001 _Rin _Rout hin hout
		set myuu1=newfun
		plc 0 v1m 001 _Rin _Rout hin hout
		set myv1m=newfun
		plc 0 bsq 001 _Rin _Rout hin hout
		set mybsq=newfun
		plc 0 B1 001 _Rin _Rout hin hout
		set myB1=newfun
		plc 0 B3 001 _Rin _Rout hin hout
		set myB3=newfun
		print r.txt '%21.15g\n' {myr}
		print h.txt '%21.15g\n' {myh}
		print i.txt '%21.15g\n' {myti}
		print j.txt '%21.15g\n' {mytj}
		print aphi.txt '%21.15g\n' {myaphi}
		print w.txt '%21.15g\n' {myw}
		print uu1.txt '%21.15g\n' {myuu1}
		print v1m.txt '%21.15g\n' {myv1m}
		print bsq.txt '%21.15g\n' {mybsq}
		print B1.txt '%21.15g\n' {myB1}
		print B3.txt '%21.15g\n' {myB3}
		!scp r.txt h.txt i.txt j.txt aphi.txt w.txt uu1.txt v1m.txt bsq.txt B1.txt B3.txt metric:
		#
		set use=((aphi>loweraphi)&&(aphi<upperaphi)&&(h>hin)&&(h<hout)) ? 1 : 0
		set godr=r if(use)
		set godh=h if(use)
		set god=omegaf2 if(use)
		#set god=uu1 if(use)
		set sgod=god
		set sgodr=godr
		sort { sgodr sgod}
		smooth sgod ssgod 1
		fdraft
		define x1label "r c^2/(GM)"
		define x2label "\omega"
		pl 0 sgodr ssgod 0001 _Rin _Rout 0 0.1
		# set it=ssgod/omegah
		# pl 0 sgodr it 0001 _Rin _Rout 0 1.0
		# read from matlab contour extraction
		#
bzwhowhaphipre  0 # read in what matlab gave us
		jrdp dumptavg2040
		fieldcalc tavg40 aphi
		gammienew
		#equatorequalize
		bzeflux
		!scp metric:C1.txt .
		da C1.txt
		read {rnew 1 wnew 2}
bzwowhaphiplot 0		# omega along aphi from matlab
		device postencap omegaowhalongaphi2.eps
		fdraft
		set rat=wnew/omegah
		set idealrat=wnew*0+1/2
		define x1label "r c^2/(GM)"
		define x2label "\omega/\Omega_H"
		ltype 0 pl 0 rnew rat 0001 _Rin _Rout 0 1.0
		#ltype 1 plo 0 rnew idealrat
		device X11
		!scp omegaowhalongaphi2.eps metric:research/papers/bz/
		#
sonicvpvsr 0 #
		#sonicvp
		gcalc2 8 $averagetype hor sonicvp1 sonicvp1vsr $rinner $router		
		gcalc2 8 $averagetype hor sonicvp2 sonicvp2vsr $rinner $router		
		#
alfvenvpvsr 0 #
		#alfvenvp
		gcalc2 8 $averagetype hor alfvenvp1 alfvenvp1vsr $rinner $router		
		gcalc2 8 $averagetype hor alfvenvp2 alfvenvp2vsr $rinner $router		
		#
fastvpvsr 0 #
		#fastvp
		gcalc2 8 $averagetype hor fastvp1 fastvp1vsr $rinner $router
		gcalc2 8 $averagetype hor v1p v1pvsr $rinner $router		
		gcalc2 8 $averagetype hor fastvp2 fastvp2vsr $rinner $router		
		#
fastplots 0 #
		#
		ctype red pl 0 newr fastvp1vsr		
		ctype default plo 0 newr v1pvsr
		#
		ctype default pl 0 newr sonicvp1vsr
		ctype red plo 0 newr fastvp1vsr
		#
		#
		ctype default pl 0 newr sonicvp2vsr
		ctype red plo 0 newr fastvp2vsr
		#
		#
sonicplots 0    #
		# sound speed equal to 3-velocity at isco?
		# gwritedump dumptavg2040v2
		greaddump dumptavg2040v2
		#greaddump dumptavg2040equalize
		#greaddump dumptavg2040bsqgoodB3
		readg42 tavg42.txt
		# for afdd??s' 
		readg3 tavg3.txt
		#
		plc 0 v1p 001 _Rin 10 (pi/2-0.3) (pi/2+0.3)
		#
		define averagetype (2)
		define rinner (_Rin)
		define router (10)
		set hor=0.3
		#
		gcalc2 8 $averagetype hor rho rhovsr $rinner $router
		gcalc2 8 $averagetype hor u uvsr $rinner $router
		#
		if(0){\
		 gcalc2 8 $averagetype hor v1p v1pvsr $rinner $router
		 ctype default pl 0 newr v1pvsr
		 #
		 set vr=uu1/uu0
		 gcalc2 8 $averagetype hor vr vrvsr $rinner $router
		 set cs=sqrt(cs2)
		 gcalc2 8 $averagetype hor cs csvsr $rinner $router
		 set cms=sqrt(cms2)
		 gcalc2 8 $averagetype hor cms cmsvsr $rinner $router
		 set va=sqrt(va2)
		 gcalc2 8 $averagetype hor va vavsr $rinner $router
		}
		#
		gcalc2 8 $averagetype hor bsq bsqvsr $rinner $router
		gcalc2 8 $averagetype hor va2 va2vsr $rinner $router
		gcalc2 8 $averagetype hor cs2 cs2vsr $rinner $router
		#
		ctype default pl 0 newr vrvsr 0001 $rinner $router -0.3 0.3
		ctype cyan plo 0 newr csvsr
		ctype red plo 0 newr v1pvsr
		ctype blue plo 0 newr cmsvsr
		ctype green plo 0 newr vavsr
		#
		gcalc2 8 $averagetype hor uu0 uu0vsr $rinner $router		
		gcalc2 8 $averagetype hor uu1 uu1vsr $rinner $router
		gcalc2 8 $averagetype hor uu2 uu2vsr $rinner $router
		gcalc2 8 $averagetype hor uu3 uu3vsr $rinner $router
		#
		gcalc2 8 $averagetype hor bu0 bu0vsr $rinner $router
		gcalc2 8 $averagetype hor bu1 bu1vsr $rinner $router
		gcalc2 8 $averagetype hor bu2 bu2vsr $rinner $router
		gcalc2 8 $averagetype hor bu3 bu3vsr $rinner $router
		#
		gcalc2 8 $averagetype hor r rvsr $rinner $router
		gcalc2 8 $averagetype hor h hvsr $rinner $router
		gcalc2 8 $averagetype hor tx1 x1vsr $rinner $router
		gcalc2 8 $averagetype hor tx2 x2vsr $rinner $router
		gcalc2 8 $averagetype hor ti ivsr $rinner $router
		#
		ctype default pl 0 newr (ABS(uu1vsr)) 0001 $rinner $router 0 0.3
		#ctype cyan plo 0 newr (ABS(myv1vsr))
		ctype cyan plo 0 newr (ABS(myuu2vsr))
		ctype green plo 0 newr (ABS(uu3vsr))
		ctype magenta plo 0 newr mycsvsr
		ctype red vertline risco
		#
		#
		# KSP -> KS for simple calculations in mathematica
		#
		set dxdxp1=rvsr
		set dxdxp2=pi+(1-hslope)*pi*cos(2*pi*x2vsr)
		#
		set ksuu1vsr=uu1vsr*dxdxp1
		set ksuu2vsr=uu2vsr*dxdxp2
		#
		set ksbu1vsr=bu1vsr*dxdxp1
		set ksbu2vsr=bu2vsr*dxdxp2
		#
		define print_noheader (1)
		#
		print formathksp.txt {ivsr x1vsr x2vsr rhovsr uvsr uu0vsr uu1vsr uu2vsr uu3vsr bu0vsr bu1vsr bu2vsr bu3vsr bsqvsr va2vsr cs2vsr}
		print formathks.txt {ivsr rvsr hvsr rhovsr uvsr uu0vsr ksuu1vsr ksuu2vsr uu3vsr bu0vsr ksbu1vsr ksbu2vsr bu3vsr bsqvsr va2vsr cs2vsr}
		#		
		#
		gcalc2 8 $averagetype hor K Kvsr $rinner $router
		#ctype default pl 0 newr Kvsr 1101 $rinner $router 0.01 0.2
		ctype default pl 0 newr Kvsr 0001 $rinner $router 0.001 0.2
		ctype red vertline risco
		#
		#
		# 4panelinflowpre 4panelinflowdoall 0.3 _Rin (2.5) 1.09 1 0
4panelinflowpre 0       #
		greaddumpold dumptavg2040equalize
		readg42 tavg42.txt
		# for afdd??s' 
		readg3 tavg3.txt
		gammienew
		#
4panelinflowdoall 6 # requires above
		# 4panelinflowdoall 0.3 _Rin (2.5) 1.09 0 0
		# 4panelinflowdoall 0.3 _Rin (2.5) 1.52 0 0
		set hor=$1
		define rinner ($2)
		define router ($3)
		define magpar ($4)
		define doint  ($5)
		if($doint){\
		       4panelinflowpre2 hor $rinner $router
		    }
		4panelinflowpre1 $magpar
		define doprint ($6)
		4panelinflow
4panelinflowpre1 1 #
		# get gammie solution
		define magpar ($1)
		define bhspin (a)
		define numpoints (1024)
		!./inf_const $magpar $bhspin $numpoints > ./gammiesol1.txt
		!tail -1 gammiesol1.txt > gammiesol2.txt
		da gammiesol2.txt
		lines 1 1
		read {gfl 3 gfe 4}
		print {gfl tdlinfisco gfe tdeinfisco}
		set tdfevsr=tdeinfisco+newr*0
		set tdflvsr=tdlinfisco+newr*0
		#
		define gammieFL (gfl)
		define gammieFE (gfe)
		define size (dimen(newr))
		!./inf_solv $magpar $bhspin $gammieFL $gammieFE $size > gammiesolve1.txt
		da gammiesolve1.txt
		lines 1 10000
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {gr guu0 guu1 guu2 guu3 gl grho gE gfdd02 gfdd12 gMaf ged gB1 gB3}
		#
		# gfdd02 should be constant
		#
		set gB2=gB3*0
		#set gD=1-2/gr+a**2/gr**2
		#set gEoM=gD*gfdd02*gfdd12/(gr**2)
		#set gEtot=gE+gEoM
		#
		set gFEtot=-gfe+0*gE
		set gFEEM=-(-gFEtot+gE)
		#
		set gFLtot=-gfl+0*gE
		set gFLEM=-(-gFLtot+gl)
		#
		# jon's way of computing ged
		set gh=gr*0+pi/2
		set sigmabl=gr**2+a**2*cos(gh)**2
		set deltabl=gr**2-2*gr+a**2
		set Abl=(gr**2+a**2)**2-deltabl*a**2*sin(gh)**2
		#
		# total comoving energy for inflow solution
		set gco=ged+grho
		#
		set ggv00=-1+2*gr/sigmabl
		set ggv01=0
		set ggv02=0
		set ggv03=-2*a*gr*sin(gh)**2/sigmabl
		set ggv10=ggv01
		set ggv11=sigmabl/deltabl
		set ggv12=0
		set ggv13=0
		set ggv20=ggv02
		set ggv21=ggv12
		set ggv22=sigmabl
		set ggv23=0
		set ggv30=ggv03
		set ggv31=ggv13
		set ggv32=ggv23
		set ggv33=Abl*sin(gh)**2/sigmabl
		#
		#
		set gbu0=0		
		do ii=1,3,1 {\
		       do jj=0,3,1 {\
		       define kk (sprintf('%d',$ii)+sprintf('%d',$jj))
		       set gbu0=gbu0+gB$ii * guu$jj * ggv$kk
		    }
		 }
		 #
		 set gbu1=(gB1+gbu0*guu1)/guu0
		 set gbu2=(gB2+gbu0*guu2)/guu0
		 set gbu3=(gB3+gbu0*guu3)/guu0
		 set gbd0=ggv00*gbu0+ggv01*gbu1+ggv02*gbu2+ggv03*gbu3
		 set gbd1=ggv10*gbu0+ggv11*gbu1+ggv12*gbu2+ggv13*gbu3
		 set gbd2=ggv20*gbu0+ggv21*gbu1+ggv22*gbu2+ggv23*gbu3
		 set gbd3=ggv30*gbu0+ggv31*gbu1+ggv32*gbu2+ggv33*gbu3
		 # since used B1,B3 with 4pi's taken out, just like jon/code b^2
		 set gbsq=gbu0*gbd0+gbu1*gbd1+gbu2*gbd2+gbu3*gbd3
		 set mygbsqvsr=gbsq/2
		 #
		 # this is my version with absorbed 4pi factors
		 rdraft
		 ctype default pl 0 gr mygbsqvsr
		 # this is gammie output with apparently absorbed 4pi factors
		 ctype red plo 0 gr ged
		 #
4panelinflowpre22 3 #
		# uses 4panelinflowpre above
		set hor=$1
		define rinner ($2)
		define router ($3)
		#
		define averagetype (2)
		#
		set FM=rho*uu1          # not quite right, should add to GRMHD code as list of tavg variables
		#
		gcalc2 8 0 hor FM FMvsr $rinner $router
		# this surface integrated quantity doesn't depend on coordinates
		# convert from real flux to equatorial flux estimate
		# this is pretty close, but off by 0.98 for a particular model
		# let's adjust this so perfect match
		if(hor<0.4) { set FMvsrg=-FMvsr/(2*hor*0.98)}
		if(hor>1.4) { set FMvsrg=-FMvsr/(2*hor/1.35/newr)}
                #set FMvsrg=FMvsrg*(2*pi)/(Dphi)
                set FMvsrg=FMvsrg[0]*(2*pi)/(Dphi) + FMvsrg*0
		#set FMvsrg=rhovsr[0]/grho[0]
                #set FMvsrg=myfmvsrg
		#
		#
		# rest of primitive variables
		#gcalc2 8 $averagetype hor rho rhovsr $rinner $router
		gcalc2 8 $averagetype hor uu1 uu1kspvsr $rinner $router
		gcalc2 8 $averagetype hor bsq bsqvsr $rinner $router
		#gcalc2 8 $averagetype hor u uvsr $rinner $router
		# KS->KSP/BL gam99
		#set rhovsrg=rhovsr/(FMvsrg)
		#set uvsrg=uvsr/(FMvsrg)
		set bsqvsrg=bsqvsr/(FMvsrg)
		#
		gcalc2 8 $averagetype hor uu0 uu0vsr $rinner $router
		gcalc2 8 $averagetype hor ud0 ud0vsr $rinner $router
		#
		#gcalc2 8 $averagetype hor uu2 uu2vsr $rinner $router
		gcalc2 8 $averagetype hor uu3 uu3vsr $rinner $router
		set aB12=afdd23tavg/gdet
		gcalc2 8 2 hor aB12 aB12vsr $rinner $router
		set aB12vsrg=aB12vsr*newr/sqrt(FMvsrg)
		#
		#gcalc2 8 $averagetype hor B2 B2vsr $rinner $router
		set aB3=afdd12tavg/gdet
		gcalc2 8 2 hor aB3 aB3vsr $rinner $router
		set aB3vsrg=aB3vsr/sqrt(FMvsrg)
		#
		#
4panelinflowpp1 0 #
		set massflux=rhovsr*uu1kspvsr*newr**3*2*pi
		print '%10.5g %10.5g %10.5g %10.5g %10.5g %10.5g %10.5g %10.5g %10.5g\n' {newr rhovsr uvsr uu1kspvsr uu3vsr aB12vsr aB3vsr bsqvsr massflux}
		#
printgammie1999 0 #
		1.999038        3.295059    -0.009585635               0       0.8742821        1.940352        4.154869       0.8184478      0.07965459      -0.6635517       0.2544948      0.01342958      0.07694486      -0.1660477
		print '%15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g %15.7g\n' \
		    {gr guu0 guu1 guu2 guu3 gl grho gE gfdd02 gfdd12 gMaf ged gB1 gB3}
		#
		print {newr uu1vsr ud3vsr bcog rhovsrg uvsrg}
		#
		# r=1.986
		1.986      0.2534     0.02766     -0.1587      0.7131     0.07885      0.1127      0.3737
		set gdetg=newr**2*2*pi
		set massfluxg=rhovsrg*uu1vsr*gdetg
		set magparg=aB12vsrg*gdetg
		print {newr rhovsrg uvsrg uu1vsr uu3vsr aB12vsrg aB3vsrg FMvsrg bsqvsrg massfluxg}
		#
		# should match real settings above
		4panelinflowpre22 0.3 _Rin (2.5)
		#	
readinflowrun 1 #
		# to be done at very beginning if wanted, before everything.
		#
		grdp $1
		#
		set igdet=gdet
		set inewr=r
		set iud0vsr=ud0
		set iuu1=uu1
		set iuu1vsr=iuu1*inewr
		set iud3vsr=ud3
		#
		set irho=rho
		set iu=u
		set ibsq=bsq
		#
		set ilrhovsrg=LG(rho)
		set iluvsrg=LG(u)
		set ilbcog=LG(bsq*0.5)
		#
		stresscalc 1
		#
		set iFMg=irho*iuu1*igdet
		set iFMgavg=SUM(iFMg)/dimen(iFMg)
		set iFMgnew=iFMg/ABS(iFMgavg)
		# want it to be -1
		#
		set igdetbl=pi*inewr**2
		#
		set iFM0=irho*iuu1vsr
		set iFM0vsr=iFM0/ABS(iFMg)
		#
		set iFMvsr=irho*iuu1
		#
		set Tud10PAvsr=-Tud10part1
		set Tud10IEvsr=-(Tud10part0+Tud10part2+Tud10part4)
		set Tud10Bvsr=-Tud10EM
		set Tud10totvsr=-Tud10
		#
		set iFEEMvsr=Tud10Bvsr/(iFMvsr)
		set iFEPAvsr=Tud10PAvsr/(iFMvsr)
		# same for this steady run
		set imyud0vsr=iFEPAvsr
		set iFEIEvsr=Tud10IEvsr/(iFMvsr)
		set iFEtotvsr=Tud10totvsr/(iFMvsr)
		#
		set Tud13PAvsr=Tud13part1
		set Tud13IEvsr=(Tud13part0+Tud13part2+Tud13part4)
		set Tud13Bvsr=Tud13EM
		set Tud13totvsr=Tud13
		#
		set iFLEMvsr=Tud13Bvsr/(iFMvsr)
		set iFLPAvsr=Tud13PAvsr/(iFMvsr)
		# above should be same as iud3vsr
		set iFLIEvsr=Tud13IEvsr/(iFMvsr)
		set iFLtotvsr=Tud13totvsr/(iFMvsr)
		#
		
		#
4panelinflowpre2 3 #
		#
		set hor=$1
		define rinner ($2)
		define router ($3)
		#
		define averagetype (2)
		#
		gcalc2 8 $averagetype hor uu1 uu1vsr $rinner $router
		# KSP->KS or BL
		set uu1vsr=uu1vsr*newr
		gcalc2 8 $averagetype hor ud3 ud3vsr $rinner $router
		# same in KS and KSP and BL
		set myud0=-ud0
		gcalc2 8 $averagetype hor myud0 myud0vsr $rinner $router
		# same in KS and KSP and BL
		#
		gcalc2 8 $averagetype hor bsq bsqvsr $rinner $router
		# now really comoving energy density
		set bco=bsqvsr*0.5
		gcalc2 8 $averagetype hor rho rhovsr $rinner $router
		gcalc2 8 $averagetype hor u uvsr $rinner $router
		#
		gcalc2 8 $averagetype hor gdet gdetvsr $rinner $router
		#
		# F_M as a pseudo-integrated quantity is constant in all coords.
		# F_M [BL] * r = (2*pi*gdetksp*rho*uu1ksp), so divide back out r
		set newmdotvsr=2*pi*gdetvsr*rhovsr*uu1vsr/newr*2*hor
		#	
		set use=r*0
		set use=((r>$rinner)&&(r<$router)&&(h>(pi/2-hor))&&(h<(pi/2+hor))) ? 1 : 0
		set mynewr=r if(use)
		set mygdet=gdet if(use)
		set myrho=rho if(use)
		set myuu1=uu1*r if(use)
		set newmdot2vsr=2*pi*mygdet*myrho*myuu1/mynewr*2*hor
		#
		rdraft
		define x2label "gdet"
		define x1label "r c^2/(GM)"
		ctype default pl 0 newr gdetvsr
		ctype red plo 0 mynewr mygdet
		#
		#
		rdraft
		define x2label "uu1"
		define x1label "r c^2/(GM)"
		ctype default pl 0 newr uu1vsr
		ctype red plo 0 mynewr myuu1
		#
		#
		rdraft
		define x2label "rho"
		define x1label "r c^2/(GM)"
		ctype default pl 0 newr rhovsr 0001 $rinner $router 0 0.3
		ctype red plo 0 mynewr myrho
		#
		#
		set FM=rho*uu1 # not quite right, should add to GRMHD code as list of tavg variables		
		#
		gcalc2 8 0 hor FM FMvsr $rinner $router
		# this surface integrated quantity doesn't depend on coordinates
		# convert from real flux to equatorial flux estimate
		# this is pretty close, but off by 0.98 for a particular model
		# let's adjust this so perfect match
		if(hor<0.4) { set FMvsrg=-FMvsr/(2*hor*0.98)}
		if(hor>1.4) { set FMvsrg=-FMvsr/(2*hor/1.35/newr)}
                #
                #set FMvsrg=FMvsrg*(2*pi)/(Dphi)
                set FMvsrg=FMvsrg[0]*(2*pi)/(Dphi) + FMvsrg*0
		#set FMvsrg=rhovsr[0]/grho[0]
                #set FMvsrg=myfmvsrg
		#
		radialfluxes
		#
		# check on correlations
		#device postencap corrangmomandmass.eps
		define x1label "r c^2/(GM)"
		define x2label "\dot{L_{particle}} and \dot{M}_0 normalized"
		ctype default pl 0 newr (Tud13PAvsr/Tud13PAvsr[0])
		ctype blue plo 0 newr (FMvsr/FMvsr[0])
		ctype red vertline risco
		#device X11
		#
		# these ratios are all the same in KSP,KS,BL
		# however, these quantities need to be converted to gam99 form.
		set rhovsrg=rhovsr/(FMvsrg)
		set uvsrg=uvsr/(FMvsrg)
		set bcog=bco/(FMvsrg)
		set ecovsrg=rhovsrg+uvsrg+bcog
		#
		#
		# test of choice of conversion factor
		set fm1=uu1vsr*rhovsrg
		set fm2=guu1*grho
		rdraft
		define x2label "F_M(g)"
		define x1label "r c^2/(GM)"
		ctype default pl 0 newr fm1
		ctype red plo 0 gr fm2
		#
		rdraft
		define x2label "\dot{M}_0"
		define x1label "r c^2/(GM)"
		# all agree! for hor=0.3
		ctype default pl 0 newr (-FMvsrg) 0001 $rinner $router -2 1
		ctype blue plo 0 mynewr newmdot2vsr
		ctype red plo 0 newr newmdotvsr
		#
radialfluxes 0  #
		#
		set Tud10PA=-Tud10part1
		set Tud10IE=-(Tud10part0+Tud10part2+Tud10part4)
		set Tud10B=-Tud10EM
		set Tud10tot=-Tud10
		#
		#
		gcalc2 8 0 hor Tud10B Tud10Bvsr $rinner $router		
		gcalc2 8 0 hor Tud10PA Tud10PAvsr $rinner $router		
		gcalc2 8 0 hor Tud10IE Tud10IEvsr $rinner $router		
		gcalc2 8 0 hor Tud10tot Tud10totvsr $rinner $router
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newr Tud10totvsr
		ctype green plo 0 newr Tud10Bvsr
		ctype magenta plo 0 newr Tud10IEvsr
		ctype cyan plo 0 newr Tud10PAvsr
		#
		#
		#
		set Tud13PA=Tud13part1
		set Tud13IE=(Tud13part0+Tud13part2+Tud13part4)
		set Tud13B=Tud13EM
		set Tud13tot=Tud13
		#
		gcalc2 8 0 hor Tud13B Tud13Bvsr $rinner $router		
		gcalc2 8 0 hor Tud13PA Tud13PAvsr $rinner $router		
		gcalc2 8 0 hor Tud13IE Tud13IEvsr $rinner $router		
		gcalc2 8 0 hor Tud13tot Tud13totvsr $rinner $router
		#
		#
		# T^r_t [KS/BL] = T^x1_t[KSP] * r
		# the ratio need not be converted, so let's take ratio
		set FEEMvsr=Tud10Bvsr/(FMvsr)
		set FEPAvsr=Tud10PAvsr/(FMvsr)
		set FEIEvsr=Tud10IEvsr/(FMvsr)
		set FEtotvsr=Tud10totvsr/(FMvsr)
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newr FEtotvsr 0001 $rinner $router -.1 1.0
		ctype green plo 0 newr FEEMvsr
		ctype magenta plo 0 newr FEIEvsr
		ctype cyan plo 0 newr FEPAvsr
		#
		#
		set FLEMvsr=Tud13Bvsr/(FMvsr)
		set FLPAvsr=Tud13PAvsr/(FMvsr)
		set FLIEvsr=Tud13IEvsr/(FMvsr)
		set FLtotvsr=Tud13totvsr/(FMvsr)
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newr FLtotvsr 0001 $rinner $router -0.3 3.0
		ctype green plo 0 newr FLEMvsr
		ctype magenta plo 0 newr FLIEvsr
		ctype cyan plo 0 newr FLPAvsr
		#
		#
thetafluxes 0   # half-ass way, but ratios computed are accurate
		#
		set Tud20PA=-gdet*Tud20part1
		set Tud20IE=-gdet*(Tud20part0+Tud20part2+Tud20part4)
		set Tud20B=-gdet*Tud20EM
		set Tud20tot=-gdet*Tud20
		#
		#
		set FM2=gdet*rho*uu1
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) FM2 FM2vsth
		#
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20PA Tud20PAvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20IE Tud20IEvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20B Tud20Bvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20tot Tud20totvsth
		#
		#
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) FM2 FM2vsr
		#
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20PA Tud20PAvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20IE Tud20IEvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20B Tud20Bvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud20tot Tud20totvsr
		#
		#
		set Tud23PA=-gdet*Tud23part1
		set Tud23IE=-gdet*(Tud23part0+Tud23part2+Tud23part4)
		set Tud23B=-gdet*Tud23EM
		set Tud23tot=-gdet*Tud23
		#
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23PA Tud23PAvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23IE Tud23IEvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23B Tud23Bvsth
		gcalc62 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23tot Tud23totvsth
		#
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23PA Tud23PAvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23IE Tud23IEvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23B Tud23Bvsr
		gcalc63 $rinner $router	(pi/2-hor) (pi/2+hor) Tud23tot Tud23totvsr
		#
		#
		set FE2EMvsth=Tud20Bvsth/(FM2vsth)
		set FE2PAvsth=Tud20PAvsth/(FM2vsth)
		set FE2IEvsth=Tud20IEvsth/(FM2vsth)
		set FE2totvsth=Tud20totvsth/(FM2vsth)
		#
		set FE2EMvsr=Tud20Bvsr/(FM2vsr)
		set FE2PAvsr=Tud20PAvsr/(FM2vsr)
		set FE2IEvsr=Tud20IEvsr/(FM2vsr)
		set FE2totvsr=Tud20totvsr/(FM2vsr)
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newh FE2totvsth
		ctype green plo 0 newh FE2EMvsth
		ctype magenta plo 0 newh FE2IEvsth
		ctype cyan plo 0 newh FE2PAvsth
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newr FE2totvsr
		ctype green plo 0 newr FE2EMvsr
		ctype magenta plo 0 newr FE2IEvsr
		ctype cyan plo 0 newr FE2PAvsr
		#
		set FL2EMvsth=Tud23Bvsth/(FMvsth)
		set FL2PAvsth=Tud23PAvsth/(FMvsth)
		set FL2IEvsth=Tud23IEvsth/(FMvsth)
		set FL2totvsth=Tud23totvsth/(FMvsth)
		#
		set FL2EMvsr=Tud23Bvsr/(FMvsr)
		set FL2PAvsr=Tud23PAvsr/(FMvsr)
		set FL2IEvsr=Tud23IEvsr/(FMvsr)
		set FL2totvsr=Tud23totvsr/(FMvsr)
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newh FL2totvsth
		ctype green plo 0 newh FL2EMvsth
		ctype magenta plo 0 newh FL2IEvsth
		ctype cyan plo 0 newh FL2PAvsth
		#
		erase window 1 1 1 1 ctype default
		ctype default pl 0 newr FL2totvsr
		ctype green plo 0 newr FL2EMvsr
		ctype magenta plo 0 newr FL2IEvsr
		ctype cyan plo 0 newr FL2PAvsr
		#
		#
core1 0 #
		# correlations
		plc 0 mfl 0001 $rhor risco (pi/2-0.3) (pi/2+0.3)
		set newmfl=newfun
		plc 0 ud3 0001 $rhor risco (pi/2-0.3) (pi/2+0.3)
		set newud3=newfun
		#
		rxy newmfl newud3 val
		set f1=0.5*(LG(1+$val)-LG(1-$val))
		set f2=$val/sqrt((1-$val**2)/(dimen(newud3)-2))
		set p2=1-cgauss(f2)
		print {f2 p2}
		set cil=(f1-1.96/sqrt(dimen(newud3)-3))
		set cil=(exp(cil)-exp(-cil))/(exp(cil)+exp(-cil))
		set cir=(f1+1.96/sqrt(dimen(newud3)-3))
		set cir=(exp(cir)-exp(-cir))/(exp(cir)+exp(-cir))
		set myr=$val
		print {cil myr cir}
		#
		lsq newmfl newud3 newmfl lsqud3 rms 
		set mym=$a
		set myb=$b
		set myrms=$rms
		set sigm=$sig_a
		set sigb=$sig_b
		set chisq=$CHI2
		echo $a $sig_a $b $sig_b $rms
		#
		ctype default pl 0 newmfl newud3
		#
		erase		
		define x1label "F_M"
		define x2label "u_\phi"
		ctype default box
		xla $x1label
		yla $x2label
		ctype default points newmfl newud3
		ctype red plo 0 newmfl lsqud3
		#
		#
		#set diff=newmfl-newud3
		#sort {diff}
		#set it=-5,5,.01
		#set hist=HISTOGRAM(diff:it)
		#pl 0 it hist
		#
		# compare to 1.96.
core2   0       #
		define x1label "\dot{L}/\dot{M}_0"
		define x2label "\dot{M}_0"
		jrdpener 500 2000
		set dmnew=dm if(t>500)
		set rat=dl/dm
		set ratnew=rat if(t>500)
		sort {ratnew dmnew}
		ctype default pl 0 ratnew dmnew
		#device postencap timecorr.eps
		erase ctype default box points ratnew dmnew
		xla $x1label
		yla $x2label
		#
		lsqplot ratnew dmnew
		rxy ratnew dmnew val
		echo $a $sig_a $rms $val
		#device X11
		#!scp timecorr.eps metric:research/papers/bz
		#
4panelinflow   0  # 4-panel inflow model comparison
		#
		define doinflowread (0)
		#
                   fdraft
                   ctype default window 1 1 1 1
                   notation -4 4 -4 4
                   erase
                   #now setup	   
		   if($doprint) {\
		          define fname ('bz4panel'+ 'hor' + sprintf('%04g',hor)+ 'mag' + sprintf('%04g',$magpar) + '.eps')
		          device postencap $fname
		       }
		   #
		   set uu1vsr=uu1vsr
		   trueminmax newr uu1vsr
		   define uu1min (truemin)
		   #
		   limits  $rinner $router $uu1min 0
		   #
                   ctype default window 2 2 1 2 box 1 2 0 0
                   yla u^r
		   #xla r c^2/(GM)
                   xla r/M
                   ctype default ltype 0 plo 0 newr uu1vsr
		   #
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr iuu1vsr }
		   if($doinflowread==0) { ctype blue ltype 0 plo 0 gr guu1 }
		   #
		   ctype red ltype 0 vertline risco
		   #
		   # for full pi/2
		   if(hor<pi/2*0.99){\
		          limits $rinner $router 0 2.2
		       }\
		              else{\
		                 limits $rinner $router 0 1.7
		              }
		   #
		   limits $rinner $router -0.5 4
                   ctype default window 2 2 2 2 box 1 2 0 0
		   #define x1label "r c^2/(GM)"
                   define x1label "r/M"
		   #define x2label "\dot{L}/\dot{M}_0"
                   define x2label "j"
		   xla $x1label
		   yla $x2label
		   ctype default ltype 1 plo 0 newr tdflvsr
		   #ctype default ltype 0 plo 0 newr FLtotvsr
		   #ctype blue ltype 0 plo 0 gr gFLtot
		   ctype green ltype 0 plo 0 newr (FLEMvsr)
		   ctype magenta ltype 0 plo 0 newr (FLIEvsr)
		   #
		   #
		   if($doinflowread==0){ ctype blue ltype 0 plo 0 gr gFLEM }
		   if($doinflowread==1){ ctype blue ltype 0 plo 0 inewr iFLEMvsr }
		   if($doinflowread==1){ ctype blue ltype 0 plo 0 inewr iFLIEvsr }
		   #
		   #ctype cyan ltype 0 plo 0 newr FLPAvsr
		   ctype cyan ltype 0 plo 0 newr (ud3vsr*$dx3*_n3/(Dphi))
		   # particle term for gammie
		   #
		   if($doinflowread==0){ ctype blue ltype 0 plo 0 gr gl }
		   if($doinflowread==1){ ctype blue ltype 0 plo 0 inewr iud3vsr }
		   #
		   #
		   ctype red ltype 0 vertline risco
		   # old l vs r plot
		   #yla l
		   #xla r c^2/(GM)
                   #ctype default ltype 0 plo 0 newr ud3vsr
                   #ctype blue ltype 0 plo 0 gr gl
		   #ctype red ltype 0 vertline risco
		   #ctype default ltype 1 plo 0 newr tdlvsr
		   #
		   if(hor<pi/2*0.99){\
		          #limits $rinner $router 0 0.13
		          limits $rinner $router 0 1.0
		       }\
		              else{\
		                 #limits $rinner $router 0 0.05
		                 limits $rinner $router 0 1.0
		              }
		   limits $rinner $router -5 1
		   notation -2 2 -2 2
		   #
 	           ticksize 0 0 -1 0
                   ctype default window 2 2 1 1 box 1 2 0 0
                   #xla r c^2/(GM)
                   xla r/M
                   yla "comoving energy density"
		   set lbcog=LG(bcog)
		   ctype green ltype 0 plo 0 newr lbcog
		   set lrhovsrg=LG(rhovsrg)
		   ctype cyan ltype 0 plo 0 newr lrhovsrg
		   set luvsrg=LG(uvsrg)
		   ctype magenta ltype 0 plo 0 newr luvsrg
		   #set lecovsrg=LG(ecovsrg)
		   #ctype default ltype 0 plo 0 newr lecovsrg
		   #
		   set lmygbsqvsr=LG(mygbsqvsr)
		   #ctype yellow ltype 0 plo 0 gr lmygbsqvsr
		   set lged=LG(ged)
		   #
		   if($doinflowread==0) { ctype blue ltype 0 plo 0 gr lged }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr ilbcog }
		   #
		   set lgrho=LG(grho)
		   #
		   if($doinflowread==0) { ctype blue ltype 0 plo 0 gr lgrho }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr ilrhovsrg }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr iluvsrg }
		   #
		   #set lgco=LG(gco)
		   #ctype blue ltype 0 plo 0 gr lgco
		   ctype red ltype 0 vertline risco
		   #
		   limits $rinner $router -0.1 1.0
		   #limits $rinner $router -5 1.0
		   ticksize 0 0 0 0
		   ctype default window 2 2 2 1 box 1 2 0 0
		   #
		   #define x1label "r c^2/(GM)"
                   define x1label "r/M"
		   #define x2label "\dot{E}/\dot{M}_0"
                   define x2label "e"
		   xla $x1label
		   yla $x2label
		   ctype default ltype 1 plo 0 newr tdfevsr
		   #ctype default ltype 0 plo 0 newr FEtotvsr
		   #ctype blue ltype 0 plo 0 gr gFEtot
		   ctype green ltype 0 plo 0 newr FEEMvsr
		   #
		   #ctype cyan ltype 0 plo 0 newr FEPAvsr
		   ctype cyan ltype 0 plo 0 newr myud0vsr
		   ctype magenta ltype 0 plo 0 newr FEIEvsr
		   # particle term for gammie
		   #
		   if($doinflowread==0) { ctype blue ltype 0 plo 0 gr gFEEM }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr iFEEMvsr }
		   #
		   if($doinflowread==0) { ctype blue ltype 0 plo 0 gr gE }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr imyud0vsr }
		   if($doinflowread==1) { ctype blue ltype 0 plo 0 inewr iFEIEvsr }
		   #
		   #
		   ctype red ltype 0 vertline risco
		   #
		   if($doprint) {\
		          device X11
		          #!scp $fname metric:research/papers/bz/
		       }
                   #
cinflowB1   0 #
		erase window 1 1 1 1 ctype default
		#
		#plc 0 B1 001 $rinner $router (pi/2-0.3) (pi/2+0.3)
		#
		# from tavg3.txt
		#
		set aB12=afdd23tavg/gdet
		gcalc2 8 2 hor aB12 aB12vsr $rinner $router
		set aB12vsrg=aB12vsr*newr/sqrt(FMvsrg)
		#
		set aB1=ABS(B1)
		gcalc2 8 2 hor aB1 aB1vsr $rinner $router
		# KSP->KS or BL
		set aB1vsrg=aB1vsr*newr/sqrt(FMvsrg)
		#
		gcalc2 8 2 hor B1 B1vsr $rinner $router
		# KSP->KS or BL
		set B1vsrg=B1vsr*newr/sqrt(FMvsrg)
		#
		erase
		define x1label "r c^2/(GM)"
		define x2label "B^r"
		ctype default pl 0 newr aB12vsrg 0001 $rinner $router 0 0.2
		ctype blue plo 0 newr B1vsrg
		ctype magenta plo 0 newr aB1vsrg
		ctype red plo 0 gr gB1
		#
		set DD=1-2/gr+a**2/gr**2
		set g2B1=gB1/DD
		ctype cyan plo 0 gr g2B1
		#
cinflowit   1 #
		erase window 1 1 1 1 ctype default
		#
		set myvar=$1
		if('$!1'=='fdd23'){ set myvar=afdd23tavg }
		if('$!1'=='fdd02'){ set myvar=afdd02tavg }
		if('$!1'=='fdd12'){ set myvar=afdd12tavg }
		plc 0 myvar 001 $rinner $router (pi/2-0.3) (pi/2+0.3)
		#
		#
		gcalc2 8 2 hor myvar $1vsr $rinner $router
		# KSP->KS or BL
		set $1vsrg=$1vsr*newr/sqrt(FMvsrg)
		#
		erase
		define x1label "r c^2/(GM)"
		define x2label "$!1"
		set temp=$1vsrg
		set temp2=ABS(g$1)
		trueminmax newr temp
		define plotmax (truemax)
		define plotmin (truemin)
		trueminmax gr temp2
		if(truemax>$plotmax) { define plotmax (truemax) }
		if(truemin<$plotmin) { define plotmin (truemin) }
		ctype default pl 0 newr temp 0001 $rinner $router $plotmin $plotmax
		ctype blue plo 0 gr temp2
		#
		#
bphipre  0      #
		jrdp dumptavg2040bsq
		bzeflux
		fieldcalc 2040bsq aphi
		gammienew
		#
		equatorequalize
		gwritedump dumptavg2040bsqgoodB3
bphipre2  0     #
		#
		jrdp dumptavg2040bsqgoodB3
		set god=gdet*B3**2/rho
		interpsingle god
		plc 0 igod 001 0 _Rout 0 _Rout
		set mygod=newfun
		#
		jrdp dumptavg2040bsqgoodB3
		interpsingle B3
		plc 0 iB3 001 0 _Rout 0 _Rout
		set myB3=newfun
		#
		jrdp dumptavg2040bsqgoodB3
		interpsingle gdet
		plc 0 igdet 001 0 _Rout 0 _Rout
		set mygdet=newfun
		#
		jrdp dumptavg2040bsqgoodB3
		interpsingle r
		define cres 25
		plc 0 ir 001 0 _Rout 0 _Rout
		set myr=newfun
		#
		jrdp dumptavg2040bsqgoodB3
		interpsingle rho
		define cres 25
		plc 0 irho 001 0 _Rout 0 _Rout
		set myrho=newfun
		#
bphiplot      0 #
		#
		device postencap bphi.eps
		fdraft
		define cres 15
		define x1label "r c^2/(GM)"
		define x2label "z c^2/(GM)"
		#set it=iB3**2/irho
		set it=igod
		plc 0 it 001 0 40 0 40
		#
		set image[ix,iy] = myr
		set lev=$rhor,$rhor+1E-6,1E-6
		levels lev
		contour
		#
		set lev=_Rout,_Rout+1E-6,1E-6
		levels lev
		contour
		device X11
		!scp bphi.eps metric:research/papers/bz/
		#
		#
bzplotfastpre12   0 # can redo if altered number of columns
		avgtimegfull 'dump' 20 40
		gfull2normal
		# includes bsq and aphi
		gwritedump dumptavg2040
		greaddump dumptavg2040
		faraday
		equatorequalize
		gwritedump dumptavg2040equalize
		#
		#greaddumpold dumptavg1040
		gammiegrid gdump
		#trueslowfast
		#
bzplotfastpre1    0    #
		 #
		# side cartoon for b^2/rho=1 and beta=1 and wind
		# shouldn't have to do everytime
		jrdp dump0000
		gammienew
		#
		# bzplotfastpre12           # avoid if already have data
		#
		#
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle tfastv1m
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle alfvenv1m
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle tslowv1m
		greaddumpold dumptavg2040equalize
		gammienew
		set outud0=(uu1>0.0) ? ud0 : 1
		interpsingle outud0
		greaddumpold dumptavg2040equalize
		gammienew
		interpsingle ud0
		#		greaddumpold dumptavg2040equalize
		#gammienew
		#
bzplotfastpre2    0    #
		#
		# now we have libeta and lbrel and ud0
		define cres 20
		plc 0 ioutud0 001 0 40 0 40
		set myoutud0=newfun
		#
		plc 0 iud0 001 0 40 0 40
		set myud0=newfun
		#
		plc 0 itfastv1m 001 0 40 0 40
		set mytfastv1m=newfun
		#
		plc 0 ialfvenv1m 001 0 40 0 40
		set myalfvenv1m=newfun
		#
		plc 0 itslowv1m 001 0 40 0 40
		set mytslowv1m=newfun
		#
		#
		#
		# to plot do below
bzplotfastdo 0    #
		#
		set printeps=0
		#
		#
		erase
		#
		fdraft
		#
		if (printeps==1) { device postencap fastoutflow.eps }
		#
		set image[ix,iy] = mytfastv1m
		ltype 0 ctype default
		box
		xla "R c^2/(GM)"
		yla "z c^2/(GM)"
		set lev=0-1E-9,0+1E-9,2E-9
		levels lev		
		ctype red contour
		#
		#
		set image[ix,iy] = myalfvenv1m
		ltype 0 ctype default
		box
		set lev=0-1E-9,0+1E-9,2E-9
		levels lev
		ctype cyan contour
		#
		set image[ix,iy] = mytslowv1m
		ltype 0 ctype default
		box
		set lev=0-1E-9,0+1E-9,2E-9
		levels lev
		ctype blue contour
		#
		#
		set image[ix,iy] = myud0
		ltype 0 ctype default
                #
		# the wind
		set lev=-1-1E-6,-1+1E-6,2E-6
		levels lev
		ctype default contour
		#
                #
		#set image[ix,iy] = myud0
		ltype 0 ctype default
		box
		minmax min max echo $min $max
		#
		#
		# the outer and inner radial edges
		set lev=0,1E-6,1E-6
		levels lev
		lweight 4 ctype default contour
                lweight 3
		#
		if(printeps==1) {\
		       device X11
		       !scp fastoutflow.eps metric:research/papers/bz/
		    }
		#
lastbzplot    0 #
		#
