pplot1 0        #
		jrdpcf2d dump0020
		#
		torenccompute
		# device postencap iencvsrgrmhd9375_d20.eps
		torencplot 0
		# device X11
		#
		#
pplot2 0        #
		jrdpcf2d dump0000
		# getavg3
		greaddump2 dumptavg3
		#
		#tordencompute
		torenccompute
		# device postencap iencvsrgrmhd9375.eps
		#tordenplot 0
		torencplot 0
		# device X11
		#
pplot3 0        # b^2 vs radius
		# /mnt/disk/runbhgrmhd/grmhd-a.9375-256by256-fl46-newtop
		greaddump dumptavg2
		#
		dobsqcalc
		#
pplot4 0        #
		#
		#/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		greaddump dumptavg2040v2
		#
		dobsqcalc
		#
overlay0 0      # /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		# or
		# /raid2/jmckinne/ffm3pt632hr_a.9375
		#
		#
		#set zin=0
		#set zout=40
		#
		set zin=-40
		set zout=0
		#
		fdraft
		#
		greaddump dumptavg2040v2
		#
		#
		#plc 0 aphi 010
		set _defcoord=0
		interpsingle aphi 512 512 40 40
		readinterp aphi
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		#
		define cres 15
		plc 0 iaphi 001 0 20 zin zout
		set aphi0=iaphi
		set ix0=ix
		set iy0=iy
		#
		# FFDE
		#
		# compare with t=0
		#jrdpcf2d dump0000
		# compare with t=tf
		jrdpcf2d dump0100
		#
		fieldcalc 0 aphifourth
		#plc 0 aphifourth
		interpsingle aphifourth 512 512 40 40
		readinterp aphifourth
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "red"
		#
		define cres 50
		plc 0 iaphifourth 011 0 20 zin zout
		set aphi1=newfun
		set ix1=ix
		set iy1=iy
		#
		#
overlayplot0 0  #
		#overlay0
		# device postencap overlayfields.eps
		readinterp aphi
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		#
		define cres 15
		plc 0 iaphi 001 0 20 zin zout
		#
		#
		readinterp aphifourth
		set myn=0.7
		set image[ix1,iy1]=(ABS(aphi1)/0.04613)**myn
		define min .9
		#define max 3.1
		define max ((21.08)**(myn))
		define cres 11
		set lev=$min,$max,($max-$min)/$cres
		levels lev ctype red contour
		#
		# device X11
		#
overlayplot1 0  # fine-tuned for final time of GRFFE model
		#overlay0
		# device postencap overlayfields9375.eps
		readinterp aphi
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		#
		define cres 15
		plc 0 iaphi 001 0 20 zin zout
		#
		#
		readinterp aphifourth
		set myn=0.7
		set image[ix1,iy1]=(ABS(aphi1)/0.04613)**myn
		define min 1.12
		#define max 3.1
		define max ((21.08)**(myn))
		define cres 11
		set lev=$min,$max,($max-$min)/$cres
		levels lev ctype red contour
		#
		# device X11
		#
plotomegas 0    #
		jrdp2d dump0000
		# below has bad val2 calculation
		#greaddump dumptavg2040v2
		#
		# below reads in bsq and val2 as truely time-averaged!
		greaddumpfull dumptavg2new
		#
		readg3 tavg32040.txt
		#
		# some other plot leeching on this macro
		if(0){\
		set WW = rho + u + p
		set EF = bsq + WW
		# not quite perfect average, but ok
		set val2bad = bsq/EF
		set val2badtoo=val2bad*uu0*2
		#
		set myval2=(bsq/(0.2+bsq))
		set val2rat=val2bad/myval2
		#
		#
		gcalc2 3 2 0.3 val2bad val2badvsr
		gcalc2 3 2 0.3 val2badtoo val2badtoovsr
		gcalc2 3 2 0.3 val2 val2goodvsr
		set myfit=bsq/(0.2+bsq)
		gcalc2 3 2 0.3 myfit myfitvsr		
		#
		ctype default pl 0 newr val2goodvsr 1100
		ctype cyan pl 0 newr val2badvsr 1110
		ctype magenta pl 0 newr val2badtoovsr 1110
		#
		# good fit
		set myfit=val2badvsr[0]*(newr/newr[0])**(-2.5)
		ctype red pl 0 newr myfit 1110
		#
		# 
		# no as good fit
		set myfit=val2goodvsr[0]*(newr/newr[0])**(-2.5)
		ctype green pl 0 newr myfit 1110
		#
		# even worse fit
		ctype yellow pl 0 newr myfitvsr 1110
		#
		}
		#
		#
		set vrnorm=uu1/uu0*sqrt(gv311)/sqrt(abs(gv300))
		#
		set delta=r**2-2*r+a**2
		set uu1ks=uu1*r
		set uphibl=uu1ks*(-a/delta)+uu3
		set utbl=uu1ks*(-2*r/delta)+uu0
		set vphibl=uphibl/utbl
		#plc 0 vphibl
		#
		# NEW:
		#set  set dmdot=rho*uu1
		#gcalc2 3 0 0.3 dmdot dmdotvsr
		#
		# NEW:
		set omegauu1ks=uu1ks/(r*sin(h))
		#gcalc2 3 2 0.3 uu1ks uu1ksvsr
		gcalc2 3 2 0.3 omegauu1ks omegauu1ksvsr
		#
		# NEW:
		#gcalc2 3 2 0.3 vrnorm vrnormvsr
		#
		gcalc2 3 2 0.3 omegak omegakvsr
		#
		gcalc2 3 2 0.3 vphibl vphiblvsr
		#
		set omegacs=sqrt(cs2)/(r*sin(h))
		gcalc2 3 2 0.3 omegacs omegacsvsr
		#
		set omegacms=sqrt(cms2)/(r*sin(h))
		gcalc2 3 2 0.3 omegacms omegacmsvsr
		#
		set omegava=sqrt(val2)/(r*sin(h))
		set omegavanon=sqrt(bsq/rho)/(r*sin(h))
		gcalc2 3 2 0.3 omegava omegavavsr
		gcalc2 3 2 0.3 omegavanon omegavanonvsr
		#
		#set fdd02bl=fdd02/dxdxp2
		#set fdd23bl=fdd23/dxdxp2
		#
		# ratio (omegaf2) same in bl as in KSP!
		# omegaf1 not like this
		set aafdd23=ABS(afdd23tavg)
		set aafdd02=ABS(afdd02tavg)
		set afdd23=ABS(fdd23tavg)
		set afdd02=ABS(fdd02tavg)
		#set afdd23=ABS(fdd23)
		#set afdd02=ABS(fdd02)
		gcalc2 3 2 0.3 aafdd02 aafdd02vsr
		gcalc2 3 2 0.3 aafdd23 aafdd23vsr
		set aaomegarat=aafdd02vsr/aafdd23vsr
		gcalc2 3 2 0.3 afdd02 afdd02vsr
		gcalc2 3 2 0.3 afdd23 afdd23vsr
		set aomegarat=afdd02vsr/afdd23vsr
		#
		set AA=(r**2+a**2)**2-a**2*delta*sin(h)**2
		set omegahbl=2*a*r/AA
		gcalc2 3 2 0.3 omegahbl omegahvsr
		#
		#
		# pick the divisor
		set divisor=omegakvsr
		#
		set omegah=a/(2*$rhor)+newr*0
		#set divisor=omegah
		#
		#set vrnormrat=vrnormvsr/divisor
		#set uu1ksrat=uu1ksvsr/divisor
		set keprat=vphiblvsr/divisor
		set agodrat=aaomegarat/divisor
		set godrat=aomegarat/divisor
		set omegahpurerat=omegah/divisor
		set omegahrat=omegahvsr/divisor
		set omegavarat=omegavavsr/divisor
		set omegacsrat=omegacsvsr/divisor
		set omegacmsrat=omegacmsvsr/divisor
		set omegavanonrat=omegavanonvsr/divisor
		set omegauu1rat=omegauu1ksvsr/divisor
		#
		replotomegas
		#
replotomegas 0 #
		fdraft
		#device postencap omegas.eps
		# device postencap omegaabs.eps
		define x1label "r c^2/GM"
		define x2label "\Omega_{\rm ZAMO}/\Omega_K\ \ \Omega_F/\Omega_K\ \ \Omega/\Omega_K [{\rm all BL coords}]"
		#define x2label "\Omega/\Omega_K\ \ \Omega_F/\Omega_K\ \ \Omega_{ZAMO}/\Omega_K [all BL]"
		#define x2label "\Omega/\Omega_H\ \ \Omega_F/\Omega_H\ \ \Omega_{ZAMO}/\Omega_H [all BL]"
		#
		ltype 1 ctype default pl 0 newr keprat 1001 Rin Rout 0 1.5
		ltype 0 ctype default pl 0 newr godrat 1011 Rin Rout 0 1.5
		ltype 2 ctype default pl 0 newr agodrat 1011 Rin Rout 0 1.5
		ltype 3 ctype default pl 0 newr omegahrat 1011 Rin Rout 0 1.5
		#ltype 3 ctype default pl 0 newr omegahpurerat  1011 Rin Rout 0 1.5
		ltype 0 ctype red pl 0 newr omegavarat 1011 Rin Rout 0 1.5
		#ltype 0 ctype cyan pl 0 newr omegavanonrat 1011 Rin Rout 0 1.5
		ltype 0 ctype cyan pl 0 newr omegacmsrat 1011 Rin Rout 0 1.5 
		ltype 0 ctype magenta pl 0 newr omegacsrat 1011 Rin Rout 0 1.5
		#
		#ctype blue vertline (LG($rhor))
		#device X11
		#
replotomegas1 0 # first real plot
		fdraft
		#device postencap omegas.eps
		# device postencap omegaabs.eps
		# device postencap omegasboth.eps
		define x1label "r c^2/GM"
		define x2label "\Omega_{\rm ZAMO}/\Omega_K\ \ \Omega_F/\Omega_K\ \ \Omega/\Omega_K [{\rm all BL coords}]"
		#define x2label "\Omega/\Omega_K\ \ \Omega_F/\Omega_K\ \ \Omega_{ZAMO}/\Omega_K [all BL]"
		#define x2label "\Omega/\Omega_H\ \ \Omega_F/\Omega_H\ \ \Omega_{ZAMO}/\Omega_H [all BL]"
		#
		set fundown=0.1
		set funup=1.5
		#
		ltype 0 ctype default pl 0 newr keprat 1101 Rin Rout fundown funup
		relocate 0.86 0.066
		putlabel 5 "<\Omega>/\Omega_K"
		#
		ltype 1 ctype default pl 0 newr godrat 1111 Rin Rout fundown funup
		relocate 0.97 -.12
		putlabel 5 "<\Omega_F>/\Omega_K"
		#
		ltype 2 ctype default pl 0 newr agodrat 1111 Rin Rout fundown funup
		relocate .55 -.19
		putlabel 5 "<<\Omega_F>>/\Omega_K"
		#
		ltype 3 ctype default pl 0 newr omegahrat 1111 Rin Rout fundown funup
		relocate 0.75 -.58
		putlabel 5 "\Omega_{\rm ZAMO}/\Omega_K"
		#
		#ltype 3 ctype default pl 0 newr omegahpurerat  1111 Rin Rout fundown funup
		#ltype 0 ctype red pl 0 newr omegavarat 1111 Rin Rout fundown funup
		#ltype 0 ctype cyan pl 0 newr omegavanonrat 1111 Rin Rout fundown funup
		#ltype 0 ctype cyan pl 0 newr omegacmsrat 1111 Rin Rout fundown funup 
		#ltype 0 ctype magenta pl 0 newr omegacsrat 1111 Rin Rout fundown funup
		#
		#ctype blue vertline (LG($rhor))
		#device X11
		#
replotomegas2 0 # real plot
		fdraft
		# device postencap velcsrats.eps
		define x1label "r c^2/GM"
		#define x2label "v_a/v_K\ \ c_s/v_K\ \ c_{\rm ms}/v_K\ \ |v^{\hat{\phi}}|/v_K [{\rm BL coords}]"
		#define x2label "|u^r|\ \ v_a\ \ c_s\ \ c_{\rm ms}\ \ |v^{\hat{\phi}}| [per v_K in {\rm BL coords}]"
		define x2label "Velocities per unit Keplerian"
		#
		set fundown=0.01
		set funup=1.5
		set myRout=Rout
 		#
		ltype 0 ctype default pl 0 newr keprat 1101 Rin myRout fundown funup
		relocate 1.16 0.059
		putlabel 5 "v^{\hat{\phi}}/v_K"
		#
		ltype 1 ctype default  pl 0 newr omegacmsrat 1111 Rin myRout fundown funup 
		relocate 0.765 -.24
		putlabel 5 "c_{\rm ms}/v_K"
		#
		ltype 2 ctype default  pl 0 newr omegacsrat 1111 Rin myRout fundown funup
		relocate 0.5 -.5
		putlabel 5 "c_s/v_K"
		#
		ltype 3 ctype default pl 0 newr omegavarat 1111 Rin myRout fundown funup
		relocate 1.2 -.75
		putlabel 5 "v_a/v_K"
		#
		#ltype 4 ctype default pl 0 newr vrnormrat 1111 Rin myRout fundown funup
		#relocate 1.27 -.78
		#putlabel 5 "v^{\hat{r}}/v_K"
		#
		set myomegauu1rat=(newr>15) ? 0 : omegauu1rat
		ltype 4 ctype default pl 0 newr myomegauu1rat 1111 Rin myRout fundown funup
		relocate 0.6 -.833
		putlabel 5 "u^r/v_K"
		#
		#
		set god=lg(risco)
		ctype default ltype 0 vertline god
		relocate 0.35 -1.5
		angle 90 putlabel 5 "ISCO"
		#
		set god=lg(1.5)
		angle 90 ctype default ltype 0 vertline god
		relocate 0.21 -1.5
		angle 90 putlabel 5 "MBO"
		angle 0
		#
		#
ffdeplot0  0    #
		# /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		# 
		#
		ltype 0
		#jre ramesh_disk.m
		#
		jrdpcf2d dump0100
		#
		set outerR=Rout
		set innerR=50
		#
		#gammiegridnew3 gdump
		#
		diskBd3calc
		#
		#plc 0 aphi
		set smallaphi=aphi
		set smallBd3=Bd3
		set smalllights=lights
		#
		interpsingle aphi 256 256 outerR outerR
		interpsingle Bd3 256 256 outerR outerR
		interpsingle lights 256 256 outerR outerR
		#
		interpsingle smallaphi 256 256 innerR innerR
		interpsingle smallBd3 256 256 innerR innerR
		interpsingle smalllights 256 256 innerR innerR
		#
		readinterp lights
		plc 0 ilights 011 0 1E3 -1E3 1E3
		set mylights=newfun
		#
		readinterp smalllights
		plc 0 ismalllights 011 0 innerR -innerR innerR
		set mysmalllights=newfun
		#
		ffdereplot0
		#
ffdereplot0 0   #
		# first run ffdeplot0
		#
		# device postencap biffdeplot.eps
		#
		define cres 16
		#
		# PLOT PANEL 1
		#
		window 1 1 1 1
		erase
                fdraft
		#
		ltype 0
		#
		define xin 0
                define xout (outerR)
                define yin (-outerR)
                define yout (outerR)
                limits $xin $xout $yin $yout
		#
		define x_gutter 0.6
                window 2 1 1 1 box 1 2 0 0
		#
		#
                angle 0
                define x1label "R c^2/(GM)"
                xla $x1label
                define x2label "z c^2/(GM)"
                #angle 360
                yla $x2label
                #
		#
		readinterp aphi
		readinterp Bd3
		readinterp lights
		#
		#
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		plc 0 iaphi 011 0 1E3 -1E3 1E3
		#define POSCONTCOLOR "red"
		#define NEGCONTCOLOR "cyan"
		#plc 0 iBd3 011 0 1E3 -1E3 1E3
		#
		lweight 5
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		set lev=-1E-15,1E-15,2E-15
		set image[ix,iy]=mylights
		levels lev contour
		lweight 3
		#
		#
		# PLOT PANEL 2
		define xin 0
                define xout (innerR)
                define yin (-innerR)
                define yout (innerR)
		#
		limits $xin $xout $yin $yout
                #limits 0 outerR -outerR outerR
                define x_gutter 0.6
                window 2 1 2 1 box 1 2 0 0
		#
		#
		readinterp smallaphi
		readinterp smallBd3
		readinterp smalllights
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		plc 0 ismallaphi 011 0 innerR -innerR innerR
		#define POSCONTCOLOR "red"
		#define NEGCONTCOLOR "cyan"
		#plc 0 ismallBd3 011 0 innerR -innerR innerR
		#
		lweight 5
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		set lev=-1E-15,1E-15,2E-15
		set image[ix,iy]=mysmalllights
		levels lev contour
		lweight 3
		#
                angle 0
                define x1label "R c^2/(GM)"
                xla $x1label
		#define x2label "z c^2/(GM)"
                #angle 360
		#yla $x2label
		#
omegafplot0 0   #########################################
		# device postencap omegaffourth.eps
		#
		#######################
		#
		# read in a dump first
		#
		defaults
		fdraft
		#
		# USUALLY 100
		#jrdpcf2d dump0090
		faraday
		#
		define x1label "\theta"
		define x2label "\Omega_F/\Omega_H"
		#
		#set thin=0.2
		#set thout2.9
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.0001*$rhor
		#set myrin=3.4
		#set myrout=3.6
		#
		set omegah=a/(2.0*$rhor)
		#
		set rat2=omegaf2/omegah
		set rat1=omegaf1/omegah
		lweight 5 ltype 0 ctype default
		#setlimits myrin myrout thin thout 0.2 0.6 plflim 0 x2 r h rat2 1
		set newx=h if(ti==1)
		set newfun=rat2 if(ti==1)
		pl 0 newx newfun 0001 thin thout 0.2 0.6
		#
		relocate 1.123 0.433
		putlabel 5 "r_+"
		#
		# ergosphere
		#set newx=h if(ti==25)
		#set newfun=rat2 if(ti==25)
		#pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		# ISCO r=2.3209
		relocate 0.973 0.36
		putlabel 5 "r_{\rm ISCO}"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==35)
		set newfun=rat2 if(ti==35)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		# r=10
		relocate 0.57 0.34
		putlabel 5 "10r_g"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==118)
		set newfun=rat2 if(ti==118)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		set hbz=(h<=pi/2) ? h : (pi-h)
		set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
		set fakeomegah=a/4
		set ratbz=parabz/fakeomegah
		#set shiftbz=ratbz+0.1
		#
		relocate 1.6 0.255
		putlabel 5 "parabolic"
		ltype 2 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h ratbz 0 001
		#
		relocate 0.7 0.51
		putlabel 5 "monopole"
		#
		set mono=hbz*0+0.5
		ltype 3 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h mono 0 001
		#
		lweight 3
		#
omegafplot1 0   #
		# device postencap omegapara001.eps
		#
		defaults
		fdraft
		#
		jrdpcf2d dump0100
		faraday
		#
		define x1label "\theta"
		define x2label "\Omega_F/\Omega_H"
		#
		#set thin=0.2
		#set thout2.9
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.0001*$rhor
		#set myrin=3.4
		#set myrout=3.6
		#
		set omegah=a/(2.0*$rhor)
		#
		set rat2=omegaf2/omegah
		set rat1=omegaf1/omegah
		lweight 5 ltype 0 ctype default
		#setlimits myrin myrout thin thout 0.2 0.6 plflim 0 x2 r h rat2 1
		set newx=h if(ti==1)
		set newfun=rat2 if(ti==1)
		pl 0 newx newfun 0001 thin thout 0.2 0.6
		#
		relocate 1.08 0.433
		putlabel 5 "r_+"
		#
		#
		# ISCO r=6
		relocate 1.02 0.36
		putlabel 5 "r_{\rm ISCO}"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==75)
		set newfun=rat2 if(ti==75)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		# r=10
		relocate 0.57 0.34
		putlabel 5 "10r_g"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==104)
		set newfun=rat2 if(ti==104)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		set hbz=(h<=pi/2) ? h : (pi-h)
		set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
		set fakeomegah=a/4
		set ratbz=parabz/fakeomegah
		#set shiftbz=ratbz+0.1
		#
		relocate 1.6 0.255
		putlabel 5 "parabolic"
		ltype 2 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h ratbz 0 001
		#
		relocate 0.7 0.51
		putlabel 5 "monopole"
		#
		set mono=hbz*0+0.5
		ltype 3 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h mono 0 001
		#
		lweight 3
		#
omegafplot2 0   #
		# device postencap omegapara9.eps
		#
		defaults
		fdraft
		#
		jrdpcf2d dump0100
		faraday
		#
		define x1label "\theta"
		define x2label "\Omega_F/\Omega_H"
		#
		#set thin=0.2
		#set thout2.9
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.0001*$rhor
		#set myrin=3.4
		#set myrout=3.6
		#
		set omegah=a/(2.0*$rhor)
		#
		set rat2=omegaf2/omegah
		set rat1=omegaf1/omegah
		lweight 5 ltype 0 ctype default
		#setlimits myrin myrout thin thout 0.2 0.6 plflim 0 x2 r h rat2 1
		set newx=h if(ti==1)
		set newfun=rat2 if(ti==1)
		pl 0 newx newfun 0001 thin thout 0.2 0.6
		#
		relocate 1.08 0.433
		putlabel 5 "r_+"
		#
		#
		# ISCO r=6
		relocate 1.02 0.36
		putlabel 5 "r_{\rm ISCO}"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==35)
		set newfun=rat2 if(ti==35)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		# r=10
		relocate 0.57 0.34
		putlabel 5 "10r_g"
		#
		lweight 5 ltype 1 ctype default
		set newx=h if(ti==118)
		set newfun=rat2 if(ti==118)
		pl 0 newx newfun 0011 thin thout 0.2 0.6
		#
		set hbz=(h<=pi/2) ? h : (pi-h)
		set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
		set fakeomegah=a/4
		set ratbz=parabz/fakeomegah
		#set shiftbz=ratbz+0.1
		#
		relocate 1.58 0.255
		putlabel 5 "parabolic"
		ltype 2 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h ratbz 0 001
		#
		relocate 0.7 0.51
		putlabel 5 "monopole"
		#
		set mono=hbz*0+0.5
		ltype 3 ctype default
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h mono 0 001
		#
		lweight 3
		#
		#
setupeplot 0    #
		gogrmhd
		#
		jrdpcf2d dump0100
		gammiegridnew3 gdump
		#
		#
energyplot0   0 #
		#
		# RUN setupeplot
		#
		# device postencap energyflux.eps
		#
		# defaults
		define dobzparaenergy 0
		#
		if(0){\
		# /mnt/disk/runsaurongrffe/ffa.001.pt3-3hr
		# a=0.001
		# hor=2
		# isco=5.997
		set ihor=1
		set iisco=75
		set i10=104
		set iouter=214
		set maxdPdh=1E-4
		set mindPdh=1E-7
		define typeput 1
		define dobzparaenergy 1
		}
		if(0){\
		# /raid2/jmckinne/ffa.001.pt3.27
		# 128^2
		# a=0.001
		# hor=2
		# isco=5.997
		set ihor=1
		set iisco=37
		set i10=52
		set iouter=127
		set maxdPdh=1
		set mindPdh=1E-4
		define typeput 1
		define dobzparaenergy 1
		}
		if(0){\
		# /raid3/jmckinne/ffm3pt632hr_a.1
		# hor=2
		# isco=5.67
		set ihor=2
		set iisco=72
		set i10=104
		set iouter=214
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(0){\
		# /raid3/jmckinne/ffm3pt632hr_a.2
		# hor=1.98
		# isco=5.33
		set ihor=1
		set iisco=69
		set i10=104
		set iouter=205
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(0){\
		# /raid2/jmckinne/ffm3pt632hr_a.5
		# hor=1.87
		# isco=4.233
		set ihor=2
		set iisco=58
		set i10=107
		set iouter=209
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(0){\
		# /raid2/jmckinne/ffm3pt632hr_a.8
		# hor= 1.6
		# isco=2.9
		set ihor=1
		set iisco=43
		set i10=113
		set iouter=219
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(1){\
		# a=0.9
		# paper II fiducial n=1/4 model
		# /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		#
		# fiducial parabolic model with a=0.9
		# /raid3/jmckinne/ffa.pt5.32
		#
		# hor= 1.44
		# isco=2.321
		set ihor=1
		set iisco=35
		set i10=118
		set iouter=219
		set maxdPdh=20
		set mindPdh=0.1
		define typeput 2
		}
		if(0){\
		# /raid3/jmckinne/ffm44hr_a.9
		# hor= 1.44
		# isco=2.32
		set ihor=1
		set iisco=35
		set i10=118
		set iouter=219
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(0){\
		# /raid2/jmckinne/ffm4.pt6.mhd
		# hor= 1.44
		# isco=2.32
		set ihor=1
		set iisco=17
		set i10=59
		set iouter=85
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		if(0){\
		# /raid2/jmckinne/ffm3pt632hr_a.9375
		# hor=1.35
		# isco=2.044
		set ihor=1
		set iisco=30
		set i10=121
		set iouter=250
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		#
		if(0){\
		# /raid2/jmckinne/ffm3pt632hr_a.99
		# hor=1.14
		# isco=1.454
		set ihor=1
		set iisco=18
		set i10=127
		set iouter=250
		set maxdPdh=10
		set mindPdh=1E-2
		define typeput 0
		}
		#
		# pick norm type
		#
		# normalized by initial field
		if(0){\
		jrdpcf2d dump0000
		set B1ks=B1*dxdxp11+B2*dxdxp21
		set Bhor=B1ks[ihor+0*$nx]
		print {Bhor}
		}
		#
		# normalized by final field
		if(1){\
		jrdpcf2d dump0100
		set B1ks=B1*dxdxp11+B2*dxdxp21
		set Bhor=B1ks[ihor+0*$nx]
		}
		#
		# normalized by vertical feild in disk at isco
		if(0){\
		jrdpcf2d dump0000
		set B1ks=B1*dxdxp11+B2*dxdxp12
		set B2ks=B1*dxdxp21+B2*dxdxp22
		set Bhor=B2ks[iisco+$nx*($ny/2-1)]
		}
		#
		#
		jrdpcf2d dump0100
		# gammiegridnew3 gdump
		#
		set sigma=r**2+a**2*cos(h)**2
		set gdetks=sigma*sin(h)
		#
		# catastrophic cancellations can occur for small velocities between Tud10part3 and Tud10part6
		stresscalc 1
		#
		set efluxks=dxdxp11*Tud10+dxdxp21*Tud20
		#set eflux=-Tud10*gdet*$dx2*2*pi/(sin(h)*dh)
		#set eflux=-efluxks*r**2*2*pi/Bhor**2
		set eflux=-efluxks*(gdetks/sin(h))*2*pi/Bhor**2
		#
		#
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.0001*$rhor
		#
		# below avoids catastrophic cancellations as long as HARM was good
		faraday
		set B1ks=B1*dxdxp11+B2*dxdxp12
		set B2ks=B1*dxdxp21+B2*dxdxp22
		set B3ks=B3
		#
		set delta=r**2-2*r+a**2
		set othereflux1ks=-2*B1ks*B1ks*omegaf2*r*(omegaf2-a/(2*r))*sin(h)**2-B1ks*B3ks*omegaf2*delta*sin(h)**2
		set othereflux2ks=-2*B1ks*B2ks*omegaf2*r*(omegaf2-a/(2*r))*sin(h)**2-B2ks*B3ks*omegaf2*delta*sin(h)**2
		#set othereflux1ks=othereflux1*dxdxp11+othereflux2*dxdxp12
		#set othereflux2ks=othereflux1*dxdxp21+othereflux2*dxdxp22
		#
		set eflux=othereflux1ks*(gdetks/sin(h))*2*pi/Bhor**2
		#
		#
		set dh=$dx2*dxdxp22
		set god=othereflux1ks*gdetks*dh*2*pi/Bhor**2 if(ti==1)
		set godsum=SUM(god) print {godsum}
		# 
		#
		ctype default
		#
		#
		ltype 0 lweight 3
		define x1label "\theta"
		define x2label "dP/d\theta"
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==ihor)
		set newfun=eflux if(ti==ihor)
		pl 0 newx newfun 0101 thin thout mindPdh maxdPdh
		if($typeput==0) { relocate 1.571 -.86 }
		if($typeput==1) { relocate 1.49 -6.05 }
		if($typeput==2) { relocate 1.56 -.766 }
		putlabel 5 "r_+"
		#
		if($dobzparaenergy==1){\
		       #
		       set hbz=(h<=pi/2) ? h : (pi-h)
		       #set fplus=1+cos(h)
		       #set fminus=1-cos(h)
		       set Brpara=(r+2*ln(1+cos(hbz)))/(2*r**2)
		       #set omegafpara=(1/4*sin(h)**2*(1+ln(1+cos(h))))/(4*ln(2)+sin(h)**2+(sin(h)**2-2*(1+cos(h)))*ln(1+cos(h)))
		       set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
		       set fakeomegah=a/4
		       #
		       set fakehor=2
		       set Bparahor=Brpara[ihor+0*$nx]
		       set efluxdenpara=2*Brpara**2*parabz*fakehor*(fakeomegah-parabz)*sin(hbz)**2/Bparahor**2
		       #
		       set fakegdetks=fakehor**2*sin(hbz)
		       set efluxpara=2*pi*efluxdenpara*fakegdetks
		       #
		       #
		       set newx=h if(ti==ihor)
		       set newfun=efluxpara/sin(h) if(ti==ihor)
		       #
		       ctype default ltype 2 
		       pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		       #
		       set temp=efluxpara*dh if(ti==ihor)
		       set powerbzpara=SUM(temp)
		       print {powerbzpara}
		       #
		       set temp2=efluxpara*dh/(parabz*4/a) if(ti==ihor)
		       #
		       set effparabz=SUM(temp)/SUM(temp2)
		       print {effparabz}
		       #
		       #
		}
		#
		#
		if($typeput==0) { relocate 0.9 -.3 }
		if($typeput==1) { relocate 1.08 -5.69 }
		if($typeput==2) { relocate 0.97 -.34 }
		putlabel 5 "r_{\rm ISCO}"
		ltype 0 lweight 3
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==iisco)
		set newfun=eflux if(ti==iisco)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		if($typeput==0) { relocate 0.96 0.195 }
		if($typeput==1) { relocate 0.71 -5.41 }
		if($typeput==2) { relocate 0.98 0.15 }
		putlabel 5 "10r_g"
		ltype 0 lweight 3
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==i10)
		set newfun=eflux if(ti==i10)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		if($typeput==0) { relocate 0.69 0.85 }
		if($typeput==1) { relocate 0.345 -4.65 }
		if($typeput==2) { relocate 0.56 0.88 }
		putlabel 5 "10^3r_g"
		#
		define PLOTLWEIGHT (7)
		define NORMLWEIGHT (3)
		ltype 0
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==iouter)
		set newfun=eflux if(ti==iouter)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		define PLOTLWEIGHT (3)
		#
		#set Tud10norm=-gdet*Tud10*$dx2*2*pi/Bhor**2
		set Tud10norm=othereflux1ks*gdetks*dh*2*pi/Bhor**2
		#set Tud10norm=eflux*$dx2*dxdxp22*sin(h)
		set omegah=a/(2*$rhor)+r*0
		set eomegafrat=Tud10norm/(omegaf2/omegah)
		#
		set ehor=Tud10norm if(ti==ihor)
		set eorat=eomegafrat if(ti==ihor)
		set eisco=Tud10norm if(ti==iisco)
		set e10=Tud10norm if(ti==i10)
		set elarge=Tud10norm if(ti==iouter)
		set ehortot=SUM(ehor)
		set eiscotot=SUM(eisco)
		set e10tot=SUM(e10)
		set elargetot=SUM(elarge)
		print {ehortot eiscotot e10tot elargetot}
		#
		set eff=ehortot/SUM(eorat)
		print {eff}
		#
		# over H/R=0.6 region
		set ehor=Tud10norm if((ti==ihor)&&(abs(h-pi/2)>0.3))
		set ehortotlimited=SUM(ehor)
		print {ehortotlimited}
		#
testdh 0        #
		set myh=h if(ti==1)
		set mytj=tj if(ti==1)
		#
		#setlimits $rhor (1.01*$rhor) 0 pi 0 1 plflim 0 x2 r h h 0
		ctype default pl 0 mytj myh
		#
		der mytj myh dmytj dmyh
		ctype default pl 0 dmytj dmyh
		set trydh=dxdxp22*$dx2 if(ti==1)
		ctype red plo 0 mytj trydh
		# 
		#
energyvsr0  0   # assume above energyplot0 called
		#
		set newr=r if(tj==0)
		set evsr=newr*0
		set newii=ti if(tj==0)
		#
		do ii=0,$nx-1,1{\
		       set temp=Tud10norm if($ii==ti)
		       set evsr[$ii]=SUM(temp)
		    }
		#
		ctype default
		pl 0 newr evsr 1000
		#
		#
energyplot1   0 #
		# device postencap energyfluxgrmhd.eps
		#
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#
		if(1){\
		   #greaddumpfull dumptavg2new
		   greaddumpfull dumpavg1525.txt
		   # 0.1307      0.3109      0.5294      0.1335
		                #greaddump dumptavg2040v2
		#
		readg42 tavg422040.txt
		#
		}
		if(0){\
		       jrdp2d dump0040
		       # 0.3242      0.4074      0.5947      0.3741
		       stresscalc 1
		}
		gammiegrid gdump
		jre punsly.m
		setdxdxpold
		#
		energyreplot1
		#
		#
energyreplot1 0 #
		#
		# device postencap energyfluxgrmhd.eps
		#
		#set thin=0.2
		#set thout2.9
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.0001*$rhor
		#set myrin=3.4
		#set myrout=3.6
		#
		set ihor=2
		#set iisco=67
		set iisco=58
		set i10=271
		set iouter=$nx-1
		#
		#
		# PICK EM or MA
		#
		if(1){\
		       set efluxks=dxdxp11*Tud10EM+dxdxp21*Tud20EM
		       set maxdPdh=10
		       set mindPdh=1E-2
		    }
		    #
		#
		if(0){\
		 # rest-mass removed from diag flux but not from the SM calculation
		 #
		 set efluxks=dxdxp11*(Tud10MA+rho*uu1)+dxdxp21*(Tud20MA+rho*uu2)
		 #set efluxks=dxdxp11*(Tud10MA)+dxdxp21*(Tud20MA)
		}
		#
		if(0){\
		       # pick total energy
		       set efluxks=dxdxp11*(Tud10)+dxdxp21*(Tud20)
		       set maxdPdh=50
		       set mindPdh=1E-2
		    }
		#
		set B1ks=B1*dxdxp11+B2*dxdxp21
		#
		set Bhor=B1ks[ihor+0*$nx]
		#
		set eflux=-efluxks*r**2*2*pi/Bhor**2
		#
		ltype 0 lweight 3
		define x1label "\theta"
		define x2label "dP/d\theta"
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==ihor)
		set newfun=eflux if(ti==ihor)
		pl 0 newx newfun 0101 thin thout mindPdh maxdPdh
		#relocate 0.32 -1.36
		relocate 2.89 -1.54
		putlabel 5 "r_+"
		#
		relocate 2.33 -.376
		putlabel 5 "r_{\rm ISCO}"
		ltype 0 lweight 3
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==iisco)
		set newfun=eflux if(ti==iisco)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		relocate 2.44 0.0123
		putlabel 5 "10r_g"
		ltype 0 lweight 3
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==i10)
		set newfun=eflux if(ti==i10)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		relocate 2.82 .489
		putlabel 5 "40r_g"
		define PLOTLWEIGHT (7)
		define NORMLWEIGHT (3)
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h eflux 0
		set newx=h if(ti==iouter)
		set newfun=eflux if(ti==iouter)
		pl 0 newx newfun 0111 thin thout mindPdh maxdPdh
		#
		define PLOTLWEIGHT (3)
		define NORMLWEIGHT (3)
		#
		# divide out polar value of field strength
		set Tud10norm=-gdet*Tud10EM*$dx2*2*pi/Bhor**2
		#
		set ehor=Tud10norm if(ti==ihor)
		set eisco=Tud10norm if(ti==iisco)
		set e10=Tud10norm if(ti==i10)
		set elarge=Tud10norm if(ti==iouter)
		set ehortot=SUM(ehor)
		set eiscotot=SUM(eisco)
		set e10tot=SUM(e10)
		set elargetot=SUM(elarge)
		print {ehortot eiscotot e10tot elargetot}
		#
		#set Tud10norm=-gdet*(Tud10MA+rho*uu1)*$dx2*2*pi/Bhor**2
		set Tud10norm=-gdet*(Tud10MA)*$dx2*2*pi/Bhor**2
		#
		set ehor=Tud10norm if(ti==ihor)
		set eisco=Tud10norm if(ti==iisco)
		set e10=Tud10norm if(ti==i10)
		set elarge=Tud10norm if(ti==iouter)
		set ehortot=SUM(ehor)
		set eiscotot=SUM(eisco)
		set e10tot=SUM(e10)
		set elargetot=SUM(elarge)
		print {ehortot eiscotot e10tot elargetot}
		#
		set Tud10norm=-gdet*(Tud10)*$dx2*2*pi/Bhor**2
		#
		set ehor=Tud10norm if(ti==ihor)
		set eisco=Tud10norm if(ti==iisco)
		set e10=Tud10norm if(ti==i10)
		set elarge=Tud10norm if(ti==iouter)
		set ehortot=SUM(ehor)
		set eiscotot=SUM(eisco)
		set e10tot=SUM(e10)
		set elargetot=SUM(elarge)
		print {ehortot eiscotot e10tot elargetot}
		#
compplot0 0     #
		# /raid3/jmckinne/ffm3pt632hr_a.1
		# device postencap a.1_t0_tf.eps
		#
		# /mnt/disk/runsaurongrffe/ffm3.pt6.32hr (a=0.9)
		#
		# /raid2/jmckinne/ffm3pt632hr_a.9375
		# device postencap a.9375_t0_tf.eps
		#
		# /raid3/jmckinne/ffa.pt5.32
		# device postencap paraa.9_t0_tf.eps
		defaults
		#
		define finaldraft (1)
		define PLOTLWEIGHT (5)
		define NORMLWEIGHT (3)
		lweight $PLOTLWEIGHT
		#
		compfield 0000 0100
		define PLOTLWEIGHT (3)
		define NORMLWEIGHT (1)
		#
compfield 2     #
		#
		#
		jrdpcf2d dump$1
		fieldcalc 0 aphi0
		jrdpcf2d dump$2
		fieldcalc 0 aphi1
		#
		define x1in (0)
		define x1out (5.1*1E2)
		define x2in (-1.1*1E3)
		define x2out (1.1*1E3)
		#
		interpsingle aphi0 256 256 $x1in $x1out $x2in $x2out
		interpsingle aphi1 256 256 $x1in $x1out $x2in $x2out
		#
		readinterp aphi0
		readinterp aphi1
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define POSCONTLTYPE 1
		define NEGCONTLTYPE 1
		plc 0 iaphi0 001 $x1in $x1out $x2in $x2out
		set mynewfun0=newfun
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		#define POSCONTCOLOR "red"
		#define NEGCONTCOLOR "red"
		define BOXCOLOR "default"
		define POSCONTLTYPE 0
		define NEGCONTLTYPE 0
		plc 0 iaphi1 011 $x1in $x1out $x2in $x2out
		set mynewfun1=newfun
		#
		#
grmhdfield0 0 #
		# device postencap grmhdfield.eps
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		set _defcoord=0
		set defcoord=_defcoord
		#
		jre gtwodavgs.m
		greaddumpfull dumptavg2new
		#greaddump dumptavg2040v2
		#
		#jrdp2d dump0000
		#fieldcalc 0 aphi0
		#interpsingle aphi0 512 512 40 40
		#readinterp aphi0
		interpsingle aphi 512 512 40 40
		readinterp aphi
		#
		fdraft
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define finaldraft (1)
		define PLOTLWEIGHT (3)
		define NORMLWEIGHT (3)
		lweight $PLOTLWEIGHT
		#
                angle 0
                define x1label "R c^2/(GM)"
                xla $x1label
                define x2label "z c^2/(GM)"
                #angle 360
                yla $x2label
                #
		plc 0 iaphi 001 0 40 0 40
		#
		#
field2overlay0 0 #
		# device postencap grmhd_ic_fc.eps
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		set _defcoord=0
		set defcoord=_defcoord
		#
		jrdp2d dump0000
		faraday
		set Bd3init=gdet*fuu12
		fieldcalc 0 aphi0
		interpsingle aphi0 512 512 40 40
		interpsingle Bd3init  512 512 40 40
		#
		# for original GRMHD model
		jrdp2d dump0040
		faraday
		set Bd3final=gdet*fuu12
		fieldcalc 0 aphi1
		interpsingle aphi1 512 512 40 40
		interpsingle Bd3final  512 512 40 40
		#
		field2overlay0plot
		readinterp Bd3init
		readinterp Bd3final
		#
field2overlay1 0 #
		# device postencap grmhd_ic_fc_nfourth.eps
		#/raid3/jmckinne/grmhdgrffe_a.9375
		# CHANGE cres IN FIELD2OVERLAY0PLOT!
		#
		jrdp2d dump0000
		faraday
		set Bd3init=gdet*fuu12
		fieldcalc 0 aphi0
		interpsingle aphi0 512 512 40 40
		interpsingle Bd3init  512 512 40 40
		#
		# FOR NOW for new n=1/4 GRMHD model
		jrdp2d dump0040
		faraday
		set Bd3final=gdet*fuu12
		fieldcalc 0 aphi1
		interpsingle aphi1 512 512 40 40
		interpsingle Bd3final  512 512 40 40
		#
		field2overlay0plot
		readinterp Bd3init
		readinterp Bd3final
		#
		#
field2overlay0plot 0 #
		# device postencap grmhd_ic_fc.eps
		# /mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# CHANGE cres IN FIELD2OVERLAY0PLOT!
		# 
		#
		fdraft
		window 1 1 1 1
		erase
                fdraft
		#
		define POSCONTCOLOR "default"
		define NEGCONTCOLOR "default"
		define BOXCOLOR "default"
		define finaldraft (1)
		define PLOTLWEIGHT (3)
		define NORMLWEIGHT (3)
		lweight $PLOTLWEIGHT
		#
		set outerR=40
		set innerR=40
		#
		define xin 0
                define xout (outerR*1.1)
                define yin (-outerR)
                define yout (outerR)
                limits $xin $xout $yin $yout
		#
		#define x_gutter 0.6
                window -2 1 1 1 box 1 2 0 0
		#
                angle 0
                define x1label "R c^2/(GM)"
                xla $x1label
                define x2label "z c^2/(GM)"
                #angle 360
                yla $x2label
                #
		# FOR BOTH MODELS
		define cres 15
		readinterp aphi0
		plc 0 iaphi0 011 $xin $xout $yin $yout
		#
		# PLOT PANEL 2
		#
		limits $xin $xout $yin $yout
                #limits 0 outerR -outerR outerR
                #define x_gutter 0.6
                window -2 1 2 1 box 1 0 0 0
		#
		# FOR GRMHD LOOP MODEL
		define cres 15
		# FOR NFOURTH MODEL
		#define cres 22
		readinterp aphi1
		plc 0 iaphi1 011 $xin $xout $yin $yout
                angle 0
                define x1label "R c^2/(GM)"
                xla $x1label
		#
		#
dobsqcalc 0     #
		gcalc2 3 2 0.3 bsq bsqvsr
		set mybsqvsr=sqrt(bsqvsr)
		#
		fdraft
		define x1label "r c^2/GM"
		define x2label "|b|"
		ltype 0 ctype default pl 0 newr mybsqvsr 1100
		set myfit=mybsqvsr[0]*(newr/Rin)**(-5/4) #if(newr<9)
		set godr=newr #if(newr<9)
		#ctype red pl 0 godr myfit 1110
		ltype 2 ctype default pl 0 godr myfit 1110
		#
		#
		#
grmhdcurrent0 0         #
		# bh06:/fs1/jon/grmhd-a.9375-256by256-fl46-newtop
		# now:
		# /mnt/disk/runbhgrmhd/grmhd-a.9375-256by256-fl46-newtop
		#
		#/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#
		gammiegrid gdump
		jrdp2d dump0000
		#
		define startdump (15)
		define enddump (30)
		#
		avgtimeg4 'dump' $startdump $enddump
                printg42 tavg4.2.txt
		#
		
		avgtimeg3 'dump' $startdump $enddump
		# printg3 tavg32040.txt
		#
                avgtimegfull 'dump' $startdump $enddump
                gwritedump dumptavg2
                avgtimeg5 'dump' $startdump $enddump
                printg5 tavg5.2.txt
		#
redoavg0 0      # val2 was wrongly set?
		#/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# (this run has no currents, so can't use avgtimegfull2)
		# had to force nz defined as 1 in avgtimegfull
		#
		define startdump (20)
		define enddump (40)
		define nz (1)
                avgtimegfull 'dump' $startdump $enddump
		#
		set _defcoord=0
		set hslope=0.3
		set _hslope=hslope
                gwritedumpfull dumptavg2new
		#
		greaddumpfull dumptavg2new
		#
getavg3 0       #
		define startdump (15)
		define enddump (30)
		#
		avgtimegfull2 'dump' $startdump $enddump
		gwritedump2 dumptavg3
		greaddump2 dumptavg3
                #
otherplot0 0    #
		plc 0 jd3
		gcalc2 3 0 pi/2 jd3 jd3vsr20tavg
		pl 0 newr jd3vsr20tavg   1100
		#
		jre punsly.m
		#
		plsplit 0 newr jd3vsr20tavg   1101 Rin Rout .1 1E4
		#ctype blue pl 0 newr jd3vsr20 1111 Rin Rout .1 1E4
		set myjd3=4*r**1.2
		ctype blue pl 0 r myjd3 1111 Rin Rout .1 1E4
		#
grmhdcurrent1 0 #
		#
		# or use one dump
		jrdpcf2d dump0020
		#
		plc 0 jd3
		gcalc2 3 0 pi/2 jd3 jd3vsr20
		pl 0 newr jd3vsr20   1100
		jre punsly.m
		#
		plsplit 0 newr jd3vsr20   1101 Rin Rout .1 1E4
		#
		#set myjd3=8/r**2
		set myjd3=4*r**1.5
		ctype blue pl 0 r myjd3 1111 Rin Rout .1 1E4
		#
		#set myjd3=8/r**2
		set myjd3=4*r**1.2
		ctype cyan pl 0 r myjd3 1111 Rin Rout .1 1E4
		#
		#
		# split monopole
		setlimits Rin Rout 1.57 1.572 0 1
		# 1/r^4
		#plflim 0 x1 r h ju3 0 110
		# 1/r^2
		plflim 0 x1 r h jd3 0 110
		#
		#
		# enclosed toroidal current
		#
		#
torenccompute 0 #
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
		set ju3test=1/r**4
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
torenccompute2 0 #
		#
		jre punsly.m
		setdxdxpold
		#
		set ivstheta=0,$ny-1
		set ivstheta=0*ivstheta
		set ivsthetasum=0*ivstheta
                #
		set myfunc=ju3
		#
		do jj=0,$ny-1,1 {
		 #set use = ($jj==tj && r>0 && r<=10 ) ? 1 : 0
		 #set use = ($jj==tj && r>8 && r<=10 ) ? 1 : 0
		 set use = ($jj==tj && r>$rhor && r<=3 ) ? 1 : 0
		 set ivstheta[$jj]=SUM(myfunc*$dx1*$dx2*gdet*use)
		 #
		 if($jj>0){\
		   set ivsthetasum[$jj]=ivstheta[$jj]+ivsthetasum[$jj-1]
		 }
		 if($jj==0){\
		   set ivsthetasum[$jj]=ivstheta[$jj]
		 }
		 #
		}
		#
		#
		set mytheta=h if(ti==0)
		#
torenccompute3 0 #
		#
		jre punsly.m
		setdxdxpold
		#
		set ivstheta=0,$ny-1
		set ivstheta=0*ivstheta
		set ivsthetasum=0*ivstheta
                #
		set myfunc=ju3
		#
		do jj=0,$ny-1,1 {
		 set use = ($jj==tj && r>0 && r<=10 ) ? 1 : 0
		 #set use = ($jj==tj && r>8 && r<=10 ) ? 1 : 0
		 #set use = ($jj==tj && r>$rhor && r<=3 ) ? 1 : 0
		 set ivstheta[$jj]=SUM(myfunc*$dx1*$dx2*gdet*use)
		 #
		 if($jj>0){\
		   set ivsthetasum[$jj]=ivstheta[$jj]+ivsthetasum[$jj-1]
		 }
		 if($jj==0){\
		   set ivsthetasum[$jj]=ivstheta[$jj]
		 }
		 #
		}
		#
		#
		set mytheta=h if(ti==0)
		#
testenc0 1      #
		#set myangle=0.7
		set myangle=pi/2
		#define ii (62)
		#define ii (31)
		define ii ($1)
		set crapolause=((abs(h-0.5*pi)<=myangle)&&($ii==ti)) ? 1 : 0
		set ivsr=ju3*$dx1*$dx2*gdet if(crapolause)
		set myh=h if(crapolause)
		#
		#print {myh ivsr}
		#
		#pl 0 myh ivsr
		#points myh ivsr
		#
		set god=SUM(ivsr) print {god}
		#
doline0 1       #
		testenc0 $1
		sumline0 ivsr
		pl 0 myh sumivsr
		#
sumline0 1      #
		set iinner=0
		set iouter=dimen($1)-1
		#
		set listi=0,dimen($1)-1,1
		set sum$1=0,dimen($1)-1,1
		set sum$1=sum$1*0
		#
		do ii=iinner,iouter,1 {
		   set myfunc=$1 if(listi<=$ii)
		   set sum$1[$ii]=SUM(myfunc)
		}
		#
		# pl 0 myh sumivsr
		smooth sumivsr ssumivsr 40
		set sumivsr=ssumivsr
		#
		#
plotsum0 0      #
		set iinner=0
                set iouter=$nx-1
                define mynx ($nx)
		set ivsrh=0,$nx*$ny-1,1
		set ivsrh=ivsrh*0
                #
		do iii=iinner,iouter,1 {
		   testenc0 $iii
		   sumline0 ivsr
		   set godii=$iii
		   do jj=0,$ny-1,1 {
		      set ivsrh[godii+$jj*$nx]=sumivsr[$jj]
		   }
		   pl 0 myh sumivsr
		}
		#
seeju3 0        #
		set myju3=ju3*gdet*$dx1*$dx2
		#
getfields0 0    #
		set B1h=B1*sqrt(gv311)
		set B2h=B2*sqrt(gv322)
		set B3h=B3*sqrt(gv333)
		set u1h=uu1*sqrt(gv311)
		set u3h=uu3*sqrt(gv333)
		#
		faraday
		set fm=gdet*rho*uu1
		set grat=fdd23/sqrt(-fm)
		#
		set hor=sqrt(cs2)/(r*omega3)
		#
lbramesh0 0     #
		#
		gogrmhd
		jre ramesh_disk.m
		jrdp2d dump0000
		gammiegridnew3 gdump
		#
		#
doplotgod0 0    #
		#jrdp2d dump1000
		#gammiegridnew3 gdump
		#
		set myB3=B3*sqrt(gv333) if(tj==0)
		set myr=r if(tj==0)
		ctype default pl 0 myr myB3 1100
		#
		set myfit=1.6*myB3[0]*(myr/myr[0])**(-5/4)
		ctype red pl 0 myr myfit 1110
		#
		set myfit=15*myB3[0]*(myr/myr[0])**(-5/4)
		ctype red pl 0 myr myfit 1110
		#
		set myfit=1.6*myB3[0]*(myr/myr[0])**(-0.8)
		ctype cyan pl 0 myr myfit 1110
		#
		set myfit=2.0*myB3[0]*(myr/myr[0])**(-0.9)
		ctype blue pl 0 myr myfit 1110
		#
doplotgod1 0    #
		#jrdp2d dump1000
		#gammiegridnew3 gdump
		#
		set myB2=B2*sqrt(gv322) if(tj==0)
		set myr=r if(tj==0)
		ctype default pl 0 myr myB2 1100
		#
		set myfit=1.6*myB2[0]*(myr/myr[0])**(-0.8)
		ctype red pl 0 myr myfit 1110
		#
		set myfit=2.0*myB2[0]*(myr/myr[0])**(-0.9)
		ctype blue pl 0 myr myfit 1110
		#
doplotgod2 0    #
		#jrdp2d dump1000
		#gammiegridnew3 gdump
		#
		set myb=sqrt(bsq) if(tj==0)
		set myr=r if(tj==0)
		ctype default pl 0 myr myb 1100
		#
		#set myfit=1.6*myb[0]*(myr/myr[0])**(-5/8)
		set myfit=1.5*myb[0]*(myr/myr[0])**(-5/4)
		ctype red pl 0 myr myfit 1110
		#
		#set myfit=2.4*myb[0]*(myr/myr[0])**(-.85)
		#ctype blue pl 0 myr myfit 1110
		#
		#
anims0 0        #
		#agpl 'dump' r (B2*sqrt(gv322)) 1100
		#agpl 'dump' r (B3*sqrt(gv333)) 1100
		agpl 'dump' r (sqrt(bsq)) 1100
		#
torencplot 1 #
		#
		fdraft
		define x1label "r c^2/GM"
		define x2label "I_\phi(r)"
		if($1==0){ ltype 0 ctype default pl 0 newr ivsr 1100}\
		    else { ltype 0 ctype default pl 0 newr ivsr 1110}
		# myn=1 works for split monopole at early times (dump0001)
		# myn=1 pretty good for late times too for split monopole (dump0200)
		# myn=1/4 works for GRMHD disk with a=0.9375 (dump0020 or dumptavg3)
		# greaddump2 dumptavg3
		#
		set iouter=$mynx-1
		#set iouter=50
		#
		# mono
		set myn=1
		set myA=(ivsr[iouter]-ivsr[0])/(2.0*(1/newr[0]**myn-1/newr[iouter]**myn))
		set fitiencvsr=ivsr[0]+2.0*myA*(1/newr[0]**myn-1/newr**myn)
		#ctype red pl 0 newr fitiencvsr 1110
		ltype 1 ctype default pl 0 newr fitiencvsr 1110
		#
		# para
		set myn=0
		set myA=(ivsr[iouter]-ivsr[0])/ln(newr[iouter]/newr[0])
		set fitiencvsr=ivsr[0]+myA*ln(newr/newr[0])
		ltype 3 ctype default pl 0 newr fitiencvsr 1110
		#
		# GRMHD-type
		set myn=1/4
		set myA=(ivsr[iouter]-ivsr[0])/(2.0*(1/newr[0]**myn-1/newr[iouter]**myn))
		set fitiencvsr=ivsr[0]+2.0*myA*(1/newr[0]**myn-1/newr**myn)
		#ctype red pl 0 newr fitiencvsr 1110
		ltype 2 ctype default pl 0 newr fitiencvsr 1110
		#
		#
		#
		#
tordencompute 0 # GODMARK: fixup calculation to be more general for general grid
		#
		jre punsly.m
		setdxdxpold
		#
		set dh=dxdxp22*$dx2
		#
		# toroidal current density vs. radius
		#
		# no boundary zones
		if(ti[0]==0){\
		       set iinner=0
		       set iouter=$nx-1
		    }
		    if(ti[0]<0){\
		           # boundary zones
		           set iinner=-1
		           set iouter=$nx-1-3
		        }
                define mynx (iouter-iinner+1)
		set kvsr=0,$mynx-1
		set newx1=0,$mynx-1
		set newr=0,$mynx-1
                #
		do ii=iinner,iouter,1 {
		   #
		   set kvsruse = ((abs(h-0.5*pi)<pi/2) && ti==$ii) ? 1 : 0
		   #set kvsruse = ((abs(h-0.5*pi)<0.7) && ti==$ii) ? 1 : 0
		   #
		   #set kvsr[$ii-iinner]=SUM(ju3*$dx2*gdet*kvsruse)/SUM($dx2*gdet*kvsruse)
		   #set kvsr[$ii-iinner]=SUM(ju3*$dx1*$dx2*gdet*kvsruse)
		   #set kvsr[$ii-iinner]=SUM(ju3*$dx2*gdet*kvsruse)
		   #set kvsr[$ii-iinner]=SUM(ju3*r**2*sin(h)*dh*kvsruse)
		   set func=ju3*(r**2+a**2*cos(h)**2)*sin(h)*dh
		   set kvsr[$ii-iinner]=SUM(func*kvsruse)
		   #set kvsr[$ii-iinner]=SUM(ju3*$dx2*kvsruse)
		   #
		   set newrtemp=r if((ti==$ii)&&(tj==0))
		   set newx1temp=x1 if((ti==$ii)&&(tj==0))
		   set newx1[$ii-iinner]=newx1temp
		   set newr[$ii-iinner]=newrtemp
		   #
		}
		#
		#
tordenplot 1    # 0: erase 1: overlay
		#
		define x1label "r c^2/GM"
		define x2label "dI_{enc}(r)/dr"
		#
		#ltype 0 ctype default plsplit 0 newr kvsr 1101 Rin Rout 1E-4 10
		if($1==0){\
		       ltype 0 ctype default pl 0 newr kvsr 1101 Rin Rout 1E-4 10
		    }\
		    else{\
		       ltype 0 ctype default pl 0 newr kvsr 1111 Rin Rout 1E-4 10
		 }
		 # para
		set kvsrfit=kvsr[0]*(newr/newr[0])**(-1.0)
		ltype 1 pl 0 newr kvsrfit 1110
		# n=1/4
		set kvsrfit=1.0*kvsr[0]*(newr/newr[0])**(-1.25)
		ltype 1 ctype default pl 0 newr kvsrfit 1110
		#set kvsrfit=kvsr[0]*(newr/newr[0])**(-.5)
		#ctype blue pl 0 newr kvsrfit 1110 
		#set kvsrfit=kvsr[0]*(newr/newr[0])**(-1.25)
		#ctype cyan pl 0 newr kvsrfit 1110
		# for grmhd solution a=0.9375 256^2
		# bh06:/fs1/jon/grmhd-a.9375-256by256-fl46-newtop
		#ltype 2 ctype default pl 0 newr kvsrfit 1110 
		set kvsrfit=kvsr[0]*(newr/newr[0])**(-2)
		#ctype yellow pl 0 newr kvsrfit 1110
		# for monopole
		# relativity:/home/jondata/bzsplitnewa.9/run
		ltype 2 ctype default pl 0 newr kvsrfit 1110
		#
		# n=1/4
		#set kvsrfit=1.8*kvsr[0]*(newr/newr[0])**(-(1/4+1))
		#ctype cyan pl 0 newr kvsrfit 1110
		#
		#
		#
		#
atorden  0	#
		set startanim=0
		#set endanim=1000
		set endanim=0500
		define ANIMSKIP 1
		#
		define PLANE (3)
		define WHICHLEV (0)
                set h1='dump'
		set h1b='blob2/image'
		set h3='.eps'
		#
                do ii=startanim,endanim,$ANIMSKIP {
		   set h2=sprintf('%04d',$ii)
		   set _fname=h1+h2
		   set _fname2=h1b+h2+h3
                  define filename (_fname)
                  define filename2 (_fname2)
		  jrdpcf2d $filename
		   #
		   
		  #faraday
		  #stresscalc 1
		  #
		  #
		  if(0){\
		   fieldcalc 0 aphi
		   interpsingle aphi 128 128 20 20
		   readinterp aphi
		   #
		  fdraft
		  device postencap $filename2
		  plc 0 iaphi
		  device X11
		}
		  if(1){\
		  tordencompute
		  fdraft
		  #device postencap $filename2
		  tordenplot
		  #device X11
		}
		  
		}
		#
checkbsq 0              #
		#set absB=sqrt(-bsq*uu0*ud0)
		#set absB=sqrt(bsq*ud0*ud0)
		# below is more like -1.05
		#set absB=sqrt(bsq)
		#
		gcalc2 3 2 0.3 absB absBvsr
		gcalc2 3 2 0.3 absB1 absB1vsr
		gcalc2 3 2 0.3 absB2 absB2vsr
		gcalc2 3 2 0.3 absB3 absB3vsr
		#
		ltype 0 ctype default pl 0 newr absB1vsr 1100
		ltype 0 ctype default pl 0 newr absB2vsr 1110
		ltype 0 ctype default pl 0 newr absB3vsr 1110
		#
		fdraft
		define x1label "r c^2/GM"
		define x2label "|B| [lab frame]"
		ltype 0 ctype default pl 0 newr absBvsr 1100
		set myfit=0.75*absBvsr[0]*(newr/Rin)**(-5/4) if(newr<9)
		set godr=newr if(newr<9)
		#ctype red pl 0 godr myfit 1110
		ltype 2 ctype default pl 0 godr myfit 1110
		#set myfit=0.8*absBvsr[0]*(newr/Rin)**(-1.05)
		#ctype blue pl 0 newr myfit 1110
		#
plotparadiske 0  # Plot of ienc(r) and iencvsr for para w/ B^\theta fixed
		# /raid3/jmckinne/parabhfixed
		# device postencap iencvsrfixedbtheta.eps
		# device postencap iencvsrgrffmhd3.eps
		jrdpcf2d dump0000
		fdraft
		define x1label "r c^2/GM"
		define x2label "I_{enc}(r)"
		torenccompute
		ltype 3 ctype default pl 0 newr ivsr 1100
		#
		jrdpcf2d dump0100
		torenccompute
		torencplot 1
		# device X11
		#
plotparadiskd 0  # Plot of di/dr and iencvsr for para w/ B^\theta fixed
		# /raid3/jmckinne/parabhfixed
		# device postencap didrfixedbtheta.eps
		# device postencap didrgrffmhd3.eps
		jrdpcf2d dump0000
		fdraft
		define x1label "r c^2/GM"
		define x2label "dI_{enc}(r)/dr"
		#
		tordencompute
		ltype 3 ctype default pl 0 newr kvsr 1101 Rin Rout 1E-4 10
		#
		jrdpcf2d dump0100
		#jrdpcf2d dump0050
		tordencompute
		tordenplot 1
		# device X11
		#
checkfield 0    #
		#
		set _n3=1
		set _startx3=0
		set _dx3=2*pi
		gammiegridnew3 gdump
		#
		# check B^r
		#
		setlimits Rin Rout (pi/2*.99) (pi/2*1.01) 0 1
		# MKS -> KS
		set B1ks=B1*dxdxp11
		ctype default plflim 0 x1 r h B1ks 0 110
		#set B1fit=B1ks[0]*r**(-5/4)
		set B1fit=0.106305*r**(-5/4)
		ctype red plflim 0 x1 r h B1fit 0 111
		#
		# check B^\theta
		#
		setlimits Rin Rout (pi/2*.99) (pi/2*1.01) 0 1
		# MKS -> KS
		set B2ks=B2*dxdxp22
		ctype default plflim 0 x1 r h B2ks 0 110
		set indexi=0+3
		set indexj=$ny/2-1+3
		set iii=indexi+indexj*$nx
		set B2fit=B2ks[iii]*(r/r[iii])**(-9/4)
		#set B2fit=-.1*r**(-9/4)
		ctype red plflim 0 x1 r h B2fit 0 111
		#
horizonprob1 0  # problems with quantities across horizon, even in KS!
		# no sharp things in metric
		# no sharp things in connection
		# only sharp thing in maxp, yet LAXF doesn't use it!
		#
		pls 0 B2 001 Rin 2.5 1.55 1.58
		#
		#
		set maxm=(-v1m>0) ? abs(v1m) : 0
		set maxp=(v1p>0) ? abs(v1p) : 0
		set ctop=(maxm>maxp) ? maxm : maxp
		#pls 0 ctop 001 Rin 2.5 1.55 1.58
		#
		pls 0 maxp 001 Rin 2.5 1.55 1.58
		#
		pls 0 maxm 001 Rin 2.5 1.55 1.58
		#
diskBd3calc 0   #
		set innerradius=Rin
		#set innerradius=$rhor
		#set innerradius=3
		set outerradius=Rout
		if($coord==3){\
		       set thin=0
		       set thout=pi
		    }
		if($coord==1){\
		       set thin=-Rout
		       set thout=Rout
		    }
		#
		#
		#jrdpcf2d dump0085
		# gammiegridnew3 gdump
		faraday
		fieldcalc 0 aphi
		#set aphi=aphi/(sin(h))
		rdraft
		set Bd3=gdet*fuu12
		#		#
		set B1hat=sqrt(gv311)*B1
		set B2hat=sqrt(gv322)*B2
		set B3hat=sqrt(gv333)*B3
		set Bp=sqrt(B1hat**2+B2hat**2)
		#
		set alpha=atan(ABS(B1hat)/ABS(B3hat))
		#
		set omegah=r*0+a/(2*$rhor)
		set ratomega=omegaf2/omegah
		# from jrdpcf2d dump9997
		#set omegaf2=u
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		#set light=-gv300+gv330*omegaf2+gv333*omegaf2**2
		#
diskBd3plot1 0  #
		##
		plc 0 lights  001 innerradius outerradius thin thout
		set mylight=newfun
		#
		## REAL PLOTS
		##
		define cres 16
		fdraft
		ctype default
		define BOXCOLOR default
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		#ltype 0 plcergo 0 aphi
		ltype 0 plc 0 aphi  011 innerradius outerradius thin thout
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		ltype 2 plc 0 Bd3  011 innerradius outerradius thin thout
		#
		if(1){\
		define cres 30
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		ltype 3 plc 0 Bp 011 innerradius outerradius thin thout
		#
		define cres 30
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		ltype 3 plc 0 alpha 011 innerradius outerradius thin thout
		#
		define cres 30
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR magenta
		ltype 3 plc 0 ratomega 011 innerradius outerradius thin thout
		#
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		ctype default
		set image[ix,iy]=mylight
		set lev=-1E-15,1E-15,2E-15 levels lev
		lweight 5
		contour
		lweight 3
		#
		}
		#
		#
powerBp 0       #
		#
		ctype default setlimits Rin Rout 2.0 2.5 0 1 plflim 0 x1 r h Bp 0 110
		set myfit=newfun[dimen(newfun)-1]*(newr/newr[dimen(newr)-1])**(-5/4)
		ctype red pl 0 newr myfit 1110
		#
		#
diskBd3plot2 0   #
		#
		#
		#set Routpl=1E3
		#set Routpl=10
		set Routpl=100
		#
		interpsingle Bd3 512 512 Routpl Routpl
		interpsingle aphi 512 512 Routpl Routpl
		interpsingle Bp 512 512 Routpl Routpl
		interpsingle alpha 512 512 Routpl Routpl
		interpsingle lights 512 512 Routpl Routpl
		interpsingle ratomega 512 512 Routpl Routpl
		readinterp Bd3
		readinterp aphi
		readinterp Bp
		readinterp alpha
		readinterp lights
		readinterp ratomega
		#
		plc 0 ilights
		set mylight=newfun
		#
		diskBd3replot2
		#
diskBd3replot2 0 #
		fdraft
		location 7000 31000 3500 31000
		ctype default
		define BOXCOLOR default
		define POSCONTCOLOR cyan
		define NEGCONTCOLOR cyan
		ltype 0 plc 0 iaphi
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		#ltype 2 plc 0 iBd3 010
		#
		define cres 128
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		#ltype 3 plc 0 iBp 010
		#
		define cres 30
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		#ltype 3 plc 0 ialpha 010
		#
		#define cres 30
		#define POSCONTCOLOR magenta
		#define NEGCONTCOLOR magenta
		#ltype 3 plc 0 ratomega 010
		#
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		ctype default
		set image[ix,iy]=mylight
		set lev=-1E-15,1E-15,2E-15 levels lev
		lweight 5
		contour
		lweight 3
		#
		#
omegafdisk 0    #
		smstart
		if(0){\
		       jre mode2.m
		       jrdp dump0040
		       gammiegrid gdump
		    }
		if(1){\
		           jrdp2d dump0000
		           greaddump dumptavg2040v2
		           readg3 tavg32040.txt
		           #jrdpcf2d dump0000
		        }
		#
		faraday
		#
		set delta=r**2-2*r+a**2
		set uu1ks=uu1*r
		set uphibl=uu1ks*(-a/delta)+uu3
		set utbl=uu1ks*(-2*r/delta)+uu0
		set vphibl=uphibl/utbl
		#plc 0 vphibl
		#
		#
		gcalc2 3 2 0.3 vphibl vphiblvsr
		gcalc2 3 2 0.3 omegak omegakvsr
		#
		# pick the divisor
		#set divisor=omegakvsr
		#
		set omegah=a/(2*$rhor)+newr*0
		set divisor=omegah
		#
		#set fdd02bl=fdd02/dxdxp2
		#set fdd23bl=fdd23/dxdxp2
		#
		# ratio (omegaf2) same in bl as in KSP!
		# omegaf1 not like this
		set afdd23=ABS(fdd23)
		set afdd02=ABS(fdd02)
		gcalc2 3 2 0.3 afdd02 afdd02vsr
		gcalc2 3 2 0.3 afdd23 afdd23vsr
		set aomegarat=afdd02vsr/afdd23vsr
		#
		set AA=(r**2+a**2)**2-a**2*delta*sin(h)**2
		set omegahbl=2*a*r/AA
		gcalc2 3 2 0.3 omegahbl omegahvsr
		#
		#
		set keprat=vphiblvsr/divisor
		set godrat=aomegarat/divisor
		set omegahpurerat=omegah/divisor
		set omegahrat=omegahvsr/divisor
		#
		#device postencap omegas.eps
		fdraft
		define x1label "r c^2/GM"
		#define x2label "\Omega/\Omega_K\ \ \Omega_F/\Omega_K\ \ \Omega_{ZAMO}/\Omega_K [all BL]"
		define x2label "\Omega/\Omega_H\ \ \Omega_F/\Omega_H\ \ \Omega_{ZAMO}/\Omega_H [all BL]"
		#
		ctype default pl 0 newr keprat 1001 Rin Rout 0 1.5
		ctype cyan pl 0 newr godrat 1011 Rin Rout 0 1.5
		ctype red pl 0 newr omegahrat 1011 Rin Rout 0 1.5
		ctype green pl 0 newr omegahpurerat  1011 Rin Rout 0 1.5
		#
		ctype blue vertline (LG($rhor))
		#device X11
		#
bubbleplot1 0 #
		fdraft
		location 7000 31000 3500 31000
		ctype default
		define cres 30
		define BOXCOLOR default
		define POSCONTCOLOR red
		define NEGCONTCOLOR red
		ltype 0 plc 0 iaphi
		#
		define POSCONTCOLOR red
		define NEGCONTCOLOR default
		#ltype 2 plc 0 iBd3 010
		#
		define cres 128
		define POSCONTCOLOR green
		define NEGCONTCOLOR green
		#ltype 3 plc 0 iBp 010
		#
		define cres 30
		define POSCONTCOLOR blue
		define NEGCONTCOLOR blue
		# ltype 3 plc 0 ialpha 010
		#
		if(1){\
		define cres 16
		define POSCONTCOLOR magenta
		define NEGCONTCOLOR magenta
		ltype 3 plc 0 iratomega 010
		#
		set lev=0,1,.1 levels lev
		lweight 5
		ctype blue contour
		lweight 3
		#
		set lev=-1,0,.1 levels lev
		lweight 5
		ctype cyan contour
		lweight 3
		}
		#
		if(0){\
		define POSCONTCOLOR default
		define NEGCONTCOLOR default
		ctype default
		set image[ix,iy]=mylight
		set lev=-1E-15,1E-15,2E-15 levels lev
		lweight 3
		contour
		lweight 3
		}
		#
		#
failplot0       #
		# jrdpcf2d dump0050
		# jrdpdebug2d debug0050
		# gammiegridnew3 gdump
		# diskBd3calc
		#
		set rergo=1+sqrt(1-a**2*cos(h)**2)
		set zeroergo=r-rergo
		set zerohorizon=r-$rhor
		#
		plc 0 zeroergo 001 Rin 10 0 pi
		set myergo=newfun
		plc 0 zerohorizon 001 Rin 10 0 pi
		set myhor=newfun
		#
		#
		define POSCONTCOLOR "red"
		define NEGCONTCOLOR "default"
		plc 0 aphi 001 Rin 10 0 pi
		#
		define POSCONTCOLOR "yellow"
		define NEGCONTCOLOR "yellow"
		plc 0 lgftot0 011 Rin 10 0 pi
		#
		define POSCONTCOLOR "blue"
		define NEGCONTCOLOR "blue"
		plc 0 lgftot3 011 Rin 10 0 pi
		#
		set image[ix,iy] = myhor
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype yellow contour
		# 
		set image[ix,iy] = myergo
		set lev=1E-25,1E-25,2E-25
		levels lev
		ctype green contour
power0      0   #
		#
		set esurf=eflem*gdet*$dx2*2*pi if(ti==60)
		set esum=SUM(esurf) print{esum}
		#
power1 0        #
		#
		define x1label "r c^2/GM"
		define x2label "\dot{E}(r)"
		gcalc2 3 0 pi/2 eflem eflemvsr
		ctype default
		# normalize with maximum of B1hat using:
		# plc 0 B1hat 001 90 100 1.50 1.63
		#
		#set myeflemvsr=eflemvsr*(-1)/0.0003866719489
		set myeflemvsr=eflemvsr*(-1)/0.00002
		#
		# /mnt/data2/jon/grffmhd7/run.pt5.omegak_math3
		#set myeflemvsr=eflemvsr*(-1)/0.005766033195
		#
		ctype default pl 0 newr myeflemvsr 1001 $rhor Rout 0 1E3
		set myedot=1.2E3*(1-1/sqrt(newr/(1.3*$rhor)))
		ctype red pl 0 newr myedot 1011 $rhor Rout 0 1E3
		#
		#
		#
		#
failnot 0       #
		define POSCONTCOLOR "default" define NEGCONTCOLOR "red" plc 0 ratomega 001 Rin Rout 0.1 3.04
		define POSCONTCOLOR "yellow" define NEGCONTCOLOR "yellow" plc 0 lgftot3 011 Rin Rout 0.1 3.04
		#
		# apparently failures only at sheet, but overwritten by boundary conditions!
		# sheet appears offset for /raid2/jmckinne/grffmhd7-7
failnot2 0       #
		set thin=(pi/2-pi*0.01)
		set thout=(pi/2+pi*0.01)
		#set thin=0
		#set thout=pi
		define POSCONTCOLOR "default" define NEGCONTCOLOR "red" plc 0 ratomega 001 Rin Rout thin thout
		define POSCONTCOLOR "yellow" define NEGCONTCOLOR "yellow" plc 0 lgftot3 011 Rin Rout thin thout
		#
		#
checksym 0      # check symmetry of how setting boundary conditions
		define POSCONTCOLOR "default" define NEGCONTCOLOR "red"
		pls 0 ratomega 101 Rin Rout thin thout
		#
		set mytj=(tj+0.5) if(ti==0)
		set myratomega=ratomega if(ti==0)
		pl 0 mytj myratomega 0001 120 135 0 1
		points mytj myratomega
		ctype red vertline 128
		#
checksym1 0     #
		# jrdpcf2d dump0001
		# diskBd3calc
		#
		set thin=(pi/2-pi*0.1)
		set thout=(pi/2+pi*0.1)
		#
		plc 0 ratomega 101 Rin 3 thin thout
		#
		# mirrordel ratomega
		plc 0 ratomegadiff 101 Rin 3 thin thout
		#
checksym2 0     #
		#   !ls dumps/dump*
		gogrmhd
		jre symmetry.m
		jre ramesh_disk.m
		jrdpcf2d dump0000
		gammiegridnew3 gdump
		#
		define cres 16
		#
		jrdpcf2d dump0007
		diskBd3calc
		mirrordel ratomega
		set thin=(pi/2-pi*0.1)
		set thout=(pi/2+pi*0.1)
		#plc 0 ratomegadiff 001 Rin 3 thin thout
		plc 0 ratomega 001 Rin 1.9 thin thout
		#
statut 0        #
		set Bd0=B1*gv310+B2*gv320+B3*gv330
		set Bd1=B1*gv311+B2*gv321+B3*gv331
		set Bd2=B1*gv312+B2*gv322+B3*gv332
		set Bd3=B1*gv313+B2*gv323+B3*gv333
		set Bsq=B1*Bd1+B2*Bd2+B3*Bd3
		set vx=-B1*(Bd0+omegaf2*Bd3)/Bsq
		set vy=-B2*(Bd0+omegaf2*Bd3)/Bsq
		set vz=omegaf2-B3*(Bd0+omegaf2*Bd3)/Bsq
		set vsq=    gv311*vx*vx+gv312*vx*vy+gv313*vx*vz
		set vsq=vsq+gv321*vy*vx+gv322*vy*vy+gv323*vy*vz
		set vsq=vsq+gv331*vz*vx+gv332*vz*vy+gv333*vz*vz
		set myutsq=1.0/(-gv300- vsq-2*(vx*gv310+vy*gv320+vz*gv330))
		set ratut=uu0*uu0/myutsq
		#
		plc0 0 ratut 001 Rin 1.9 thin thout
		set lev=$min,0,.00001 levels lev ctype blue contour
		#
		set god=(ratut<0) ? ratut : 0
		#
		jrdpdebug2d debug0010
		plc 0 failrho0
		plc 0 failu0
		#
uno 3           #
		#set thin=0.2
		#set thout2.9
		set thin=0
		set thout=pi
		set myrin=$rhor
		set myrout=1.01*$rhor
		#set myrin=3.4
		#set myrout=3.6
		#
		jrdpcf2d dump$1
		faraday
		set omegah=a/(2.0*$rhor)
		#set omegah=.005
		#
		set rat2=omegaf2/omegah
		set rat1=omegaf1/omegah
		lweight 5 ltype 0 ctype default
		setlimits myrin myrout thin thout 0.2 0.6 plflim 0 x2 r h rat2 1
		#setlimits myrin myrout thin thout 0.2 0.6 plflim 0 x2 r h rat2 0
		#
		if($3==1){\
		       lweight 3 ltype 1 ctype default
		       setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h rat1 0 001
		    }
		#
		jrdpcf2d dump$2
		faraday
		set rat2=omegaf2/omegah
		set rat1=omegaf1/omegah
		if($3==1){\
		       lweight 3 ltype 1 ctype red
		       setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h rat1 0 001
		}
		lweight 5 ltype 0 ctype red
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h rat2 0 001
		#
		set hbz=(h<=pi/2) ? h : (pi-h)
		set parabz=a*(0.25*sin(hbz)**2*(1.0+ln(1.0+cos(hbz)))/(4.0*ln(2)+sin(hbz)**2+(sin(hbz)**2-2*(1+cos(hbz)))*ln(1+cos(hbz))))
		set fakeomegah=a/4
		set ratbz=parabz/fakeomegah
		#set shiftbz=ratbz+0.1
		#
		ltype 0 ctype yellow
		setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h ratbz 0 001
		#ltype 1 ctype yellow
		#setlimits myrin myrout thin thout 0 1 plflim 0 x2 r h shiftbz 0 001
		#
		lweight 3
		#
plotfield 0     #
		#  !ls dumps/dump*
		gogrmhd
		define cres 16
		jrdpcf2d dump0150
		fieldcalc 0 aphi
		set thin=(pi/2-pi*0.1)
		set thout=(pi/2+pi*0.1)
		#plc 0 aphi 001 Rin 1.9 thin thout
		#plc 0 B2 001 Rin 1.9 thin thout
		set omegah=a/(2.0*$rhor)
		faraday
		set ratomega=omegaf2/omegah
		plc 0 ratomega 001 Rin 1.9 thin thout
		#
parafield 0     #
		jrdpcf2d dump0000
		fieldcalc 0 aphi
		#
		set hbz=(h<pi/2) ? h : (pi-h)
		#set AAA=3.27
		set AAA=3.72
		#set AAA=4
		set aphipara=(AAA*0.5*(r*(1-cos(hbz))+2*(1+cos(hbz))*(1-ln(1+cos(hbz))))-4*(1-ln(2))-1.056383967+4.587353075e-08)/1.001/1.00022202255275
		#
		set diffaphi=(aphi-aphipara)/(aphipara+1E-10)
		#
		#plc 0 diffaphi
		#
		plc 0 aphi 001 Rin 10 0 pi
		plc 0 aphipara 011 Rin 10 0 pi
		#
fieldhor0 0     #
		#
		set myrin=$rhor
		set myrout=$rhor*1.001
		set myrin2=40
		set myrout2=41
		set thin=0
		set thout=pi
		#
		#
		jrdpcf2d dump0100
		gammiegridnew3 gdump
		#
		set B1ks=B1*dxdxp11+B2*dxdxp21
		set Bhor=B1ks[ihor+0*$nx]
		print {Bhor}
		#
		setlimits myrin myrout thin thout 0 1
		ctype default
		plflim 0 x2 r h B1ks 0
		#
		setlimits myrin2 myrout2 thin thout 0 1
		ctype red
		plflim 0 x2 r h B1ks 0 001
		#
energycons0 0   # after running energyplot1
		#
		set mflux=rho*uu1
		gcalc2 3 0 pi/2 mflux mfluxvsr
		gcalc2 3 0 pi/2 Tud10 Tud10vsr
		gcalc2 3 0 pi/2 Tud10EM Tud10EMvsr
		gcalc2 3 0 pi/2 Tud10MA Tud10MAvsr
		#
		gcalc2 3 2 0.3 rho rhovsr
		#
fieldbhout0  0  # determine collimation of field from BH
		# /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		#
		jrdpcf2d dump0100
		fieldcalc 0 aphi
		#
		setlimits ($rhor) (1.01*$rhor) 0 pi 0 1
		plflim 0 x2 r h aphi 0
		# dump=100, aphi=2.18 on horizon at equator
		# aphi=1.74 at H/R=0.3
		# aphi=1.34 at H/R=0.6
		#
		setlimits (Rout*0.95) (Rout) 0 pi 0 1
		plflim 0 x2 r h aphi 0 010
		# dump=100, aphi=2.18 thetaj=0.19=10deg
		# aphi=1.74 thetaj=0.17=10deg
		# aphi=1.34 thetaj=0.13=7deg
		#
getjsplot1 0    # jetstructgrffe.eps
		#
		# /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		#
		jrdpcf2d dump0100
		# commented below so can repeat without being slow
		#gammiegridnew3 gdump
		jre punsly.m
		pitchangle0
		#
		getcontour0 1.0
		! cp caphidata.head caphidata.txt /home/jondata/contourdata/
		# then run Matlab joncontournew() script
		# then run getjsplot2
		#
getjsplot2 0    #
		# get contoursks.txt file
		!cp /home/jondata/contourdata/contoursks.txt .
		readcontour0 contoursks.txt
		plotjet0
		#
		#
		#
pitchangle0 0   # /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		# /raid3/jmckinne/ffa.pt5.32
		#
		# jetstructgrffe.eps
		#
		#jre punsly.m
		#
		# jrdp2d dump0100
		# gammiegridnew3 gdump
		#
		set B1o=B1*sqrt(gv311)
		set B2o=B2*sqrt(gv322)
		set B3o=B3*sqrt(gv333)
		set Bpo=sqrt(B1o*B1o+B2o*B2o)
		#
		set pitchanglenew=atan2(ABS(Bpo),ABS(B3o))
		set pitchangle=atan2(ABS(B1o),ABS(B3o))
		#
		fieldcalc 0 aphi
		#
		#plc 0 aphi
		#set lev=1,1.01,.01
		#levels lev
		#ctype blue contour
		#
		#
		#
		#plc 0 pitchangle
		#
		set myuse=(abs(aphi-1.0)<.01*r**0.3) ? 1 : 0
		set mypitchangle=pitchangle if(myuse)
		set myr=r if(myuse)
		#
		#pl 0 myr mypitchangle 1100
		#
		set lorentzgam = uu0*sqrt(-gv300)
		set uurhat=abs(uu1*sqrt(gv311))
		set uuphat=abs(uu3*sqrt(gv333))
		set grR=sqrt(gv333)
		#
		faraday
		#
		# ok, use Matlab
		#
precontour0 0   #
		#
		#jrdp2d dump0100
		gammiegridnew3 gdump
		pitchangle0
		#
getcontour0   1 # run pitchangle0 and gammiegridnew3 gdump and jrdp2d dump0100 first 
		#
		# comparable to figure 9 plot
		# set whichaphi=1.0
		# comparable to GRMHD outermost field line
		# set whichaphi=1.6
		#
		set whichaphi=$1
		#
		set myuse=(tj<$ny/2) ? 1 : 0
		# 6
		set myr=r if(myuse)
		set myh=h if(myuse)
		set myti=ti if(myuse)
		set mytj=tj if(myuse)
		set mytx1=tx1 if(myuse)
		set mytx2=tx2 if(myuse)
		# 1
		set myaphi=aphi if(myuse)
		# 9
		set mypitchangle=pitchangle if(myuse)
		set mylorentzgam=lorentzgam if(myuse)
		set myuurhat=uurhat if(myuse)
		set myuuphat=uuphat if(myuse)
		set mybsq=bsq if(myuse)
		set myB1hat=B1o if(myuse)
		set myB3hat=B3o if(myuse)
		set myB3hat = (abs(myB3hat)>1E29) ? 1E29 : myB3hat
		set mywf2=omegaf2 if(myuse)
		set mygrR=grR if(myuse)
		#
		set mync=6+1+9
		set mynx=$nx
		set myny=$ny/2
		set count=mync*mynx*myny
		#
		define print_noheader 1
		print caphidata.head {whichaphi mync mynx myny count}
		#
                # originally printed out without format specifier and so %g was used, but may need better accuracy in general, so use explicit formats
		# 16 things
		print caphidata.txt '%21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g %21.15g'  \
		    {myr myh myti mytj mytx1 mytx2 myaphi mypitchangle mylorentzgam myuurhat myuuphat mybsq myB1hat myB3hat mywf2 mygrR}
		# ! cp caphidata.head caphidata.txt /home/jon/
		# !scp /home/jon/caphidata.txt jon@relativity:/home/jondata/contourdata/
		#
		#
		#
		#
readcontour0  1 #
		define x1label "r c^2/GM"
		define x2label "Value"
		#
		# !cp /home/jondata/contourdata/contoursks.txt .
		# !scp jon@relativity:/home/jondata/contourdata/contoursks.txt .
		#
		da $1
		lines 1 10000000
		#
		# 1 new radius coordinate + mync
		# 1+6+1+9=17
		read '%g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g %g' \
		    {cc \
		       cr ch cti ctj cx1 cx2 \
		    caphi \
		    cpitchangle clorentzgam cuurhat cuuphat cbsq cB1hat cB3hat cwf2 cgrR}
		#
plotjet0      #
		# like jetstructplot0 in punsly.m
		#
		#	device postencap jetstructgrffe.eps
		#
		defaults
		fdraft
		#
		ticksize 0 0 0 0 
		ctype default window 1 1 1 1
		notation -2 2 -2 2
		erase
		#
		##########################
		#
		# \theta_j
		#
		##########################
		#
		ticksize -1 0 -1 0
		set thin=0.08*180/pi
		set thout=1.0*180/pi
		#
		define lgRin (0)
		#define lgRout (3.5)
		define lgRout (3.0)
		#
		define god1 (LG(thin))
		define god2 (LG(thout))
		limits $lgRin $lgRout $god1 $god2
		ctype default window 2 -3 1 3 box 0 2 0 0
		#
		define x2label "\theta_j [^\circ]"
		#define x1label "r c^2/GM"
		set mych=ch*180/pi
		# below for whichaphi=1.6
		#set myfit=57*(cr/2.8)**(-0.34)
		# below for whichaphi=1.0
		set myfit=44.5*(cr/2.8)**(-0.34)
		# for model at t=0
		#set myfit=52*(cr/2.8)**(-0.375)
		# for paraboloidal model
		#set myfit=54*(cr/2.8)**(-0.48)
		#
		ltype 0 ctype default pl 0 cr mych 1111 Rin Rout thin thout
		ltype 2 ctype default pl 0 cr myfit 1111 Rin Rout thin thout
		ltype 0
		#xla $x1label
		yla $x2label
		#
		#
		##########################
		#
		# \Gamma
		#
		##########################
		#
		ticksize -1 0 -1 0
		limits $lgRin $lgRout 0 1.1
		ctype default window 2 -3 2 3 box 0 2 0 0
		define x2label "\Gamma"
		define x1label "r c^2/GM"
		set myfit=2*(cr/42.5)**(0.6)
		# for para
		#set myfit=1.5*(cr/42.5)**(0.55)
		ltype 0 ctype default pl 0 cr clorentzgam 1111 Rin Rout thin thout
		ltype 2 ctype default pl 0 cr myfit 1111 Rin Rout thin thout
		#xla $x1label
		yla $x2label
		#
		#
		#
		#
		##########################
		#
		# b^2
		#
		##########################
		#
		ticksize -1 0 -1 0
		limits $lgRin $lgRout -7.7 0.9
		ctype default window 2 -3 1 2 box 0 2 0 0
		#
		define x2label "b^2/2"
		define x1label "r c^2/GM"
		#
		set mybsq=cbsq/2
		set myfit=0.5*2.8*(cr/1)**(-2.65)
		ltype 0 ctype default pl 0 cr mybsq 1111 Rin Rout thin thout
		ltype 1 ctype default pl 0 cr myfit 1111 Rin Rout thin thout
		ltype 0
		#xla $x1label
		yla $x2label
		#
		##########################
		#
		# u^r and u^\phi orthonormal
		#
		##########################
		ticksize -1 0 -1 0
		limits $lgRin $lgRout -1 1.4
		ctype default window 2 -3 2 2 box 0 2 0 0
		#
		define x2label "|u^{\hat{r}}| u^{\hat{\phi}}"
		define x1label "r c^2/GM"
		#
		ltype 0 ctype default pl 0 cr cuurhat 1111 Rin Rout thin thout
		ltype 1 ctype default pl 0 cr cuuphat 1111 Rin Rout thin thout
		#
		#xla $x1label
		yla $x2label
		#
		#
		##########################
		#
		# B^\phi orthonormal
		#
		##########################
		ticksize -1 0 -1 0
		limits $lgRin $lgRout -4 0.9
		ctype default window 2 -3 1 1 box 1 2 0 0
		#
		define x2label "B^{\hat{\phi}}"
		# in Gauss
		#
		define x1label "r c^2/GM"
		set myfit=0.29*cr**(-0.7)
		#set myfit=20*cr**(-1.5)
		# para
		#set myfit=0.26*cr**(-0.6)
		ltype 0 ctype default pl 0 cr cB3hat 1111 Rin Rout thin thout
		ltype 2 ctype default pl 0 cr myfit 1111 Rin Rout thin thout
		ltype 0
		xla $x1label
		yla $x2label
		#
		##########################
		#
		# Pitch angle
		#
		##########################
		ticksize -1 0 -1 0
		limits $lgRin $lgRout -2 0.5
		ctype default window 2 -3 2 1 box 1 2 0 0
		#
		#define x2label "\alpha_{\rm pitch} = tan^{-1}(B^{\hat{r}}/B^{\hat{\phi}}) [degrees]"
		define x2label "\alpha_{\rm pitch}"
		#define x2label "(B^{\hat{r}})^2/\rho_{0,disk}"
		#define x2label "tan^{-1}(|B^{\hat{r}}|/|B^{\hat{\phi}}|)"
		#
		set mykink=atan((1.0/(cwf2*cgrR)))
		#
		define x1label "r c^2/GM"
		#
		set mypitch=cpitchangle
		ltype 0 ctype default pl 0 cr mypitch 1111 Rin Rout thin thout
		#
		ltype 2 ctype default pl 0 cr mykink 1110
		ctype default ltype 0
		xla $x1label
		yla $x2label
		#
		# device X11
		# !scp  jetstructgrffe.eps jon@relativity:/home/jondata/
		#
replotjet0   0  #
		jre ramesh_disk.m
		device postencap jetstructgrffe.eps
		plotjet0
		device X11
		!cp jetstructgrffe.eps ~/
		#
		#
		#
bphiaphi0 0     # like returncurr0 in ramesh_selfsim.m
		#
		# bphiaphi.eps
		#
		jrdpcf2d dump0100
		faraday
		fdraft
		set Bd3=-gdet*fuu12
		fieldcalc 0 aphi
		#
		#set myuse=((r>2)&&(r<2.01)) ? 1 : 0
		#set myuse=((r>10)&&(r<10.3)) ? 1 : 0
		set myuse=((r>20)&&(r<20.5)) ? 1 : 0
		set god=SUM(myuse) print {god}
		#
		#set myuse=((r>100)&&(r<105)) ? 1 : 0
		set myBd3=Bd3 if(myuse)
		set myaphi=aphi if(myuse)
		#define x1label "P"
                #define x2label "RB_\phi"
		define x1label "A_\phi"
		define x2label "B_\phi \ \ \Omega_F/\Omega_H"
		#
		ltype 0 ctype default pl 0 myaphi myBd3
		ptype 4 1 points myaphi myBd3
		#
		set omegah=a/(2*$rhor)
		set rat=omegaf2/omegah if(myuse)
		ltype 2 ctype default plo 0 myaphi rat
		#ptype 4 0 points myaphi rat
		#
bphiaphi1 0     # like returncurr0 in ramesh_selfsim.m
		#
		# /mnt/disk/runbhgrmhd/grmhd-a.9375-256by256-fl46-newtop
		#
		# bphiaphigrmhd.eps
		#
		#jrdpcf2d dump0040
		greaddump2 dumptavgnew2
		#
		set _defcoord=0
		faraday
		fdraft
		#set Bd3=-gdet*fuu12
		#set Bd3=absB3*(r*sin(h))**2
		set Bd3=B3*(r*sin(h))**2
		#fieldcalc 0 aphi
		#
		#set myuse=((r>20)&&(r<20.25)) ? 1 : 0
		set myuse=((r>10)&&(r<10.15)) ? 1 : 0
		set god=SUM(myuse) print {god}
		#
		set myBd3=Bd3 if(myuse)
		set myaphi=-aphi if(myuse)
		set nmyBd3=0*myBd3
		set nmyaphi=0*myaphi
		do j=0,$ny-1,1 {\
		       #set nmyBd3[$j] = 0.5*(myBd3[$j]+myBd3[$ny-1-$j])
		       #set nmyBd3[$j] = 0.5*(myBd3[$j]-myBd3[$ny-1-$j])
		       set nmyBd3[$j] = myBd3[$j]
		       set nmyaphi[$j] = 0.5*(myaphi[$j]+myaphi[$ny-1-$j])
		    }
		#define x1label "P"
		#define x2label "RB_\phi"
		define x1label "A_\phi"
		define x2label "B_\phi"
		#
		ltype 0 ctype default pl 0 nmyaphi nmyBd3
		ptype 4 1 points nmyaphi nmyBd3
		#
		#set omegah=a/(2*$rhor)
		#set rat=omegaf2/omegah if(myuse)
		#ltype 2 ctype default plo 0 myaphi rat
		#ptype 4 0 points myaphi rat
		#
		#
jphicut 0       # 
		# /mnt/disk/runbhgrmhd/grmhd-a.9375-256by256-fl46-newtop
		#
		# iphivstheta.eps
		#
		#jrdpcf2d dump0040
		greaddump2 dumptavgnew2
		set _defcoord=0
		#
		fdraft
		#
		define x1label "\theta"
		#y
		define x2label "I_\phi"
		#
		#setlimits 10 10.15 0 pi 0 1
		#plflim 0 x2 r h ju3 0
		torenccompute2
		#
		window 1 1 1 1
		erase
		fdraft
		ltype 0
		ctype default
		#
		limits mytheta ivsthetasum
		window 1 -2 1 2 box 0 2 0 0
		ltype 0 plo 0 mytheta ivsthetasum
		#
		#limits mytheta ivstheta
		#window 1 -2 1 2 box 0 2 0 0
		#ltype 0 plo 0 mytheta ivstheta
		#yla "I_\phi(r=10r_g, \theta)"
		#yla "I_\phi(\theta)"
		yla "\int_0^\theta \ I_\phi d\theta"
		#
		if(0){\
		ltype 1 ctype default lweight 5 vertline 0.6
		ltype 1 ctype default lweight 5 vertline 1.0
		ltype 1 ctype default lweight 5 vertline (pi-0.6)
		ltype 1 ctype default lweight 5 vertline (pi-1.0)
		}
		if(1){\
		ltype 1 ctype default lweight 5 vertline 0.85
		ltype 1 ctype default lweight 5 vertline (pi-0.85)
		}
		#
		#
		torenccompute3
		#
		limits mytheta ivsthetasum
		window 1 -2 1 1 box 1 2 0 0
		ltype 0 plo 0 mytheta ivsthetasum
		#
		set mypow=1
		set myfit=0.5*ivsthetasum[$ny-1]*(1-cos(mytheta)**mypow)
		ltype 2 plo 0 mytheta myfit
		#
		xla "\theta [radians]"
		yla "\int_0^\theta \ I_\phi d\theta"
		#
		if(0){\
		ltype 1 ctype default lweight 5 vertline 0.6
		ltype 1 ctype default lweight 5 vertline 1.0
		ltype 1 ctype default lweight 5 vertline (pi-0.6)
		ltype 1 ctype default lweight 5 vertline (pi-1.0)
		}
		if(1){\
		ltype 1 ctype default lweight 5 vertline 0.75
		ltype 1 ctype default lweight 5 vertline (pi-0.75)
		}
		#
alphagetdump0 0 #
		#
		# gammiegrid gdump
		#
		#jre gtwodavgs.m
		#define startdump 15
		#define enddump 25
		#avgtimegfull 'dump' $startdump $enddump
		#gwritedumpfull dumpavg1525n.txt
		greaddumpfull2 dumpavg1525n.txt
		#
		#greaddumpfull dumptavg2new
		#jrdp2d dump0020
		#jrdp2d dump0025
                #
		#
jrdpheader2dold 1 #
		#
		da dumps/$1
		lines 1 1
		read '%g %d %d %g %g %g %g %d %g %g %g %g %g %g' \
		    {_t _n1 _n2 _startx1 _startx2 _dx1 _dx2 _realnstep _gam _a _R0 _Rin _Rout _hslope}
		#
		set _dt=1
		set _defcoord=0
		set _MBH=1
		set _QBH=0
		set _n3=1
		set _startx3=0
		set _dx3=2*pi
		#
rebeccadata 0   #
		# /data/jon/
		define DOGCALC 0
		jrdp3duold dump0133
		#
		define gam (_gam)
		set p = ($gam - 1.)*u
		set bsq = bu0*bd0 + bu1*bd1 + bu2*bd2 + bu3*bd3
		set ptot = p + bsq/2
		set _rhor = _MBH + sqrt(_MBH**2 - _a**2)
		define rhor (_rhor)
		set area=$dx2*$dx3
		set dV=$dx1*$dx2*$dx3
		#
		riscocalc 0 risco # assumes stuff always goes positive
		riscocalc 1 risco2      # assumes stuff always goes positive
		riscocalc 0 riscoprograde
		riscocalc 1 riscoretrograde
		#
		#
		#
		#
		# geometry stuff
                set Delta=(r**2-2*r+a**2)
                set Sigma=(r**2+(a*cos(h))**2)
                set gv333bl=sin(h)**2*((a**2+r**2)**2-a**2*Delta*sin(h)**2)/Sigma
                set gv311bl=Sigma/Delta
                set gv300bl=-1+2*r/(r**2+a**2*cos(h)**2)
                #
		set gv311old=gv311
		set gv333old=gv333
                set gv300old=gv300
		#
		set dxdxp11=(r-R0)
		set dxdxp33=r*0+1.0
		set dxdxp00=dxdxp11*0+1
		set dxdxp22=dxdxp11*0+1
                set dxdxp12=dxdxp11*0
                set dxdxp21=dxdxp11*0
		#
		set gv333=gv333bl*dxdxp33
		set gv311=gv311bl*dxdxp11**2
                set gv300=gv300bl
		#
		#
                set R=r*sin(h)
                set z=r*cos(h)
                #
                set delta=r**2-2*r+a**2
                set sigma=r**2+a**2*cos(h)**2
                #
                set uu0bl=uu0 - 2*r/delta*(dxdxp11*uu1 + dxdxp12*uu2)
                set uu1bl=dxdxp11*uu1+dxdxp12*uu2
                set uu2bl=dxdxp21*uu1+dxdxp22*uu2
                set uu3bl=-a/delta*(dxdxp11*uu1 + dxdxp12*uu2) + uu3
                #
                set bu0bl=bu0 - 2*r/delta*(dxdxp11*bu1 + dxdxp12*bu2)
                set bu1bl=dxdxp11*bu1+dxdxp12*bu2
                set bu2bl=dxdxp21*bu1+dxdxp22*bu2
                set bu3bl=-a/delta*(dxdxp11*bu1 + dxdxp12*bu2) + bu3
                #
                #
                #
                set vr=uu1bl/uu0bl
                set gammafl=(1+gv311bl/gv300bl*vr**2)**(-1/2)
                set beta=sqrt(-gv311bl/gv300bl)*vr
                set rbooststress=bu2*gammafl*r**2*(-bu0+beta*bu1*sqrt(r/(r-2)))
                #
                set rbooststressortho=rbooststress*sqrt(gv311bl/gv333bl)
                #
                #
jonfiddata 0    #
		# /u/ki/jmckinne/nfsslac/nobackup/usbdisk/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		#
		jrdp2d dump0040
		jrdpheader2dold dump0040
		gammiegrid gdump
		jre punsly.m
		setdxdxpold
		set tk=1,$nx*$ny
		set tk=tk*0
		#
loadmacros 0    #
		gogrmhd
		jre ramesh_disk.m
		jre testworks.jon.m
		jre trans1.m
		#
		#
makeplotasdf 0  #
		device postencap alpha_dump0133.eps
		plotalpha
		device X11
rebecstress0    #
		#
		# jonfiddata
		# rebeccadata
		#
		computeffstress
		#
		#
		#
setalphamag 0   # for single time:
		#
		set trphi=(rho+u+p+bsq)*uu1*ud3-bu1*bd3
		set mdotterm = rho*uu1*ud3
		set trphico=(trphi-mdotterm)
		set alphamag=trphico/(bsq/2)
		set alphamag2=trphico/ptot
		#
		# should really use some criterion for bound material?
		alphaplot0 0.3
		#
		#
alphaplot0 1    #/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		# notice that alphamag is time average of -b^r b_\phi /b^2
		# but this is not dimensionless.
		# dimensionless quantity would be
		# -b^{\hat{r}} b_{\hat{\phi}} / b^2
		# however in KSP defcoord==0, terms nearly cancel to order 1.5X on equator so that figure/data in paper is ok
		#
		#set orthofactor=sqrt(gv311)*sqrt(gn333)
		set orthofactor=sqrt(gv311/gv333)
		set alphamag=alphamag*orthofactor
		set alphamag2=alphamag2*orthofactor
		#
		# device postencap alphamag.eps
		#
		gcalc2 3 2 $1 alphamag alphamagvsr
		gcalc2 3 2 $1 alphamag2 alphamag2vsr
		#
		set alphamagdecor=-bu1*bd3/(bsq/2)*orthofactor
		#set aalphamag=ABS(alphamag)
		gcalc2 3 2 $1 alphamagdecor alphamagdecorvsr
		#gcalc2 3 2 $1 aalphamag aalphamagvsr
		#
		fdraft
		#
		angle 0
		define x1label "r c^2/GM"
		define x2label "\alpha_{\rm mag}"
		#
		ltype 0 ctype default pl 0 newr alphamagvsr 1001 Rin 20 0 1.5
		ltype 1 ctype default pl 0 newr alphamag2vsr 1011 Rin 20 0 1.5
		ltype 2 ctype default pl 0 newr alphamagdecorvsr 1011 Rin 20 0 1.5
		#ltype 2 ctype default pl 0 newr aalphamagvsr 1011 Rin 20 0.01 1.5
		#
		set god=lg(risco)
		ctype default ltype 0 vertline god
		relocate 0.355 0.13
		angle 90 putlabel 5 "ISCO"
		#
		set god=lg(1.5)
		angle 90 ctype default ltype 0 vertline god
		relocate 0.21 0.13
		angle 90 putlabel 5 "MBO"
		angle 0
		#
		#
		#
makepretty0  0  #/mnt/data1/jon/rundata/grmhd-a.9375-456by456-fl46-compareoldutoprim
		greaddumpfull dumptavg2new
		#
		set lrho=LG(rho)
		interpsingle lrho 512 1024 40 40
		readinterp lrho
		plc 0 ilrho
		#
		set god=ilrho if(tj<$ny/2)
		set god2=(god-$min)/($max-$min)*255+1
		set radius=sqrt(x1**2+x2**2) if(tj<$ny/2)
		set god3=(radius<=$rhor) ? 0 : god2
		!rm mygod.dat
		print mygod.dat {god3}
		#
		#
		!rm mygod.r8
		!bin2txt 2 0 0 0 2 512 512 1 1 mygod.dat mygod.r8 f 1
		!dr82 mygod.r8 512 512
		#
		!r8torasjon  0 ~/research/pnmhd/bin/i/john.pal mygod.r8 512 512
		!convert mygod.ras mygod.png
		!cp mygod.png ~/
		# 2392 2392 300dpi
		# 1900 2011 300
makepretty1  0  #
		# after doing ffdeplot0
		#
		plc 0 iBd3 011 0 1E3 -1E3 1E3
		set myBd3=(iBd3-$min)/($max-$min)*254+1
		#
		plc 0 ismallBd3 011 0 innerR -innerR innerR
		set mysmallBd3=(ismallBd3-$min)/($max-$min)*254+1
		#
		#
		print iBd3 {myBd3}
		#
		!rm myBd3.r8
		!bin2txt 2 0 0 0 2 256 256 1 1 iBd3 myBd3.r8 f 1
		#!dr82 myBd3.r8 256 256
		#
		!r8torasjon  0 ~/research/pnmhd/bin/i/john.pal myBd3.r8 256 256
		!convert myBd3.ras myBd3.png
		!cp myBd3.png ~/
		# 427 1056 200dpi
		#
		#
		print ismallBd3 {mysmallBd3}
		#
		!rm mysmallBd3.r8
		!bin2txt 2 0 0 0 2 256 256 1 1 ismallBd3 mysmallBd3.r8 f 1
		#!dr82 mysmallBd3.r8 256 256
		#
		!r8torasjon  0 ~/research/pnmhd/bin/i/john.pal mysmallBd3.r8 256 256
		!convert mysmallBd3.ras mysmallBd3.png
		!cp mysmallBd3.png ~/
		# 427 1058 200dpi
		#
makepretty2  0  #
		# after doing field2overlay0 (fid) or 1 (nfourth)
		# just change final png file name (added fid)
		# don't forget to flip in adobe photoshop
		#
		set flipit=-iBd3final
		plc 0 flipit 011 0 40 -40 40
		define max ($max/5)
		define min ($min/5)
		set myBd3final=(flipit-$min)/($max-$min)*255
		set myBd3final=(myBd3final>255) ? 255 : myBd3final
		set myBd3final=(myBd3final<0) ? 0 : myBd3final
		set radius=sqrt(x1**2+x2**2)
		set myBd3final=((radius<=$rhor)||(radius>40.0)) ? 0 : myBd3final
		#
		#
		set flipit=-iBd3init
		#plc 0 flipit 011 0 40 -40 40
		set myBd3init=(flipit-$min)/($max-$min)*255
		set myBd3init=(myBd3init>255) ? 255 : myBd3init
		set myBd3init=(myBd3init<0) ? 0 : myBd3init
		set radius=sqrt(x1**2+x2**2)
		set myBd3init=((radius<=$rhor)||(radius>40.0)) ? 0 : myBd3init
		#
		#
		#
		#
		print iBd3init {myBd3init}
		#
		!rm myBd3init.r8
		!bin2txt 2 0 0 0 2 512 512 1 1 iBd3init myBd3init.r8 f 1
		#!dr82 myBd3init.r8 512 512
		#
		!r8torasjon  0 ~/bin/john.pal myBd3init.r8 512 512
		!convert myBd3init.ras myBd3initfid.png
		!cp myBd3initfid.png ~/
		# 457 1060 200dpi
		#
		#
		print iBd3final {myBd3final}
		#
		!rm myBd3final.r8
		!bin2txt 2 0 0 0 2 512 512 1 1 iBd3final myBd3final.r8 f 1
		#!dr82 myBd3final.r8 512 512
		#
		!r8torasjon  0 ~/bin/john.pal myBd3final.r8 512 512
		!convert myBd3final.ras myBd3finalfid.png
		!cp myBd3finalfid.png ~/
		# 457 1060 200dpi
		#
		# !scp myBd3finalfid.png myBd3initfid.png jon@relativity:/home/jon/
		#
		# good CON2 math4
		# ffa.001.pt3-3hr (B/C form)
		# ffa.001.pt3-npd
		# ffm3pt632hr_a.9 (BAD)
		# ffm42hr_a.9 (GOOD)
		# ffm4.pt6-3 (BAD)
		# ffm4.pt6.hr.43 (BAD)
		# ffpara001
		# ram's (e.g. ramt22)
		#
		# now ffa.9.pt5.30bc.m4 has all but final ram stuff
		#
		#
		#
		# some other reductions of the GRMHD flow
		#/mnt/disk/runbhgrmhd/grmhd-a.9375-256by256-fl46-newtop
		#
		#greaddumpfull dumptavg2
		greaddump2 dumptavg3
		#jrdp2d dump0020
		gammiegrid gdump
		#
		# for palantiri:/raid1/jmckinne/jetresfl1/
		#
		jrdpcf2d dump0057
		gammiegridnew3 gdump
		#
doavgs4field0 0 #
		#
		define startdump (15)
		define enddump (30)
		avgtimegfull2 'dump' $startdump $enddump
		gwritedump2 dumptavgnew2
		greaddump2 dumptavgnew2
		#
		#
fieldavgs0 0    #
		#
		#define myangle (pi/2)
		define myangle (0.6)
		define typeint (3)
		#
		# only disk+corona
		set inputuse=(lbrel<0) ? 1 : 0
		#set inputuse=(abs(h-0.5*pi)<$myangle) ? 1 : 0
		#
		#
		set absb=sqrt(bsq)/sqrt(0.26)
		gcalc2 $typeint 2 $myangle absb absbvsr
		set aB3hat=ABS(absB3*sqrt(gv333))/sqrt(0.26)
		gcalc2 $typeint 2 $myangle aB3hat aB3hatvsr
		set aB1=ABS(absB1*sqrt(gv311))/sqrt(0.26)
		gcalc2 $typeint 2 $myangle aB1 aB1vsr
		set aB2hat=ABS(absB2*sqrt(gv322))/sqrt(0.26)
		gcalc2 $typeint 2 $myangle aB2hat aB2hatvsr
		#
		#
plotfields0 0   #
		#
		fdraft
		#
		define x1label "r c^2/GM"
		define x2label "B^{\hat{\theta}} B^{\hat{r}} |b| B^{\hat{\phi}} "
		#
		ctype default ltype 0 pl 0 newr aB3hatvsr 1101 Rin Rout 1E-3 1
		set myfit=0.8*aB3hatvsr[0]*(newr/newr[0])**(-5/4)
		#ctype yellow
		#ctype default ltype 1 pl 0 newr myfit 1110
		set myfit=0.6*aB3hatvsr[0]*(newr/newr[0])**(-1.0)
		#ctype red pl 0 newr myfit 1110
		#
		#ctype cyan
		ctype default ctype default ltype 0 pl 0 newr absbvsr 1110
		set myfit=absbvsr[0]*(newr/newr[0])**(-5/4)
		#ctype yellow
		ctype default ltype 1 pl 0 newr myfit 1110
		#
		#ctype red
		ctype default ltype 0 pl 0 newr aB1vsr 1110
		set myfit=1.0*aB1vsr[0]*(newr/newr[0])**(-2.0)
		#ctype green
		ctype default ltype 1 pl 0 newr myfit 1110
		set myfit=1.0*aB1vsr[0]*(newr/newr[0])**(-2.0)
		#ctype red pl 0 newr myfit 1110
		#
		#ctype blue
		ctype default ltype 0 pl 0 newr aB2hatvsr 1110
		set myfit=1.1*aB2hatvsr[0]*(newr/newr[0])**(-5/4)
		#ctype magenta
		ctype default ltype 1 pl 0 newr myfit 1110
		#
		#
		#
otherthings0 0  #
		#
		# other things
		#
		set avr=ABS(uu1/uu0*sqrt(gv311))
		gcalc2 3 2 $myangle avr avrvsr
		#
		set aur=ABS(uu1*sqrt(gv311))
		gcalc2 3 2 $myangle aur aurvsr
		# propto r^{-2}
		#
		set aup=ABS(uu3*sqrt(gv333))
		gcalc2 3 2 $myangle aup aupvsr
		# propto r^{-1.3} inner
		# propto r^{-0.7} outer
		#
		#
		set aomega3=ABS(uu3/uu0)
		gcalc2 3 2 $myangle aomega3 aomega3vsr
		#
		ctype default pl 0 newr aomega3vsr 1100
		set myfit=1/(newr**(3/2)+a)
		ctype red pl 0 newr myfit 1110
		#
		#
		faraday
		set ftp=ABS(fdd23)
		set fm=abs(2*pi*gdet*rho*uu1)
		set grat1=ftp/sqrt(abs(fm))
		gcalc2 3 2 $myangle grat1 grat1vsr
		#
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle ftp ftpvsr
		set grat2=ftpvsr/sqrt(abs(-fmvsr))
		#
		#
		ctype default pl 0 newr grat1vsr
		ctype red pl 0 newr grat2 0010
		#
		#
		jre punsly.m
		setupdxdxpold
		#
		# for diagonal trans of ksp->ks
		set fdd02ks=fdd02/dxdxp2
		set fth=ABS(fdd02ks)
		set grat3=fth/sqrt(abs(fm))
		gcalc2 3 2 $myangle grat3 grat3vsr
		#
		gcalc2 3 2 $myangle fm fmvsr
		gcalc2 3 2 $myangle fth fthvsr
		set grat4=fthvsr/sqrt(abs(-fmvsr))
		#
		#
		ctype default pl 0 newr grat3vsr
		ctype red pl 0 newr grat4 0010
		# propto r^{-1} for $myangle=0.6 or pi/2 (cleaner)
		# expected to be like r^{-1.5} ?
		#
		#
		# gcalc2 3 2 $myangle v1p v1pvsr
		# fast point at r\sim risco (very close)
		#
		#
nearbh0 0       # /mnt/disk/runsaurongrffe/ffm3.pt6.32hr
		# /raid3/jmckinne/ffa.pt5.32 (using this one)
		#
		# nearbh.eps
		#
		#jre punsly.m
		#
		jrdp2d dump0100
		# gammiegridnew3 gdump
		#
		faraday
		fieldcalc 0 aphi
		#
		set lights=gv333*omegaf2**2+2*gv303*omegaf2+gv300
		#
		set horizon=r-$rhor
		#
		set ergo=r - (1+sqrt(1-(a*cos(h))**2))
		#
		# interpolate
		#
		interpsingle aphi 256 256 0 6 -3 3
		interpsingle lights 256 256 0 6 -3 3
		interpsingle horizon 256 256 0 6 -3 3
		interpsingle ergo 256 256 0 6 -3 3
		#
		# get data
		readinterp aphi
		readinterp lights
		readinterp horizon
		readinterp ergo
		#
		# get plot data
		#
		plc 0 iaphi 
		set newaphi=newfun
		plc 0 ilights
		set newlights=newfun
		plc 0 ihorizon
		set newhorizon=newfun
		plc 0 iergo
		set newergo=newfun
		#
		#
		# begin plotting
		#
		fdraft
		define x1label "R c^2/GM"
		define x2label "z c^2/GM"
		#
		define POSCONTCOLOR "default"
                define NEGCONTCOLOR "default"
		ctype default lweight 3 ltype 0
		plc 0 newaphi
		#
		#
		ctype default lweight 5 ltype 0
                set image[ix,iy]=newlights
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3
		#
		ctype default lweight 5 ltype 0
                set image[ix,iy]=newhorizon
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3
		#
		ctype default lweight 5 ltype 0
                set image[ix,iy]=newergo
                set lev=-1E-15,1E-15,2E-15 levels lev
                lweight 5
                contour
                lweight 3

