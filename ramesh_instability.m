firstcheck1 0   # 
		#
		jrdp dump0056
		set lgptot=LG(ptot)
		plc 0 lgptot 001 Rin 5E2 0 pi
		#
		fieldcalc 0 aphi
		plc 0 aphi 011 Rin 5E2 0 pi
		#
		#
		interpsingle lgptot
		interpsingle aphi
		readinterp lgptot
		readinterp aphi
		#
		#
		window 5 1 1:3 1
		plc 0 iaphi
		plc 0 ilgptot 010
		#
firstcheck1a 0  #
		# on jetresfl1
		#
		jre punsly.m
		setupdumpjet
		#greaddump dumptavg
		
		#
firstcheck1b 0   # 
		#
		jrdp dump0056
		set lgptot=LG(ptot)
		plc 0 lgptot 001 Rin 5E2 0 pi
		#
		fieldcalc 0 aphi
		plc 0 aphi 011 Rin 5E2 0 pi
		#
		#
		interpsingle lgptot 256 256 100 100
		interpsingle aphi 256 256 100 100
		readinterp lgptot
		readinterp aphi
		#
		#
		window 5 1 1:3 1
		ctype default
		plc 0 iaphi
		plc 0 ilgptot 010
		#
		#
		#
firstcheck2 0   # pressure $\theta$ structure
		#define myRin (2)
		#define myRout (2.01)
		#define myRin (10)
		#define myRout (10.01)
		define myRin (50)
		define myRout (50.01)
		#
		define x1label "\theta"
		define x2label "p_{tot} p bsq/2"
		# r=2
		#setlimits $myRin $myRout 0 pi 1E-4 1E-1
		# r=10
		#setlimits $myRin $myRout 0 pi 1E-6 1E-2
		# r=50
		setlimits $myRin $myRout 0 pi 1E-8 1E-5
		#
		ctype default plflim 0 x2 r h ptot 1 010
		#
		ctype red plflim 0 x2 r h p 1 011
		set pb=bsq/2
		ctype blue plflim 0 x2 r h pb 1 011
		ctype default
		#
		# r=2
		#relocate 1.57 -1.1
		#putlabel 5 "r=2GM/c^2"
		#
		# r=10
		#relocate 1.57 -2.1
		#putlabel 5 "r=10GM/c^2"
		#
		# r=50
		relocate 1.57 -5.1
		putlabel 5 "r=50GM/c^2"
		#
		#
		set it=6.8E-6*gauss(h,pi/2,0.45)
		ctype cyan plflim 0 x2 r h it 1 011
		#
		set it=6.8E-6*0.35/0.45*gauss(h,pi/2,0.35)
		ctype cyan plflim 0 x2 r h it 1 011
		#
		#
		
firstcheck2 0   # velocity $\theta$ structure
		#
		set it1=uu1
		plc0 0 it1 001 Rin 5E2 0 pi
		#
		set it2=((rho+u+p+bsq)/rho*ud0+1)/1E4
		plc0 0 it2 001 Rin 5E2 0 pi
		#
		fieldcalc 0 aphi
		plc 0 aphi 011 Rin 5E2 0 pi
		#
		#define myRin (2)
		#define myRout (2.01)
		#define myRin (10)
		#define myRout (10.01)
		define myRin (50)
		define myRout (50.01)
		#
		define x1label "\theta"
		define x2label "u^r (u_t+1)/10^4"
		# r=2
		#setlimits $myRin $myRout 0 pi 1E-4 1E-1
		# r=10
		#setlimits $myRin $myRout 0 pi 1E-6 1E-2
		# r=50
		setlimits $myRin $myRout 0 pi 1E-12 1E-3
		#
		ctype default plflim 0 x2 r h it1 1 010
		#
		ctype green plflim 0 x2 r h it2 1 011
		#
		ctype red plflim 0 x2 r h p 1 011
		set pb=bsq/2
		ctype blue plflim 0 x2 r h ptot 1 011
		ctype default
		#
		# r=2
		#relocate 1.57 -1.1
		#putlabel 5 "r=2GM/c^2"
		#
		# r=10
		#relocate 1.57 -2.1
		#putlabel 5 "r=10GM/c^2"
		#
		# r=50
		relocate 1.57 -5.1
		putlabel 5 "r=50GM/c^2"
		#
		ctype cyan vertline 0.414328
		ctype cyan vertline 2.75675
		#
		ctype cyan vertline 0.306064
		ctype cyan vertline 2.87129
		#
		ctype cyan vertline 0.579745
		ctype cyan vertline 2.6677
		#
		#
cool1 0         #
		set h_over_r=.2
		set THETACOOL=h_over_r
		set TAUCOOL=10.0
		set NOCOOLTHFACT=3.0
		set th=h
		set w=rho+u+p
		set rin=(1+h_over_r)*risco
		set gam=$gam
		#
		set R=r*sin(h)
		set Wcirc=R**(-1.5)
		set cscirc=THETACOOL/sqrt(R)
		set wcirc=rho*(1+cscirc**2/(gam-1))
		#
		# this is added to total energy
		#set ducool=-(Wcirc/TAUCOOL)*(w-wcirc)*uu0*ud0
		#
		# this is added to internal energy, so - means cooled
		set ducool=-(Wcirc/TAUCOOL)*(w-wcirc)
		set ducoolcrap=-(wcirc/TAUCOOL)*(w-wcirc)
		#
		set SLOPE3=(1.0/(NOCOOLTHFACT*h_over_r))
		set WIDTHTAPER=(NOCOOLTHFACT*h_over_r)
		set TAPERPOS1=(pi*0.5-NOCOOLTHFACT*h_over_r-WIDTHTAPER)
		set TAPERPOS2=(pi*0.5-NOCOOLTHFACT*h_over_r)
		set TAPERPOS3=(pi*0.5+NOCOOLTHFACT*h_over_r)
		set TAPERPOS4=(pi*0.5+NOCOOLTHFACT*h_over_r+WIDTHTAPER)
		set TAPERFUN1=0
		set TAPERFUN2=(SLOPE3*((th)-TAPERPOS1))
		set TAPERFUN3=1.0
		set TAPERFUN4=(-SLOPE3*((th)-TAPERPOS4))
		set TAPERFUN5=0
		set COOLTAPER3=(((th)<TAPERPOS1 ? TAPERFUN1 : (  ((th)<TAPERPOS2) ? TAPERFUN2 : (  ((th)<TAPERPOS3) ? TAPERFUN3: (  ((th)<TAPERPOS4) ? TAPERFUN4 : TAPERFUN5   )))) )
		#
		#
		set ducoolnew1=ducool*COOLTAPER3
		set ducoolnew1crap=ducoolcrap*COOLTAPER3
		#
		set taper=(R<rin) ? 0 : 1-sqrt(rin/R)
		#
		set ducoolnew2=ducoolnew1*taper
		set ducoolnew2crap=ducoolnew1crap*taper
		#
		set ducoolnew3=(r<26) ? ducoolnew2 : ducoolnew2*exp(-(r-26)/5)
		set ducoolnew3crap=(r<26) ? ducoolnew2crap : ducoolnew2crap*exp(-(r-26)/5)
		#
		#
		#set mydt=_dt
		#set mydt=47
		set mydt=20
		#
		set du0=ducool*mydt
		set du1=ducoolnew1*mydt
		set du2=ducoolnew2*mydt
		set du3=ducoolnew3*mydt
		set du3crap=ducoolnew3crap*mydt
		#
		set fracu0=du0/u
		set fracu1=du1/u
		set fracu2=du2/u
		set fracu3=du3/u
		set fracu3crap=du3crap/u
		#
		set lfrac=(fracu3<0) ? LG(ABS(-fracu3)) : -20
		set lfraccrap=(fracu3crap<0) ? LG(ABS(-fracu3crap)) : -20
		#
cool2 0         #
		plc0 0 lfrac 010
		erase
		box
		set lev=-15,0,50 levels lev
		ctype blue contour
		#
		plc 0 lu 010
		#
cool3 0         #
		firstcheck2
		ctype default setlimits 50 51 0 pi 0 1 plflim 0 x2 r h lfrac 0 001
		#ctype blue setlimits 50 51 0 pi 0 1 plflim 0 x2 r h lu 0 001
		#
cool4 0         #
		ctype default setlimits 50 51 0 pi 0 1 plflim 0 x2 r h u 0
		set unew=u+du3
		ctype blue setlimits 50 51 0 pi 0 1 plflim 0 x2 r h unew 0 001
		#
cool5 0         #
		ctype default setlimits 50 51 0 pi 0 1 plflim 0 x2 r h lfrac 0
		#ctype blue setlimits 50 51 0 pi 0 1 plflim 0 x2 r h lfraccrap 0 001
		#
cool6 0         #
		jrdp dump0057
		set myt1=_t
		set u1=u
		set rho1=rho
		#	
		jrdp dump0058
		set myt2=_t
		set u2=u
		set rho2=rho
		#
		set dt=myt2-myt1 print {dt}
		#
		set realdu=u2-u1
		set realfracu=realdu/(u2+u1)/2
		set reallfrac=(realfracu<0) ? LG(ABS(-realfracu)) : -20
		#
cool6plot 0     #
		ctype default setlimits 50 51 0 pi -20 0 plflim 0 x2 r h lfrac 1
		ctype red setlimits 50 51 0 pi 0 1 plflim 0 x2 r h reallfrac 0 001
		#
		
